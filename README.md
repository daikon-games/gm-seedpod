# Seedpod for GameMaker

![Seedpod Banner Image](/images/banner.png)

**Seedpod** is Daikon Games' collection of the APIs we think GML is missing. Every game Daikon creates includes these functions as our first step.

Seedpod is an opinionated set of APIs meant to be well designed, easy to use, and enhance your GameMaker programming experience. The collection is split into multiple scripts so you can import everything, or just the category of scripts you need!

#### Table of Contents
* [Get Seedpod](#get-seedpod)
* [Seedpod Basics](#seedpod-basics)
* [Seedpod Instances](#seedpod-instances)
* [Seedpod Strings](#seedpod-strings)
* [Licensing](#licensing)

## Get Seedpod
### Manual Package Installation
You can download the latest release of **Seedpod** from the [GitHub Releases page](https://github.com/daikon-games/gm-seedpod/releases), or from our [itch.io page](https://nickavv.itch.io/seedpod-for-gamemaker).

Once you have downloaded the the package, in GameMaker click on the **Tools** menu and select **Import Local Package**. Choose the `.yymps` file you downloaded, and import any or all of the Seedpod scripts.

### GameMaker Marketplace
**Seedpod** can be downloaded directly from the GameMaker Marketplace. Simply visit the [Marketplace page](https://marketplace.yoyogames.com/assets/10806/seedpod) and click the **Add to Account** button.

## Seedpod Basics
Seedpod Basics (`scr_seedpod_basics`) is a collection of general purpose APIs to make GameMaker programming easier and faster.

### echo

This function is a replacement for GameMaker's `show_debug_message` API. It will take data and print it the output console for debugging purposes. However compared to `show_debug_message` it is easier to type, and its string can be templated with other variables for debugging convenience.

```gml
echo(debugString, data...)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`debugString` | String | The debug message to print to the console |
|`data...` | Any | Optional, provide any amount of additional arguments of any datatype. They will be cast to strings and replace occurrences of the string `%s` in `debugString` in order |

#### Returns

N/A

#### Example

```gml
echo("Player x: %s, y: %s", obj_player.x, obj_player.y);
```
Assuming `obj_player` is an instance in the room with coordinates of x = 25, y = 100. The above code will print the following string to the output console:
`Player x: 25, y: 100`

### mod_wrap

This function acts similarly to the `mod`/`%` operator, but it wraps around when provided negative numbers. It is useful for changing selections in a menu, for instance, where you want to wrap around to the other side of the list when you reach either the beginning or the end

```gml
mod_wrap(newValue, listLength)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`newValue` | Integer | The value to perform modulus on |
|`listLength` | Integer | The maximum length of the list of data being operated on |

#### Returns

`newValue mod listLength`, but with the wrapping logic described above applied.

#### Example

```gml
if (keyboard_check_pressed(vk_up)) {
    selection = mod_wrap(selection - 1, array_length(menuItems));
} else if (keyboard_check_pressed(vk_down)) {
    selection = mod_wrap(selection + 1, array_length(menuItems));
}
```
The above code will decrement the `selection` variable when the up keyboard key is pressed, and increment it when the down keyboard key is pressed. By using `mod_wrap`, if the decremented value is less than 0 or the incremented value is less than the length of the array `menuItems`, the variable `selection` will instead loop around to the other side rather than going out of bounds.

### choose_from

This function acts similarly to the built-in `choose`, in that it randomly selects one of a list of items. Unlike `choose` which uses a variable amount of arguments, `choose_from` returns a random item from an array. This can be useful for choosing from a programatically defined set of items rather than a pre-defined one.

```gml
choose_from(choices)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`choices` | Array | An array whose items to randomly choose from |

#### Returns

Any one item from `choices`, selected at random.

#### Example

```gml
var footstepSound = choose_from(footstepSounds);
audio_play_sound(footstepSound, 1, false);
```
Assumes that `footstepSounds` is an array defined elsewhere, containing references to multiple sound files. Every time the code above is run it randomly selects an item from `footstepSounds` and plays it.

### array_remove

This function searches an array for a given value, and removes the first instance of it if found

```gml
array_remove(array, value)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`array` | Array | The array to search |
|`value` | Any | The value to remove from the array, if found |

#### Returns

N/A

#### Example

```gml
var sampleArray = ["A", "B", "C", "D"];
array_remove(sampleArray, "C");
```
After the code above is run, the value of `sampleArray` will be `["A", "B", "D"]`.

### round_to_nearest

This function rounds a numeric value to the nearest multiple of another value.

```gml
round_to_nearest(value, multiple)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`value` | Real | The value to round |
|`multiple` | Real | The multiple to round `value` to |

#### Returns

The multiple of `multiple` closest to `value`.

#### example
```gml
var testVal = 19;
var testVal2 = 30;
var roundedVal = round_to_nearest(testVal, 16);
var roundedVal2 = round_to_nearest(testVal2, 16);
```
After the code above is run, the value of `roundedVal` would be 16. The value of `roundedVal2` would be 32.

### real_truncate

This function returns just the integer portion of a real number.

```gml
real_truncate(real)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`real` | Real | The real value to truncate |

#### Returns

The integer portion of `value`.

#### example
```gml
var testVal = 19.24;
var truncVal = real_truncate(testVal);
```
After the code above is run, the value of `truncVal` would be 19.

### variable_struct_get_or_else

This function streamlines the process of checking for a key's existance in a Struct, and getting the value of that key.

```gml
variable_struct_get_or_else(struct, name, defaultValue)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`struct` | Struct | The struct reference to use |
|`name` | String | The name of the variable to get |
|`defaultValue` | Any | The value to return if the named key does not exist in the struct |

#### Returns

The value of the given key in the given struct, or `defaultValue` if the key does not exist in the struct.

#### example
```gml
var monster1 = {
  type: "monster",
  hp: 15
};
var monster2 = {
  type: "monster",
  hp: 20,
  color: c_red
};
var monsterColor1 = variable_struct_get_or_else(monster1, "color", c_black);
var monsterColor2 = variable_struct_get_or_else(monster2, "color", c_black);
```
After the code above is run, the value of `monsterColor1` would be `c_black`, whereas the value of `monsterColor2` would be `c_red`. You can see that since the key `color` did not exist in the first struct, the default value of `c_black` was returned, and no manual existence checks were needed.

## Seedpod Instances
Seedpod Instances (`scr_seedpod_instances`) is a collection of functions pertaining to live instances in the game at runtime.

### with_tagged

This function lets you quickly apply a function to all instances in the room whose object asset has a given tag.

```gml
with_tagged(tag, lambda)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`tag` | String or Array of Strings | The tag or array of asset tags to operate on |
|`lambda` | Function | A function to run on every instance in the room whose tag or tags matches `tag`

#### Returns

N/A

#### Example

```gml
with_tagged("enemy", function() {
    instance_destroy();
});
```
The above code will destroy every instance in the room whose object has the Asset Tag `enemy`.

### change_sprite

This function changes the caller's `sprite_index` and resets its animation (`image_index`) to frame 0, only if it is not already showing the desired sprite. Lets you easily start all animations from frame 0 without having to write a conditional, you can simply call `change_sprite` every frame.

```gml
change_sprite(newSpriteIndex)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`newSpriteIndex` | Sprite Asset | The desired `sprite_index` for the caller |

#### Returns

N/A

#### Example

```gml
switch (state) {
case playerState.idle:
    change_sprite(spr_player_idle);
    break;
case playerState.running:
    change_sprite(spr_player_running);
    break;
}
```
The above code will change the player's sprite depending on the state of the character controller's state machine. Whenever the state changes, the new animation will start from frame 0.

### center_x

This function returns the horizontal midpoint of an instance, as defined by its `bbox_left` and `bbox_right` values.

```gml
center_x(inst = self)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`inst` | Instance ID or Object Asset | Optional, the instance whose midpoint to find. If not provided, the caller's midpoint will be returned |

#### Returns

An X coordinate representing the exact midpoint of `inst`, as defined by its `bbox` values.

#### Example

```gml
instance_create_layer(center_x(), center_y(), layer, obj_smoke_puff);
```
The above code creates an object at the exact midpoint coordinates of the caller, regardless of the caller's size, sprite, or position.

### center_y

This function returns the vertical midpoint of an instance, as defined by its `bbox_top` and `bbox_bottom` values.

```gml
center_y(inst = self)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`inst` | Instance ID or Object Asset | Optional, the instance whose midpoint to find. If not provided, the caller's midpoint will be returned |

#### Returns

A Y coordinate representing the exact midpoint of `inst`, as defined by its `bbox` values.

#### Example

```gml
instance_create_layer(center_x(), center_y(), layer, obj_smoke_puff);
```
The above code creates an object at the exact midpoint coordinates of the caller, regardless of the caller's size, sprite, or position.


### point_in_bounds

This function tests whether a given X/Y coordinate exists within an instance's bounds, defined by the `bbox_*` internal variables.

```gml
point_in_bounds(pX, pY)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`pX` | Real | The X coordinate to test |
|`pY` | Real | The Y coordinate to test |

#### Returns

True if `pX, pY` falls within the `bbox` bounds of this instance.

#### Example

```gml
if (point_in_bounds(mouse_x, mouse_y)) {
  change_sprite(spr_moused_over);
}
```
The above code tests whether the mouse cursor's room position is over the given instance. If so, it changes the instances sprite using `change_sprite`.

## Seedpod Strings
Seedpod Instances (`scr_seedpod_strings`) is a collection of functions useful for string data manipulation

### string_pad

This function operates similarly to `string_format`, except it lets you define an arbitrary padding character rather than just the space character.

```gml
string_pad(value, amount, padChar)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`value` | Real | The number to be converted to a string |
|`amount` | Integer | The total number of places to pad out `value` to |
|`padChar` | String | The character to use for padding out `value` |

#### Returns

A string containing the number `value` but padded out to `amount` characters minimum using `padChar` to fill out the extra space.

#### Example

```gml
return string_pad(coins, 3, "0");
```
The above code will pad out a `coins` variable to 3 places using the character `0`. For instance, if `coins` is equal to `56` then the above code will return the string `"056"`. Useful for displaying data in game UIs.

## Licensing

Seedpod for GameMaker is licensed under Creative Commons 0. Essentially, you may use it, change it, ship it, and share it with absolutely no restrictions.
