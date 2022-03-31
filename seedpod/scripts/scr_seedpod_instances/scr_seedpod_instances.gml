// Seedpod Instances includes useful APIs for interacting with instances in the game at runtime

/// @function with_tagged(tag, lambda)
/// @param tag The tag or array of tags to operate on
/// @param lambda A function to be run on the tagged instances
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

/// @function change_sprite(newSpriteIndex)
/// @param newSpriteIndex The desired sprite_index of the instance
/// @description Changes the instance's sprite_index to the newly provided one, only if it does not already match.
/// If it changes, the image_index will be reset to 0 so the animation begins at that frame.
function change_sprite(newSpriteIndex) {
	if(sprite_index != newSpriteIndex) {
		// Only change sprites if necessary, and always start from animation frame 0
		image_index = 0;	
		sprite_index = newSpriteIndex;
	}
}

/// @function centerX([inst])
/// @param [inst] The instance whose X midpoint to find. Optional, will use self if not provided
/// @description Returns the midpoint X coordinate of the given instance, calculated using the bbox coordinates
function centerX(inst = self) {
	return inst.bbox_left + (inst.bbox_right - inst.bbox_left)/2;
}

/// @function centerY([inst])
/// @param [inst] The instance whose Y midpoint to find. Optional, will use self if not provided
/// @description Returns the midpoint Y coordinate of the given instance, calculated using the bbox coordinates
function centerY(inst = self) {
	return inst.bbox_top + (inst.bbox_bottom - inst.bbox_top)/2;
}
