# Effiecient State Synchronisation
An efficient, low-bandwidth state synchronization data structure for real-time applications in the Godot Engine.

## 💡 Overview

StateData is a lightweight and modular data structure designed to efficiently synchronize game state over the network in real-time multiplayer games. The benchmark minimizes bandwidth usage by transmitting only the changes (diffs) in state, making it ideal for high-frequency updates such as entity positions, animations, and interactions which happen in real time. Both 2D and 3D benchmark scenes include tools to test and visualize network performance under various conditions. They allow you to:

- Keep track of the (simulated) network usage
- Increase or decrease the number of units transmitting their states
- Use batching to send and receive grouped StateData packets
- Apply movement, rotation, and color changes to units
- Adjust the number of packets sent per second
- Introduce artificial latency to simulate network delay
- Add jitter to simulate fluctuating latency
- Apply packet loss to emulate real-world network instability

## 🎏 Features

🔄 Delta-based syncing – Send only what's changed. 

📦 Compact serialization – Optimized for network bandwidth.

🧩 Modular structure – Easy to integrate and extend.

## ✨ Showcase

### 2D Benchmark without smoothing

Raw state updates: Units jump directly to new positions as state changes are applied, showing the effect of transmitting updates without interpolation. This highlights potential jitter when network updates are applied instantly.

![2D Benchmark without linear interpolation](https://roguedev.net/docs/img/exp_no_lerp.gif)

### 2D Benchmark with smoothing

Smooth interpolation in action: Units move fluidly as their positions are updated over the network using linear interpolation (lerp), demonstrating how StateData handles high-frequency state changes without visible jitter.

![2D Benchmark using linear interpolation](https://roguedev.net/docs/img/exp_lerp.gif)

## 🧮 Index Encoding

To transmit only state changes, each value must be mapped to an index or key so it can be correctly identified on the receiving end. StateData encodes each index as a bit within a bitstring. Due to limitations in GDScript, these bits are stored in an unsigned 8-bit integer. When more than eight values need to be transmitted, the indices are mapped to the next larger integer type (e.g., an unsigned 16-bit integer).

## 📊 Use Cases

🎮 Synchronizing player and NPC positions.

⚡ Snycing game object states.

📡 Streaming realtime data.

## 🔨 Getting Started

1. Download or clone this repository into your Godot project directory:

```bash
git clone https://github.com/wowtamz/efficient-state-sync.git
```

2. Run the 2d/benchmark.tscn or 3d/benchmark.tscn scene to view performance.

3. Modify and use StateData.gd for your purposes.

## 🎓 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
