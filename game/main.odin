package main

import "../microui_raylib"
import "core:fmt"
import mu "vendor:microui"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 600, "Hello world!")
	rl.InitAudioDevice()

	rl.SetTargetFPS(120)

	mu_ctx := new(microui_raylib.Context)
	microui_raylib.init(mu_ctx)

	ctx := &mu_ctx.mu_ctx

	// loop
	running := true

	for running {
		running ~= rl.WindowShouldClose()

		microui_raylib.update_input(mu_ctx)

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		// test window
		mu.begin(ctx)
		if mu.begin_window(ctx, "My Window", {10, 10, 140, 86}) {
			mu.layout_row(ctx, {60, -1}, 0)

			mu.label(ctx, "First:")
			if (mu.button(ctx, "Button1") == {.SUBMIT}) {

			}

			mu.label(ctx, "Second:")
			if (mu.button(ctx, "Button2") == {.SUBMIT}) {
				mu.open_popup(ctx, "My Popup")
			}

			if (mu.begin_popup(ctx, "My Popup")) {
				mu.label(ctx, "Hello world!")
				mu.end_popup(ctx)
			}

			mu.end_window(ctx)
		}

		mu.end(&mu_ctx.mu_ctx)


		microui_raylib.render(mu_ctx)

		rl.DrawFPS(0, 0)
		rl.EndDrawing()
	}

	microui_raylib.free(mu_ctx)
	rl.CloseAudioDevice()
	rl.CloseWindow()
}
