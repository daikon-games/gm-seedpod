// feather disable all
// feather ignore all

// Seedpod Instances includes useful APIs for interacting with instances in the game at runtime

/// @function with_tagged(_tag, _lambda)
/// @param {String, Array<String>} _tag The tag or array of tags to operate on
/// @param {Function} _lambda A function to be run on the tagged instances
/// @description Runs the lambda function provided on every instance in the room with a given tag
function with_tagged(tag, lambda) {
	var tagged = tag_get_asset_ids(tag, asset_object);
	for (var i = 0; i < array_length(tagged); i++) {
		with (tagged[i]) {
			var boundMethod = method(self, lambda);
			boundMethod();
		}
	}
}

/// @function change_sprite(_newSpriteIndex)
/// @param {Asset.GMSprite} newSpriteIndex The desired sprite_index of the instance
/// @description Changes the instance's sprite_index to the newly provided one, only if it does not already match.
/// If it changes, the image_index will be reset to 0 so the animation begins at that frame.
function change_sprite(_newSpriteIndex) {
	if(sprite_index != _newSpriteIndex) {
		// Only change sprites if necessary, and always start from animation frame 0
		image_index = 0;	
		sprite_index = _newSpriteIndex;
	}
}

/// @function center_x([_inst])
/// @param {ID.Instance} [_inst] The instance whose X midpoint to find. Optional, will use self if not provided
/// @description Returns the midpoint X coordinate of the given instance, calculated using the bbox coordinates
/// @returns {Real}
function center_x(_inst = self) {
	return _inst.bbox_left + (_inst.bbox_right - _inst.bbox_left)/2;
}

/// @function center_y([_inst])
/// @param {ID.Instance} [_inst] The instance whose Y midpoint to find. Optional, will use self if not provided
/// @description Returns the midpoint Y coordinate of the given instance, calculated using the bbox coordinates
/// @returns {Real}
function center_y(_inst = self) {
	return _inst.bbox_top + (_inst.bbox_bottom - inst._bbox_top)/2;
}

/// @function point_in_bounds(_pX, _pY)
/// @param {Real} _pX The X coordinate to check
/// @param {Real} _pY The Y coordinate to check
/// @description Checks whether an X/Y coordinate lies within the bounding box of this instance
/// @returns {Bool} true if the point is within this instance's bbox, false if not
function point_in_bounds(_pX, _pY) {
	return point_in_rectangle(_pX, _pY, bbox_left, bbox_top, bbox_right, bbox_bottom);
}