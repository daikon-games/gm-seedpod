// Seedpod Basics includes general purpose APIs that make GameMaker programming easier

/// @function echo(debugString, data...)
/// @param debugString The string to print to the console
/// @param data Variable data to substitute into the console string. Will each be cast to strings
/// @description Enhanced debug logging. Replaces show_debug_message with something easier to type
/// and which replaces any "%s" found in the string with your debug data.
function echo(debugString) {
	var result = debugString;
	if (argument_count > 1) {
		for (var i = 1; i < argument_count; i++) {
			result = string_replace(result, "%s", string(argument[i]));
		}
	}
	show_debug_message(result);
}

/// @function mod_wrap(value, listLength)
/// @param value The value to perform modulus on
/// @param listLength The maximum size of the list to wrap 
/// @description As mod, but deals with negative numbers so it can be used for wrapping around lists
function mod_wrap(newValue, listLength) {
	return ((newValue) % listLength + listLength) % listLength;
}

/// @function in_array(value, array)
/// @param value The value to check for the presence of in the array
/// @param array The array whose values to check
/// @returns true if value matches any value in array, false otherwise
function in_array(value, array) {
	for(var i = 0; i < array_length(array); i++) {
		if (value == array[i]) {
			return true;
			break;
		}
	}
	return false;
}

/// @function array_shuffle(array)
/// @param array The input array
/// @returns A copy of the input array whose items have been randomly rearranged
function array_shuffle(array) {
	var length = array_length(array);
	var result = array_create(length);
	array_copy(result, 0, array, 0, length);
	for (var i = 0; i < length; i += 1) {
	    var j = irandom_range(i, length - 1);
	    if (i != j)  {
	        var k = result[i];
	        result[i] = result[j];
	        result[j] = k;
	    }
	}
	return result;
}

/// @function array_concat(array1, array2)
/// @param array1 The first array
/// @param arrat2 The second array
/// @returns A new array whose values are those of array1 followed by those of array2
function array_concat(array1, array2) {
	var length1 = array_length(array1);
	var length2 = array_length(array2);
	var result = array_create(length1 + length2);
	array_copy(result, 0, array1, 0, length1);
	array_copy(result, length1, array2, 0, length2);
	return result;
}

/// @function choose_from(choices)
/// @param choices An array containing values from which to randomly choose
/// @description as choose() but with an array of options rather than varargs
function choose_from(choices) {
	return choices[irandom_range(0, array_length(choices) - 1)];
}