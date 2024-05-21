local easing = {}

-- linear easing function (no easing)
function easing.linear(x)
  return x
end

-- quadratic easing functions
function easing.easeInQuad(x)
  return x^2
end

function easing.easeOutQuad(x)
  return 1 - (1 - x)^2
end

function easing.easeInOutQuad(x)
  return x < 0.5 and 2 * x^2 or 1 - (-2 * x + 2)^2 / 2
end

-- cubic easing functions
function easing.easeInCubic(x)
  return x^3
end

function easing.easeOutCubic(x)
  return 1 - (1 - x)^3
end

function easing.easeInOutCubic(x)
  return x < 0.5 and 4 * x^3 or 1 - (-2 * x + 2)^3 / 2
end

-- quartic easing functions
function easing.easeInQuart(x)
  return x^4
end

function easing.easeOutQuart(x)
  return 1 - (1 - x)^4
end

function easing.easeInOutQuart(x)
  return x < 0.5 and 8 * x^4 or 1 - (-2 * x + 2)^4 / 2
end

-- quintic easing functions
function easing.easeInQuint(x)
  return x^5
end

function easing.easeOutQuint(x)
  return 1 - (1 - x)^5
end

function easing.easeInOutQuint(x)
  return x < 0.5 and 16 * x^5 or 1 - (-2 * x + 2)^5 / 2
end

-- sine easing functions
function easing.easeInSine(x)
  return 1 - math.cos((x * math.pi) / 2)
end

function easing.easeOutSine(x)
  return math.sin((x * math.pi) / 2)
end

function easing.easeInOutSine(x)
  return -(math.cos(math.pi * x) - 1) / 2
end

-- exponential easing functions
function easing.easeInExpo(x)
  return x == 0 and 0 or 2^(10 * x - 10)
end

function easing.easeOutExpo(x)
  return x == 1 and 1 or 1 - 2^(-10 * x)
end

function easing.easeInOutExpo(x)
  if x == 0 then return 0 end
  if x == 1 then return 1 end
  return x < 0.5 and 2^(20 * x - 10) / 2 or (2 - 2^(-20 * x + 10)) / 2
end

-- circular easing functions
function easing.easeInCirc(x)
  return 1 - math.sqrt(1 - x^2)
end

function easing.easeOutCirc(x)
  return math.sqrt(1 - (x - 1)^2)
end

function easing.easeInOutCirc(x)
  return x < 0.5 and (1 - math.sqrt(1 - (2 * x)^2)) / 2 or (math.sqrt(1 - (-2 * x + 2)^2) + 1) / 2
end

-- back easing functions
-- function easing.easeInBack(x)
--   local c1 = 1.70158
--   local c3 = c1 + 1
--   return c3 * x^3 - c1 * x^2
-- end

-- function easing.easeOutBack(x)
--   local c1 = 1.70158
--   local c3 = c1 + 1
--   return 1 + c3 * (x - 1)^3 + c1 * (x - 1)^2
-- end

-- function easing.easeInOutBack(x)
--   local c1 = 1.70158
--   local c2 = c1 * 1.525
--   return x < 0.5 and (2 * x^2 * ((c2 + 1) * 2 * x - c2)) / 2 or ((2 * x - 2)^2 * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2
-- end

-- -- elastic easing functions
-- function easing.easeInElastic(x)
--   local c4 = (2 * math.pi) / 3
--   return x == 0 and 0 or x == 1 and 1 or -(2^(10 * x - 10) * math.sin((x * 10 - 10.75) * c4))
-- end

-- function easing.easeOutElastic(x)
--   local c4 = (2 * math.pi) / 3
--   return x == 0 and 0 or x == 1 and 1 or 2^(-10 * x) * math.sin((x * 10 - 0.75) * c4) + 1
-- end

-- function easing.easeInOutElastic(x)
--   local c5 = (2 * math.pi) / 4.5
--   return x == 0 and 0 or x == 1 and 1 or x < 0.5 and -(2^(20 * x - 10) * math.sin((20 * x - 11.125) * c5)) / 2 or (2^(-20 * x + 10) * math.sin((20 * x - 11.125) * c5)) / 2 + 1
-- end

-- -- bounce easing functions
-- function easing.easeInBounce(x)
--   return 1 - easing.easeOutBounce(1 - x)
-- end

-- function easing.easeOutBounce(x)
--   local n1 = 7.5625
--   local d1 = 2.75
--   if x < 1 / d1 then
--     return n1 * x^2
--   elseif x < 2 / d1 then
--     return n1 * (x - 1.5 / d1) * x + 0.75
--   elseif x < 2.5 / d1 then
--     return n1 * (x - 2.25 / d1) * x + 0.9375
--   else
--     return n1 * (x - 2.625 / d1) * x + 0.984375
--   end
-- end

-- function easing.easeInOutBounce(x)
--   return x < 0.5 and (1 - easing.easeOutBounce(1 - 2 * x)) / 2 or (1 + easing.easeOutBounce(2 * x - 1)) / 2
-- end

return easing
