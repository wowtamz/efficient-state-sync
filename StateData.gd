class_name StateData
## StateData is an efficiently data structure which
## encodes position, rotation and state for sending
## it over the network with as little size as possible.
##
## To save bandwidth only values that change should be
## updated. This requires a map value which determines
## to which attribute each values should be mapped to.
##
## Byte array structure:
## values:		[map, pos_x, pos_y, rot, state]
## datatypes: 	[uint8, float16, float16, float16, uint8]
## max size: 64 bits

## Map bit structure:
## Value 1 if data contains value for that index, 0 if otherwise
## [POSX, POSY, ROT, STATE]
## Example: [0, 1, 0, 0] -> Only contains POSY data 

const POSX = 0
const POSY = 1
const ROT = 2
const STATE = 3

var data: PackedFloat32Array = []
var map: PackedInt32Array = []

func _init(_data: PackedFloat32Array, _map: PackedInt32Array = []) -> void:
	data = _data
	map = _map

func map_to_bits() -> int:
	var result: int = 0
	for val in map:
		result = write_bit(result, val, 1)
	return 0 if map.is_empty() else result

func write_bit(to: int, bit_index: int, val: int) -> int:
	if val == 1:
		to |= (val << bit_index)
	elif val == 0:
		to &= ~(1 << bit_index)
	else:
		printerr("Can only set bit value to 0 or 1.")
	return to
