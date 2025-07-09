package game

import "../assets"
import "../ui"
import "core:fmt"
import mu "vendor:microui"
import rl "vendor:raylib"

monitor_refresh :: proc() -> i32 {
	m := rl.GetCurrentMonitor()
	refresh := rl.GetMonitorRefreshRate(m)
	return refresh
}


main :: proc() {
	// --- setup
	FLAGS :: rl.ConfigFlags{}
	rl.SetConfigFlags(FLAGS)

	// --- init context
	rl.InitWindow(800, 600, "Hello world!")
	rl.InitAudioDevice()

	// --- load assets
	err := assets.load("assets")
	if err.kind != nil {
		fmt.eprintfln("Failed to load assets: %v: %v", err.kind, err.what)
		return
	}
	fmt.printfln("Loaded %v assets", assets.count())

	// --- match monitor framerate
	rl.SetTargetFPS(monitor_refresh())

	ui.init()

	// loop -- state
	for g_running {
		g_running ~= rl.WindowShouldClose()

		// update UI inputs
		ui.process_inputs()

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawTextEx(assets.font(.HackNF)^, "Hello world", {0, 0}, 100, 1, rl.WHITE)

		switch g_scene {
		case .Menu_Main:
			scene_change := draw_main_menu()
			if scene_change != nil do handle_scene_change(scene_change)
		case .Test:
			game_draw()
		}

		ui.render()


		rl.DrawFPS(0, 0)
		rl.EndDrawing()
	}

	assets.unload()
	ui.free()
	rl.CloseAudioDevice()
	rl.CloseWindow()
}
