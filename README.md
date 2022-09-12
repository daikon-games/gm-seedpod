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

### in_array

This function lets you test if an array contains a certain value without having to manually write the code to iterate through the array.

```gml
in_array(value, array)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`value` | Any | The value whose presence to check for in `array` |
|`array` | Array | The array whose values to check |

#### Returns

`true` if `array` contains any occurrences of `value`, `false` if it does not.

#### Example

```gml
// Increment airFrame if the player is in the air
if (in_array(currentState, [playerState.jumping, playerState.falling])) {
    airFrame += 1;
}
```
The above code assumes there is an enumeration of states called `playerState` which describes a state machine for a character controller. It uses `in_array` to test if the current state is in an array describing states where the player is in the air, and increments a frame counter if so. This could be used to measure how long the player was in the air and apply particle effects or fall damage or the like when they land.

### array_shuffle

This function lets you randomly shuffle the values of an existing array

```gml
array_shuffle(array)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`array` | Array | The array whose values to shuffle |

#### Returns

A copy of the input array whose items have been randomly rearranged

#### Example

```gml
// Shuffle the deck of cards
deck = array_shuffle(deck);
```
The above code assumes there is an array named `deck` which contains multiple items. Upon calling `array_shuffle`, the newly shuffled array is reassigned to the same variable, however
if one wanted to preserve the original array the output of `array_shuffle` could be assigned
to a different variable instead.

### array_concat

This function lets you combine two existing arrays

```gml
array_concat(array1, array2)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`array1` | Array | The first input array |
|`array2` | Array | The second input array |

#### Returns

A new array whose values are those of `array1` followed by those of `array2`.

#### Example

```gml
// Combine the inventory and the shoping basket contents
var newInventory = array_concat(inventory, shoppingBasket);
```
The above code assumes there are two pre-existing arrays, one called `inventory` and one called `shoppingBasket`. It creates a new variable, `newInventory` and assigns into it the combined `inventory` and `shoppingBasket` arrays. `newInventory`'s length will be the lengths of `inventory` and `shoppingBasket` combined, and its values will be all of those of `inventory`, followed by all of those of `shoppingBasket`.

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

## Seedpod Strings
Seedpod Instances (`scr_seedpod_strings`) is a collection of functions useful for string data manipulation

### string_split

This function takes a string and splits it into an array of parts, as delimited by a provided delimiter character.

```gml
string_split(input, delimiter)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`input` | String | The string to be split |
|`delimiter` | String | A single-character string to use as the delimiter character for splitting `input` |

#### Returns

An array containing the parts of `input` separated by `delimiter`. `delimiter` is not included in the output.

#### Example

```gml
var columns = "argument,type,description";
var parts = string_split(columns, ",");
```
The above code will split the string `columns` using the comma character. The data contained in the variable `parts` after this code runs will be:
`["argument", "type", "description"]`.

### string_starts_with

This function lets you test whether a string starts with a given prefix.

```gml
string_starts_with(input, prefix)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`input` | String | The string to test |
|`prefix` | String | A string that is the potential prefix of `input` |

#### Returns

`true` if the string `prefix` is at the start of the string `input`, `false` if not.

#### Example

```gml
var testString = "Daikon Games are fun for the whole family";
if (string_starts_with(testString, "Daikon")) {
    echo ("It's a prefix!")
}
```
The above code will print `It's a prefix!` to the output console, because the string `testString` does in fact start with the string `"Daikon"`.

### string_ends_with

This function lets you test whether a string ends with a given suffix.

```gml
string_ends_with(input, suffix)
```
| Argument | Type | Description |
| -------- | ---- | ----------- |
|`input` | String | The string to test |
|`prefix` | String | A string that is the potential suffix of `input` |

#### Returns

`true` if the string `suffix` is at the end of the string `input`, `false` if not.

#### Example

```gml
var testString = "Daikon Games are fun for the whole family";
if (string_ends_with(testString, "family")) {
    echo ("It's a suffix!")
}
```
The above code will print `It's a suffix!` to the output console, because the string `testString` does in fact end with the string `"family"`.


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
