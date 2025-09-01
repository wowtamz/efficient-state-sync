class_name StateData2D
extends StateData
## 2D implementation of the [StateData] class.
##
## [StateData2D] efficiently encodes 2-dimensional position 
## and rotation as well as state as a [PackedByteArray] for 
## sending it over the network with as little size as possible.

# Value indicies
const POS_X = 1
const POS_Y = 2
const ROT = 3

## Amount of bits used to represent [member _map]. Equivalent 
## to the maximum possible values which can be encoded into [member _map].
const ENCODED_BITS = 4

func _init(data: Array = [], map: PackedInt32Array = []) -> void:
	super._init(data, map, ENCODED_BITS)

static func bits_to_map(n: int, bit_count: int = ENCODED_BITS) -> PackedInt32Array:
	return super.bits_to_map(n, bit_count)
