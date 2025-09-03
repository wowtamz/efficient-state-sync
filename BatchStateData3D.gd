class_name BatchStateData3D
extends BatchStateData
## 3D implementation of the [BatchStateData] class.
##
## A compact data structure for efficiently encoding multiple [StateData3D]
## objects as a [PackedByteArray] for low bandwith network transmission.

## Initializes a new [BatchStateData3D] object with the values in [param data].
func _init(data: Dictionary[int, StateData] = {}) -> void:
	super._init(data)

## Returns a new [BatchStateData] object from [param bytes] passed as an argument.
static func from_bytes(bytes: PackedByteArray, encoded_bits: int = StateData3D.ENCODED_BITS) -> BatchStateData:
	return super.from_bytes(bytes, encoded_bits)
