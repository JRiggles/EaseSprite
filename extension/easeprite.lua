--[[
MIT LICENSE
Copyright © 2024 John Riggles [sudo_whoami]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

-- stop complaining about unknown Aseprite API methods
---@diagnostic disable: undefined-global
-- ignore dialogs which are defined with local names for readablity, but may be unused
---@diagnostic disable: unused-local

local preferences = {} -- create a global table to store extension preferences
local easings = require("easings")

local function selectFrameRange()
  return  -- TODO
end

local function main()
  local sprite = app.activeSprite
  if not sprite then
      return app.alert("There is no active sprite.")
  end
  local frames = sprite.frames
  local numFrames = #frames

  if numFrames < 2 then
    return app.alert("At least two (2) frames are required (the more the better!)")
  end

  -- get names of easing options from the easings module
  local easingOptions = {}
  for name, _ in pairs(easings) do
    if name ~= "getEasingFunction" then
      table.insert(easingOptions, name)
    end
  end

  table.sort(easingOptions)

  -- prompt user to select an easing function
  local dlg = Dialog("Select Easing Function")
    :label{ text="Easing function" }
    :combobox{ id="easingFunc", options=easingOptions }
    :label{ text="Total animation duration (mS)" }
    :number{ id="duration", text="1000", decimals=0 }

    :separator{ text="Apply to frames" }
    :radio{ id="applyAll", text="All", selected=true, onclick=selectFrameRange }

    :newrow()
    :radio{ id="applyRange", text="Range", onclick=selectFrameRange }
    :number{ id="firstFrame", text="1", decimals=0 }
    :label{ text="to" }
    :number{ id="lastFrame", text=tostring(numFrames), decimals=0 }

    :newrow()
    :radio{ id="applySelected", text="Selected", onclick=selectFrameRange }

    :separator()
    :button{ id="ok", text="OK" }
    :button{ id="cancel", text="Cancel" }
    :show()

  local data = dlg.data
  if not data.ok then
    return  -- bail
  end

  if data.duration <= 0 then
    app.alert("Total animation duration must be >= 1mS")
    return  -- bail
  end

  local funcName = data.easingFunc

  if not funcName then
    return app.alert("Invalid easing function selected")
  end

  app.transaction(
    function()
      local pd = 0  -- initial 'previous duration' (0 for 1st frame)
      for i, frame in ipairs(sprite.frames) do
        local a = (i / numFrames)  -- a is the % completion of the full animation
        local dt = math.ceil(easings[funcName](a) * data.duration)
        local fd = (dt - pd) / 1000
        frame.duration = fd
        pd = dt  -- store last calculated dt as 'previous duration'
      end
    end
  )
  app.refresh()
end

-- Aseprite plugin API stuff...
---@diagnostic disable-next-line: lowercase-global
function init(plugin) -- initialize extension
  preferences = plugin.preferences -- update preferences global with plugin.preferences values

  plugin:newCommand {
    id = "easing",
    title = "Easing",
    group = "cel_frames",
    onclick = main -- run main function
  }
end

---@diagnostic disable-next-line: lowercase-global
function exit(plugin)
  plugin.preferences = preferences -- save preferences
  return nil
end
