extends Node

func _ready() -> void:
	test_map_conversion()
	test_map_conversion([3])
	test_map_conversion([1, 2])
	print("Map conversion tests sucessful!")
	
	test_state_data_conversion()
	test_state_data_conversion([4, 0.1, 12.6], [0, 1, 2])
	test_state_data_conversion([0], [3])
	test_state_data_conversion([6.8], [2])
	print("StateData conversion tests sucessful!")

func test_map_conversion(map: PackedInt32Array = [0, 1, 2, 3]):
	var sdata = StateData.new([5.7, 13.5, 0.8, 12.0], map)
	var bits = sdata.map_to_bits()
	var converted_map = StateData.bits_to_map(bits, 4)
	assert(map == converted_map)

func test_state_data_conversion(data: Array = [5, 3.6, 5.5], map: PackedInt32Array = [0, 2, 3]):
	var sdata = StateData.new(data, map)
	var bytes = sdata.to_bytes()
	var from_bytes = StateData.from_bytes(bytes)
	assert(from_bytes.get_data().size() == data.size())
	var step = 0.1
	for i in range(data.size()):
		assert(snappedf(from_bytes.get_data()[i], step) == snappedf(data[i], step))
	assert(from_bytes.get_map() == map)
