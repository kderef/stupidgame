package game

Scene :: enum {
	Menu_Main,
	Test,
}

SceneChange :: enum {
	None = 0,
	Quit,
	Menu_Back,
	Menu_Start,
}

handle_scene_change :: proc(change: SceneChange) {
	switch change {
	case .None:
		return
	case .Quit:
		g_running = false
	case .Menu_Back: // ...
	case .Menu_Start: // ...
	}
}
