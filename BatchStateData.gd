class_name BatchStateData

var _states: Array[StateData]

func _init(states: Array[StateData]) -> void:
	_states = states

func to_bytes() -> PackedByteArray:
	var buffer := StreamPeerBuffer.new()
	
	buffer.put_u8(_states.size()) # Write the amount of StateDatas encoded in this byte array
	
	# TODO write each state to buffer and the respective node id
	
	return buffer.data_array

static func from_bytes(bytes: PackedByteArray) -> BatchStateData:
	var buffer := StreamPeerBuffer.new()
	buffer.data_array = bytes
	
	var array: Array[StateData] = []
	
	var encoded_state_count = buffer.get_u8()
	
	# TODO read each state from the buffer
	
	for i in range(encoded_state_count):
		pass
	return BatchStateData.new(array)

func get_states() -> Array[StateData]:
	return _states
