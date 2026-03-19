using Godot;
using System;

public class StatePacket
{
	public int[] map;
	public byte[] data;
	public int id;
	public int timestamp;
	public int ?state;
	public double ?positionX;
	public double ?positionY;
	public double ?positionZ;
	public double ?rotationX;
	public double ?rotationY;
	public double ?rotationZ;
	
	public StatePacket(int id, int timestamp) {
		this.id = id;
		this.timestamp = timestamp;
	}
	
	public void append(int index, var value) {
		
	}
	
	public byte[] Serialize() {
		StreamPeerBuffer buffer = new StreamPeerBuffer();
		//buffer.Put8();
		return (byte[]) buffer.GetDataArray();
	}
	
	// Returns the map properties of a StatePacket as a byte
	public byte GetMapAsByte() {
		byte b = 0;
		foreach(int index in map) {
			WriteBit(ref b, index, true);
		}
		return b;
	}
	
	// Writes a bit [param value] to byte [param b] at index [param bit_index].
	public void WriteBit(ref byte b, int index, bool value) {
		if (value) {
			b |= (byte)(1 << index);
		} else {
			b &= (byte)~(1 << index);
		}
	}
}
