# EaseSprite

#### An Aseprite extension
<!-- *current release: [v1.0.0](https://sudo-whoami.itch.io/EaseSprite)* -->

## Latest Changes
- Initial release (pending)

##
This [Aseprite](https://aseprite.org) extension allows you to apply "easing" functions to the timing of animation frames

## Requirements

This extension has been tested on both Windows and Mac OS (specifically, Windows 11 and Mac OS Sonoma 14.3.1)

It is intended to run on Aseprite version 1.3 or later and requires API version 1.3-rc5 (as long as you have the latest version of Aseprite, you should be fine!)

## Features & Usage

Navigate to `Frame > Easing`, select the desired easing function, the desired total duration (in milliseconds), and the frames to which easing should be applied.

The duration of each frame in the sprite will be adjusted accordingly such that the chosen easing function will play out over the given total duration.

### Limitations

The active sprite must have at least two (2) frames in order for an easing function to be applied; sprites with more frames will result in smoother easing

The shortest possible duration for a single frame is 1 millisecond

The longest possible duration for a single frame is 65,535 milliseconds (just over 65 seconds)

Individual frame times are rounded up to the nearest millisecond, which means the animation will complete in *approximately* the specified number of millseconds, but maybe not exactly

> This means that the longest possible animation duration is `65535 * n` where `n` is the number of frames in the animation and no easing (i.e. "Linear" easing) is applied

### The following easing functions are supported:
- "Ease In Circ"
- "Ease Out Circ"
- "Ease In Out Circ"
- "Ease In Cubic"
- "Ease Out Cubic"
- "Ease In Out Cubic"
- "Ease In Expo"
- "Ease Out Expo"
- "Ease In Out Expo"
- "Ease In Quad"
- "Ease Out Quad"
- "Ease In Out Quad"
- "Ease In Quart"
- "Ease Out Quart"
- "Ease In Out Quart"
- "Ease In Quint"
- "Ease Out Quint"
- "Ease In Out Quint"
- "Ease In Sine"
- "Ease Out Sine"
- "Ease In Out Sine"
- "Linear" (effectively no easing; this is functionally identical to selecting `Frame > Constant Frame Rate`)

> [!NOTE]
> You can learn more about these easing functions at [easings.net](https://easings.net)

## Installation
```
TODO
```
<!-- You can download this extension from [itch.io](https://sudo-whoami.itch.io/EaseSprite) as a "pay what you want" tool -->

If you find this extension useful, please consider donating via itch.io to support further development! &hearts;
