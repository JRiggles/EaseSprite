# EaseSprite

#### An Aseprite extension
*current release: [v1.0.0](https://sudo-whoami.itch.io/EaseSprite)*

## Latest Changes
- Initial release

##
This [Aseprite](https://aseprite.org) extension allows you to apply "easing" functions to the timing of animation frames


## Example

The sprite below consists of 24 frames, and the position of the red ball is moved up by 1px each frame

> [!IMPORTANT]
> This extension won't animate your sprites for you, it just applies easing to the *duration* of each frame

<img src="screenshots/linear.gif" />

#### Linear Easing (a.k.a no easing :wink:)

<img src="screenshots/easeInQuad.gif" />

#### Ease In Quad

## Requirements

This extension has been tested on both Windows and Mac OS (specifically, Windows 11 and Mac OS Sonoma 14.3.1)

It is intended to run on Aseprite version 1.3 or later and requires API version 1.3-rc5 (as long as you have the latest version of Aseprite, you should be fine!)

## Features & Usage

Navigate to `Frame > Easing`, select the desired easing function, the desired total duration (in milliseconds), and the frames to which easing should be applied.

<img src="screenshots/menu selection.png" />

You can apply the easing function to all frames in the sprite, the currently selected range of frames, a range of frames by their indices, or by an existing tag.

The **Tag** selection option will be disabled if the active sprite has no tags.

The duration of each frame in the selection will be adjusted accordingly such that the chosen easing function will play out over the given total duration.



<img src="screenshots/main dialog.png" />


### Limitations

The active sprite must have at least two (2) frames in order for an easing function to be applied; sprites with more frames will result in smoother easing

You must select at least two (2) framse when selecting a range of frames

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

<img src="screenshots/easing menu.png" />

> [!NOTE]
> You can learn more about these easing functions at [easings.net](https://easings.net)

When the `Add Easing Tag` option is checked (default) the selected frames will be tagged with the name of the chosen easing function like so:

<img src="screenshots/easing tag.png" />

## Installation

You can download this extension from [itch.io](https://sudo-whoami.itch.io/EaseSprite) as a "pay what you want" tool

If you find this extension useful, please consider donating via itch.io to support further development! &hearts;
