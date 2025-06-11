class_name StateData
## StateData is an efficiently data structure which
## encodes position, rotation and state for sending
## it over the network with as little size as possible.
##
## To save bandwidth only values that change should be
## updated. This requires a map value which determines
## to which attribute each values should be mapped to.
##
## Structure:
## values:		[map, pos_x, pos_y, rot, state]
## datatypes: 	[uint8, float16, float16, float16, uint8]
## max size: 64 bits

var data: PackedFloat32Array = []

func _init(_data: PackedFloat32Array) -> void:
	_data
