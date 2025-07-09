package game

import rl "vendor:raylib"

Camera :: rl.Camera3D

// --- prefix g_ => game state

Player :: struct {
	camera: Camera,
}

// --- state
g_running: bool = true
g_scene: Scene = .Menu_Main

g_player: Player = {
	camera = Camera {
		position = {0, 0, 0},
		target = {1, 1, 1},
		up = {0, 1, 0},
		fovy = 90,
		projection = rl.CameraProjection.PERSPECTIVE,
	},
}
