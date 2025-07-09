package assets

import "core:sync"
import "core:thread"
import rl "vendor:raylib"

// while loaded < asset_count
@(private)
loaded: u32 = 0

_increment_loaded :: proc() {
	sync.atomic_add(&loaded, 1)
}

has_loaded :: proc() -> bool {
	return sync.atomic_load(&loaded) >= count()
}

spawn_loading_thread :: proc() {
	// TODO: later.
}

draw_loading_screen :: proc() {
	rl.DrawText("loading", 0, 0, 100, rl.WHITE)
}
