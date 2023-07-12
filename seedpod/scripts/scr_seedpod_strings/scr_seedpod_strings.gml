// feather ignore all
// feather disable all

/// @function string_pad(_value, _amount, _padChar)
/// @param value {Real} The real number to be turned into a string
/// @param amount {Real} The total number of characters to show
/// @param padChar {String} The padding character. This will be used to pad value out to amount places.
/// @description As string_format(), but allows for an arbitrary padding character instead of just the space character
function string_pad(_value, _amount, _padChar) {
	return string_replace_all(string_format(_value, _amount, 0), " ", _padChar);
}
