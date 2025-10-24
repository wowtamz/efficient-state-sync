extends Node

## Runs unit tests sequentially.
func _ready() -> void:
	test_map_conversion()
	test_map_conversion([3])
	test_map_conversion([4])
	test_map_conversion([1, 2])
	print("Map conversion tests successful!")
	
	test_state_data_conversion()
	test_state_data_conversion([4, 0, 12.6], [0, 1, 2])
	test_state_data_conversion([0], [3])
	test_state_data_conversion([6.8], [2])
	print("StateData conversion tests successful!")
	
	test_state_data_2d_conversion()
	test_state_data_conversion([4, 0, 12.6], [0, 1, 2])
	test_state_data_conversion([1, 2.0, 78.5], [1, 2, 3])
	test_state_data_conversion([69.5], [4])
	test_state_data_conversion([20, 12.5], [0, 4])
	
	print("StateData conversion tests successful!")
	
	test_state_data_3d_conversion()
	test_state_data_3d_conversion([5, 4.5, 78.2, 12.9], [0, 2, 4, 6])
	test_state_data_3d_conversion([1, 41.5, 8.2, 52.9], [1, 2, 5, 6])
	print("StateData3D conversion tests successful!")
	
	test_batch_state_data()
	print("BatchStateData tests successful")

## Tests the conversion of the map [Array] to a bit-string as an [int].
func test_map_conversion(map: PackedInt32Array = [0, 1, 2, 3], bit_count: int = 5):
	var sdata = StateData.new([5.7, 13.5, 0.8, 12.0], map)
	var bits = sdata.map_to_bits()
	var converted_map = StateData.bits_to_map(bits, bit_count)
	assert(map == converted_map)

## Tests the conversion of [StateData] objects to PackedByteArrays and vice versa.
func test_state_data_conversion(data: Array = [5, 3.6, 5.5], map: PackedInt32Array = [0, 2, 3]):
	var sdata = StateData.new(data, map)
	var bytes = sdata.to_bytes()
	var from_bytes = StateData.from_bytes(bytes)
	assert(from_bytes.get_data().size() == data.size())
	var step = 0.1
	for i in range(data.size()):
		assert(snappedf(from_bytes.get_data()[i], step) == snappedf(data[i], step))
	assert(from_bytes.get_map() == map)

## Tests the conversion of [StateData2D] objects to PackedByteArrays and vice versa.
func test_state_data_2d_conversion(data: Array = [5, 3.6, 5.5], map: PackedInt32Array = [0, 2, 3]):
	var sdata = StateData2D.new(data, map)
	var bytes = sdata.to_bytes()
	var from_bytes = StateData2D.from_bytes(bytes)
	assert(from_bytes.get_data().size() == data.size())
	var step = 0.1
	for i in range(data.size()):
		assert(snappedf(from_bytes.get_data()[i], step) == snappedf(data[i], step))
	assert(from_bytes.get_map() == map)

## Tests the conversion of [StateData3D] objects to PackedByteArrays and vice versa.
func test_state_data_3d_conversion(data: Array = [5, 0, 0.2, 0.3, 0.4, 0.5, 0.6], map: PackedInt32Array = [0, 1, 2, 3, 4, 5, 6]):
	var sdata = StateData3D.new(data, map)
	var bytes = sdata.to_bytes()
	var from_bytes = StateData3D.from_bytes(bytes)
	assert(from_bytes.get_data().size() == data.size())
	var step = 0.1
	for i in range(data.size()):
		assert(snappedf(from_bytes.get_data()[i], step) == snappedf(data[i], step))
	assert(from_bytes.get_map() == map)

## Tests the conversion of [BatchStateData] objects to PackedByteArrays and vice versa.
func test_batch_state_data():
	var sdata1 = StateData.new([2, 6.7, 4.2], [1, 2, 3])
	var sdata2 = StateData.new([0, 7], [0, 1])
	var sdata3 = StateData.new([7, 37.9], [0, 2])
	
	var batch1 = BatchStateData.new({5:sdata1, 7:sdata2, 512:sdata3})
	var batch1_bytes = batch1.to_bytes()
	var batch1_decoded = BatchStateData.from_bytes(batch1_bytes)
	
	assert(batch1.get_data().size() == batch1_decoded.get_data().size())
	
	for key in batch1.get_data().keys():
		assert(batch1.get_data()[key].equals(batch1_decoded.get_data()[key]))
