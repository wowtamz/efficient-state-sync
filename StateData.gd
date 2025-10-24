class_name StateData
## Base class for state data encoding.
##
## A compact data structure for encoding state
## and any other attributes for network transmission.
## It aims to minimize size to reduce bandwidth usage
## by updating only values that have changed, a "map" 
## value is used to indicate which attributes the provided 
## values correspond to.

# Byte array structure:
#   Values:    [map, state, val_1, val_2, ..., val_n]
#   Types:     [uint8, uint8, float16, float16, ...,  float16]
#
# The map is a bitstring (array of 0s and 1s) where each position 
# corresponds to an index in the data array:
#   - '1' means the value is present in the data
#   - '0' means the value is missing
#
# Examples:
#   Data: [state, val_1, val_2]   Map: [1, 1, 1]   # all values present
#   Data: [val_1]                 Map: [0, 1, 0]   # only val_1 present
#   Data: [state, val_2]          Map: [1, 0, 1]   # state and val_2 present

## Default data type.
const DEFAULT_TYPE = "half"
## Index of the time value.
const TIME = 0
## Index of the state value.
const STATE = 1

static var _types = {
	TIME: "u16",
	STATE: "u8",
}

## Contains the state values.
var _data: Array = []
## Indicies of the state values
var _map: PackedInt32Array = []

## Creates a new [StateData] object with passed values for [member StateData.data] and [member StateData.map]
## with [member StateData.map] resized to a length of [param _encoded_bits].
func _init(data: Array = [], map: PackedInt32Array = [], _encoded_bits: int = 5) -> void:
	_data = data
	_map = map.slice(0, _encoded_bits)

## Appends an [param index] and the [param value] to the
## [member StateData.map] and [member StateData.data]
## attributes respectively
func append(index: int, value: Variant):
	_map.append(index)
	_data.append(value)

func get_value(value_index: int) -> Variant:
	var data_index = _map.find(value_index)
	return _data[data_index] if data_index >= 0 else null

func equals(state: StateData) -> bool:
	return _data == state.get_data() and _map == state.get_map()

## Returns true if [member StateDate.data] contains at least an element.
func has_data() -> bool:
	return not _data.is_empty()

## Returns [member _data] attribute of this [StateData].
func get_data() -> Array:
	return _data

## Returns [member _map] attribute of this [StateData]
func get_map() -> PackedInt32Array:
	return _map

## Returns this [StateData] as a [PackedByteArray].
func to_bytes() -> PackedByteArray:
	var buffer := StreamPeerBuffer.new()
	var map_as_bits = map_to_bits()
	buffer.put_u8(map_as_bits)
	
	for i in range(_data.size()):
		var key = _map[i]
		var type = _types.get(key, DEFAULT_TYPE)
		var value = _data[i]
		if type_string:
			buffer.call("put_%s" % type, value)
	return buffer.data_array

## Returns [param bytes] as a new [StateData] object. [br]
## With [param encoded_bits] specifying the maximum possbile values encoded in [member StateDate.map].
static func from_bytes(bytes: PackedByteArray, encoded_bits: int = 5) -> StateData:
	var buffer := StreamPeerBuffer.new()
	buffer.data_array = bytes
	var decoded_map: PackedInt32Array = StateData.bits_to_map(buffer.get_u8(), encoded_bits)
	var decoded_data: Array = []
	for i in decoded_map:
		var val: Variant = value_from_bytes(buffer, i)
		decoded_data.append(val)
	
	return StateData.new(decoded_data, decoded_map, encoded_bits)

static func value_from_bytes(buffer: StreamPeerBuffer, index: int) -> Variant:
	var type = _types.get(index, DEFAULT_TYPE)
	var val: Variant = buffer.call("get_%s" % type)
	#var val: Variant = buffer.get_u8() if index == STATE else buffer.get_half()
	if typeof(val) == TYPE_FLOAT:
		var step = 0.1
		# Round decoded float values to the nearest multiple of step
		val = snappedf(val, step)
	return val

## Converts [int]-bitstring into a [PackedInt32Array] with data indicies.
static func bits_to_map(n: int, bit_count: int) -> PackedInt32Array:
	var res: PackedInt32Array = []
	for i in range(bit_count):
		var bit = (n >> i) & 1
		if bit:
			res.append(i)
	return res

## Converts [PackedInt32Array] with data indicies into a [int]-bitstring.
func map_to_bits() -> int:
	var res: int = 0
	for val in _map:
		res = write_bit(res, val, 1)
	return 0 if _map.is_empty() else res

## Writes a bit [param val] to an [int] [param to] at index [param bit_index].
func write_bit(to: int, bit_index: int, val: int) -> int:
	if val == 1:
		to |= (val << bit_index)
	elif val == 0:
		to &= ~(1 << bit_index)
	else:
		printerr("Can only set bit value to 0 or 1.")
	return to
