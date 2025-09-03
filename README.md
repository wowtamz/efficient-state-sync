# Effiecient State Synchronisation
An efficient, low-bandwidth state synchronization data structure for real-time applications in the Godot Engine.

## Overview

StateData is a lightweight and modular data structure designed to efficiently synchronize game state over the network in real-time multiplayer games. It minimizes bandwidth usage by transmitting only the changes (diffs) in state, making it ideal for high-frequency updates such as entity positions, animations, and interactions.


## Features

🔄 Delta-based syncing – Send only what's changed.

📦 Compact serialization – Optimized for network bandwidth.

🧩 Modular structure – Easy to integrate and extend.

## Use Cases

- Synchronizing player and NPC positions.

- Snycing game object states.

- Streaming realtime data.

## Getting Started

1. Download or clone this repository into your Godot project directory:

```bash
git clone https://github.com/wowtamz/efficient-state-sync.git
```

2. Run the 2d/benchmark.tscn or 3d/benchmark.tscn scene to view performance.

3. Modify and use StateData.gd for your purposes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
