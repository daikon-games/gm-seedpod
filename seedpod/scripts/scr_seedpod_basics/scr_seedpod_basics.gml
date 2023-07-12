// feather ignore all
// feather disable all

// Seedpod Basics includes general purpose APIs that make GameMaker programming easier

/// @function echo(_debugString, _data...)
/// @param {String} _debugString The string to print to the console
/// @param {Any} _data Variable data to substitute into the console string. Will each be cast to strings
/// @description Enhanced debug logging. Replaces show_debug_message with something easier to type
/// and which replaces any "%s" found in the string with your debug data.
function echo(_debugString) {
	var _result = _debugString;
	if (argument_count > 1) {
		for (var i = 1; i < argument_count; i++) {
			_result = string_replace(_result, "%s", string(argument[i]));
		}
	}
	show_debug_message(_result);
}

/// @function mod_wrap(_newValue, _listLength)
/// @param {Real} _newValue  The value to perform modulus on
/// @param {Real} _listLength The maximum size of the list to wrap 
/// @description As mod, but deals with negative numbers so it can be used for wrapping around lists
function mod_wrap(_newValue, _listLength) {
	return ((_newValue) % _listLength + _listLength) % _listLength;
}

/// @function choose_from(_choices)
/// @param {Array<Any>} _choices An array containing values from which to randomly choose
/// @description as choose() but with an array of options rather than varargs
function choose_from(_choices) {
	return _choices[irandom_range(0, array_length(_choices) - 1)];
}

/// @function array_remove(_array, _value)
/// @param {Array<Any>} _array The array to operate on
/// @param {Any} _value The value to find and remove within the array
/// @description Searches an array for a specific value, and removes the first instance of it if found
function array_remove(_array, _value) {
	var _index = array_get_index(_array, _value);
	if (_index != -1) {
		array_delete(_array, _index, 1);
	}
}

/// @function round_to_nearest(_value, _multiple)
/// @param {Real} _value The value to round
/// @param {Real} _multiple The number to round value to the nearest multiple of
/// @description Rounds value to the nearest multiple.
function round_to_nearest(_value, _multiple) {
	/// Adapted from stackoverflow answer by user siddhartha agarwal
	/// https://stackoverflow.com/questions/29557459/round-to-nearest-multiple-of-a-number
	var _smallerMultiple = round(_value / _multiple) * _multiple;
    var _largerMultiple = _smallerMultiple + _multiple;

    // Return of closest of two
    return (_value - _smallerMultiple >= _largerMultiple - _value) ? _largerMultiple : _smallerMultiple;
}

/// @function real_truncate(_real)
/// @param {Real} _real The number to truncate
/// @description Takes a real number and returns just the integer portion
/// @returns {Real} The integer portion of a real number, positive or negative
function real_truncate(_real) {
	if (_real < 0) {
		return ceil(_real);
	} else {
		return floor(_real);
	}
}

/// @function variable_struct_get_or_else(_struct, _name, _defaultValue)
/// @param {Struct} _struct The struct reference to use
/// @param {String} _name The name of the variable to get
/// @param {Any} _defaultValue The value to return if the named key does not exist in the struct
/// @description Streamlines the process of checking for a key's existance in a struct before returning either the value found, or a default value if the key did not exist in the struct
/// @returns {Any} The value with the given key in the struct, or _defaultValue if the key does not exist in the struct
function variable_struct_get_or_else(_struct, _name, _defaultValue) {
	if (!variable_struct_exists(_struct, _name)) {
		return _defaultValue;
	} else {
		return variable_struct_get(_struct, _name);
	}
}