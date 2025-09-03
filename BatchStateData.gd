class_name BatchStateData
## Base class for batched state data encoding.
##
## A compact data structure for encoding multiple
## StateData objects for efficient network transmission.

## Contains [StateData] and key pairs.
var _data: Dictionary[int, StateData] # key: int, value: StateData

## Initializes a new [BatchStateData] object with the values in [param data].
func _init(data: Dictionary[int, StateData] = {}) -> void:
	_data = data

## Returns this [BatchStateData] object as a [PackedByteArray].
func to_bytes() -> PackedByteArray:
	var buffer := StreamPeerBuffer.new()
	
	buffer.put_u8(_data.size()) # Write the amount of StateDatas encoded in this byte array
	
	for key in _data.keys():
		var state = _data[key]
		var data = state.to_bytes()
		buffer.put_u16(key) # write the key to buffer
		buffer.put_data(data) # write StateData as byte array to buffer
	
	return buffer.data_array

## Returns a new [BatchStateData] object from [param bytes] passed as an argument.
static func from_bytes(bytes: PackedByteArray, encoded_bits: int = 4) -> BatchStateData:
	var buffer := StreamPeerBuffer.new()
	buffer.data_array = bytes
	
	var data: Dictionary[int, StateData] = {}
	var encoded_state_count = buffer.get_u8()
	
	for i in range(encoded_state_count):
		var key = buffer.get_u16()
		var state = get_state(buffer, encoded_bits)
		data.set(key, state)
		
	return BatchStateData.new(data)

## Reads state data from [param buffer] and returns it as an [StateData] object.
static func get_state(buffer: StreamPeerBuffer, encoded_bits: int) -> StateData:
	var data: Array = []
	var map: PackedInt32Array = StateData.bits_to_map(buffer.get_u8(), encoded_bits)
	for i in map:
		var val: Variant = StateData.value_from_bytes(buffer, i)
		data.append(val)
	
	return StateData.new(data, map, encoded_bits)

## Returns [member _data] attribute of this [BatchStateData].
func get_data() -> Dictionary[int, StateData]:
	return _data
