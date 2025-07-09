package assets

import "core:fmt"
import "core:os"
import "core:strings"
import rl "vendor:raylib"

// --- global assets
assets: Assets

count :: proc() -> u32 {
	return u32(
		cap(FontID), // + ...
	)
}

// --- errors
AssetError :: enum {
	None = 0,
	FailedToLoad,
	DirNotFound,
}

ErrorKind :: union #shared_nil {
	os.Error,
	AssetError,
}

Error :: struct {
	kind: ErrorKind,
	what: string,
}


// --- assets
FontID :: enum {
	HackNF,
}
Font :: struct {
	id:   FontID,
	path: string,
	data: rl.Font,
}

// --- Asset Paths
PATHS :: struct {
	fonts: [FontID]string,
} {
	fonts = {
		//
		.HackNF = "font_hack/Hack-Bold.ttf",
	},
}

Assets :: struct {
	fonts: [FontID]Font,
}

load_font :: proc(path: string) -> rl.Font {
	cpath := strings.clone_to_cstring(path)
	return rl.LoadFontEx(cpath, 100, nil, 100)
	// return rl.LoadFont(cpath)
}

load_assets :: proc() -> (err: Error) {
	// --- 1: fonts
	rl_font_default := rl.GetFontDefault()
	for path, id in PATHS.fonts {
		assets.fonts[id] = {
			id   = id,
			path = path,
			data = load_font(path),
		}

		rl_font := assets.fonts[id].data
		if !rl.IsFontReady(rl_font) || rl_font.texture.id == rl_font_default.texture.id {
			err = {.FailedToLoad, path}
			return
		}
		// --- add to the loaded count
		_increment_loaded()
	}
	return
}

load :: proc(assets_dir: string) -> (err: Error) {
	// --- CD into assets directory
	prev_dir := os.get_current_directory()
	cd_err := os.set_current_directory(assets_dir)
	if cd_err != nil {
		err = {cd_err, assets_dir}
		return
	}

	err = load_assets()

	// --- CD back
	_cd_err := os.set_current_directory(prev_dir)

	return
}

unload :: proc() {
	// -- 1: fonts
	for font in assets.fonts {
		rl.UnloadFont(font.data)
	}
}

font :: proc(id: FontID) -> ^rl.Font {
	return &assets.fonts[id].data
}
