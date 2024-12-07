-- NOTE: some of these formulae don't work as expected and provide negative output values
local easing = {}

function easing.linear(x)
  return x
end

function easing.easeInQuad(x)
  return math.sqrt(x)
end

function easing.easeOutQuad(x)
  return 1 - math.sqrt(1 - x)
end

function easing.easeInOutQuad(x)
  return x < 0.5 and math.sqrt(x / 2) or 1 - math.sqrt((1 - x) / 2)
end

function easing.easeInCubic(x)
  return x^(1/3)
end

function easing.easeOutCubic(x)
  return 1 - (1 - x)^(1/3)
end

function easing.easeInOutCubic(x)
  return x < 0.5 and (x / 4)^(1/3) or 1 - ((1 - x) * 2)^(1/3) / 2
end

function easing.easeInQuart(x)
  return x^(1/4)
end

function easing.easeOutQuart(x)
  return 1 - (1 - x)^(1/4)
end

function easing.easeInOutQuart(x)
  return x < 0.5 and (x / 8)^(1/4) or 1 - ((1 - x) * 2)^(1/4) / 2
end

function easing.easeInQuint(x)
  return x^(1/5)
end

function easing.easeOutQuint(x)
  return 1 - (1 - x)^(1/5)
end

function easing.easeInOutQuint(x)
  return x < 0.5 and (x / 16)^(1/5) or 1 - ((1 - x) * 2)^(1/5) / 2
end

function easing.easeInSine(x)
  return math.acos(1 - x) * (2 / math.pi)
end

function easing.easeOutSine(x)
  return math.asin(x) * (2 / math.pi)
end

function easing.easeInOutSine(x)
  return x <= 0.5 and math.acos(1 - 2 * x) / math.pi or 1 - math.acos(2 * x - 1) / math.pi
end

function easing.easeInExpo(x)
  return x == 0 and 0 or (math.log(x) / math.log(2) + 10) / 10
end

function easing.easeOutExpo(x)
  return x == 1 and 1 or -(math.log(1 - x) / math.log(2)) / 10
end

function easing.easeInOutExpo(x)
  if x == 0 then return 0 end
  if x == 1 then return 1 end
  return x < 0.5 and (2^(20 * x - 10) - 1) / (2^10 - 1) / 2 or (2 - 2^(-20 * (x - 0.5))) / (2 * (2^10 - 1))
end

function easing.easeInCirc(x)
  return math.sqrt(1 - (1 - x)^2)
end

function easing.easeOutCirc(x)
  return 1 - math.sqrt(1 - x^2)
end

function easing.easeInOutCirc(x)
  return x < 0.5 and math.sqrt(1 - (1 - 2 * x)^2) / 2 or (1 - math.sqrt(1 - (2 * (1 - x))^2)) / 2 + 0.5
end

return easing
