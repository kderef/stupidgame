package main

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
	rl.InitWindow(800, 600, "Hello world!")
	rl.InitAudioDevice()

	rl.SetTargetFPS(monitor_refresh())

	ui.init()

	// loop
	running := true

	for running {
		running ~= rl.WindowShouldClose()

		ui.process_inputs()

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		// test window
		ui.begin()

		if ui.begin_window("My Window", {10, 10, 140, 86}) {
			ui.layout_row({60, -1}, 0)

			ui.label("First:")
			if (ui.button("Button1") == {.SUBMIT}) {

			}

			ui.label("Second:")
			if (ui.button("Button2") == {.SUBMIT}) {
				ui.open_popup("My Popup")
			}

			if (ui.begin_popup("My Popup")) {
				ui.label("Hello world!")
				ui.end_popup()
			}

			ui.end_window()
		}

		ui.end()

		ui.render()


		rl.DrawFPS(0, 0)
		rl.EndDrawing()
	}

	ui.free()
	rl.CloseAudioDevice()
	rl.CloseWindow()
}
