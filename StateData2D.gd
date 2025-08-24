class_name StateData2D
extends StateData

const POS_X = 1
const POS_Y = 2
const ROT = 3

const ENCODED_BITS = 4

func _init(data: Array = [], map: PackedInt32Array = []) -> void:
	super._init(data, map, ENCODED_BITS)

static func bits_to_map(n: int, bit_count: int = ENCODED_BITS) -> PackedInt32Array:
	return super.bits_to_map(n, bit_count)
