package game

import "../ui"

draw_main_menu :: proc() -> (change: Maybe(SceneChange)) {
	change = nil

	// test window
	ui.begin()

	if ui.begin_window("Main Menu", {150, 100, 200, 100}) {
		ui.layout_row({100, 100}, 50)

		if ui.button_clicked("Play") {
			change = .Menu_Start
		}
		if ui.button_clicked("Quit") {
			change = .Quit
		}

		ui.end_window()
	}

	ui.end()

	return
}
