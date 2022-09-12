// Seedpod Strings includes useful APIs for string data manipulation

/// @function string_split(input, delimiter)
/// @param input The string to split
/// @param delimiter The delimiter character upon which to split the input string
/// @return An array of the parts the input string has been split into
function string_split(input, delimiter) {
	var slot = 0;
	var splits = []; //array to hold all splits
	var str2 = ""; //var to hold the current split we're working on building

	var i;
	for (i = 1; i < (string_length(input)+1); i++) {
	    var currStr = string_copy(input, i, 1);
	    if (currStr == delimiter) {
	        splits[slot] = str2; //add this split to the array of all splits
	        slot++;
	        str2 = "";
	    } else {
	        str2 = str2 + currStr;
	        splits[slot] = str2;
	    }
	}

	return splits;
}

/// @description string_starts_with(input, prefix)
/// @param input The input string to test
/// @param prefix The potential prefix of input string to test for
/// @returns true if the string prefix is the start of the string input, false otherwise
function string_starts_with(input, prefix) {
	// If prefix is longer than input string, it obviously isn't 
	// a prefix to that input string
	if (string_length(prefix) > string_length(input)) {
		return false;
	}

	// test each character of the prefix against against the first characters of the string
	// any that don't match mean that prefix is not a prefix of input
	for (var i = 1; i < string_length(prefix); i++) {
		if (string_char_at(prefix, i) != string_char_at(input, i)) {
			return false;
		}
	}

	// If we've fallen through this far, prefix is a prefix of input
	return true;
}

/// @description string_ends_with(input, suffix)
/// @param input The input string to test
/// @param suffix The potential suffix of input string to test for
/// @returns true if the string suffix is the end of the string input, false otherwise
function string_ends_with(input, suffix) {
	var suffixStart = string_last_pos(suffix, input);
	// If suffx is longer than input string, or does not appear, it obviously isn't 
	// a suffix to that input string
	if (string_length(suffix) > string_length(input) || suffixStart == 0) {
		return false;
	}

	if (suffixStart + string_length(suffix) - 1 != string_length(input)) {
		return false;
	}

	// If we've fallen through this far, suffix is a suffix of input
	return true;
}

/// @function string_pad(value, amount, padChar)
/// @param value The real number to be turned into a string
/// @param amount The total number of characters to show
/// @param padChar The padding character. This will be used to pad value out to amount places.
/// @description As string_format(), but allows for an arbitrary padding character instead of just the space character
function string_pad(value, amount, padChar) {
	return string_replace_all(string_format(value, amount, 0), " ", padChar);
}
