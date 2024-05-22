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

local function getTagByName(sprite, tagName)
  for _, tag in ipairs(sprite.tags) do
    if tag.name == tagName then
      return tag
    end
  end
  return nil --  no tag with the given name found
end

local function getFramesByRange(sprite, startIndex, endIndex)
  local subset = {}
  for i = startIndex, endIndex do
    subset[#subset + 1] = sprite.frames[i]
  end
  if #subset < 2 then
    app.alert("You must select at least 2 frames")
    return nil
  end
  return subset
end

local function getSelectedFrames(sprite, data)
  if data.applyToAll then  -- apply easing to all frames in the sprite
    return sprite.frames

  elseif data.applyToSelection then  -- apply to the currently selected frames
    local selectedFrames = app.range.frames
    if #selectedFrames >= 2 then
      return selectedFrames
    else
      app.alert("You must select at least 2 frames")
      return nil
    end
    return nil

  elseif data.applyToRange then  -- apply to the specified range of frames by their indices
    local first = data.firstFrame
    local last = data.lastFrame
    return getFramesByRange(sprite, first, last)

  elseif data.applyToTag then
    local selectedTag = assert(getTagByName(sprite, data.toTag), "Invalid sprite tag")
    local first = selectedTag.fromFrame.frameNumber
    local last = selectedTag.toFrame.frameNumber
    return getFramesByRange(sprite, first, last)
  end
end

local function main()
  local sprite = app.activeSprite
  if not sprite then
      return app.alert("There is no active sprite.")
  end

  local frames = sprite.frames
  local totalFrameCount = #frames

  if totalFrameCount < 2 then
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

  local tagOptions = {}
  for _, tag in ipairs(sprite.tags) do
    table.insert(tagOptions, tag.name)
  end
  local hasTags = #tagOptions > 0

  -- prompt user to select an easing function
  local dlg = Dialog("Select Easing Function")
    :label{ text="Easing function" }
    :combobox{ id="easingFunc", options=easingOptions }
    :label{ text="Total animation duration (mS)" }
    :number{ id="duration", text="1000", decimals=0 }

    :separator{ text="Apply to frames" }
    :radio{ id="applyToAll", text="All", selected=true }

    :newrow()
    :radio{ id="applyToSelection", text="Currently Selected" }

    :newrow()
    :radio{ id="applyToRange", text="Range" }
    :number{ id="firstFrame", text="1", decimals=0 }
    :label{ text="to" }
    :number{ id="lastFrame", text=tostring(totalFrameCount), decimals=0 }

    :newrow()
    :radio{ id="applyToTag", text="Tag", enabled=hasTags }
    :combobox{ id="toTag", options=tagOptions }

    :separator()
    :check{ id="addEasingTag", text="Add Easing Tag", selected=true }

    :separator()
    :button{ id="ok", text="OK" }
    :button{ id="cancel", text="Cancel" }
    :show()

  local data = dlg.data
  if not data.ok then
    return  -- bail
  end

  if data.duration <= 0 then
    return app.alert("Total animation duration must be >= 1mS")
  end

  local funcName = data.easingFunc

  if not funcName then
    return app.alert("Invalid easing function selected")
  end

  app.transaction(
    function()
      -- get the frames to which easing should be applied
      local easingFrames = getSelectedFrames(sprite, data)
      if easingFrames == nil then
        return
      end
      local selectedFrameCount = #easingFrames

      if data.addEasingTag then
        local easingTag = sprite:newTag(
          easingFrames[1].frameNumber,
          easingFrames[selectedFrameCount].frameNumber
        )
        easingTag.name = funcName
        easingTag.color = Color{ r=128, g=128, b=255, a=255 }
      end

      local previousFrameDuration = 0  -- initial 'previous duration' (0 for 1st frame)
      for i, frame in ipairs(easingFrames) do
        -- get the portion of the animation frames that has been iterated so far
        local a = (i / selectedFrameCount)
        -- calculate the easing value
        local dt = math.ceil(easings[funcName](a) * data.duration)
        -- calculate and set the current frame duration
        local fd = (dt - previousFrameDuration) / 1000
        frame.duration = fd
        -- store last calculated dt as 'previous duration'
        previousFrameDuration = dt
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
