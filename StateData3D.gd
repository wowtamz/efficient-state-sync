class_name StateData3D
extends StateData
## 3D implementation of the [StateData] class.
## 
## [StateData3D] efficiently encodes 3-dimensional position 
## and rotation as well as state as a [PackedByteArray] for 
## sending it over the network with as little size as possible.

# Byte array structure:
# values:		[map, pos_x, pos_y, pos_z, rot_x, rot_y, rot_z, state]
# datatypes: 	[uint8, float16, float16, float16, float16, float16, float16, uint8]
# max size: 112 bits

# Map bit structure:
# Value 1 if data contains value for that index, 0 if otherwise
# [POSX, POSY, POSZ, ROTX, ROTY, ROTZ, STATE]
# Example: [0, 1, 0, 0, 0, 0, 1] -> Only contains POSY and STATE data

# Value indicies
const POS_X = 1
const POS_Y = 2
const POS_Z = 3
const ROT_X = 4
const ROT_Y = 5
const ROT_Z = 6

## Amount of bits used to represent [member _map]. Equivalent 
## to the maximum possible values which can be encoded into [member _map].
const ENCODED_BITS = 8

func _init(data: Array = [], map: PackedInt32Array = []) -> void:
	super._init(data, map, ENCODED_BITS)

static func from_bytes(bytes: PackedByteArray, encoded_bits: int = ENCODED_BITS) -> StateData:
	return super.from_bytes(bytes, encoded_bits)

static func bits_to_map(n: int, bit_count: int = ENCODED_BITS) -> PackedInt32Array:
	return super.bits_to_map(n, bit_count)
