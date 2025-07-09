package game

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
	FLAGS :: rl.ConfigFlags{}

	rl.InitWindow(800, 600, "Hello world!")
	rl.InitAudioDevice()

	rl.SetTargetFPS(monitor_refresh())

	ui.init()

	target := rl.LoadRenderTexture(800, 600)

	// loop -- state
	running := true
	scene := Scene.MenuMain

	for running {
		running ~= rl.WindowShouldClose()

		// update UI inputs
		ui.process_inputs()

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		switch scene {
		case .MenuMain:
			scene_change := draw_main_menu()
			if scene_change != nil {
				switch scene_change.? {
				case .Quit:
					running = false
				case .Menu_Back: // ...
				case .Menu_Start: // ...
				}
			}
		}

		ui.render()


		rl.DrawFPS(0, 0)
		rl.EndDrawing()
	}

	ui.free()
	rl.CloseAudioDevice()
	rl.CloseWindow()
}
