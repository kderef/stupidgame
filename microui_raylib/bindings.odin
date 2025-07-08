package microui_raylib

import "core:fmt"
import "core:unicode/utf8"
import mu "vendor:microui"
import rl "vendor:raylib"

Context :: struct {
	mu_ctx:          mu.Context,
	log_buf:         [1 << 16]byte,
	log_buf_len:     int,
	log_buf_updated: bool,
	bg:              mu.Color,
	atlas_texture:   rl.Texture2D,
}

init :: proc(ctx: ^Context) {
	ctx.bg = mu.Color{90, 95, 100, 255}

	// Build texture atlas
	pixels := make([][4]u8, mu.DEFAULT_ATLAS_WIDTH * mu.DEFAULT_ATLAS_HEIGHT)
	for alpha, i in mu.default_atlas_alpha {
		pixels[i] = {0xff, 0xff, 0xff, alpha}
	}
	defer delete(pixels)

	img := rl.Image {
		data    = raw_data(pixels),
		width   = mu.DEFAULT_ATLAS_WIDTH,
		height  = mu.DEFAULT_ATLAS_HEIGHT,
		mipmaps = 1,
		format  = .UNCOMPRESSED_R8G8B8A8,
	}
	ctx.atlas_texture = rl.LoadTextureFromImage(img)

	mu.init(&ctx.mu_ctx)
	ctx.mu_ctx.text_width = mu.default_atlas_text_width
	ctx.mu_ctx.text_height = mu.default_atlas_text_height
}

free :: proc(ctx: ^Context) {
	rl.UnloadTexture(ctx.atlas_texture)
}

update_input :: proc(ctx: ^Context) {
	mctx := &ctx.mu_ctx

	// Text input
	text_input: [512]byte
	offset := 0
	for offset < len(text_input) {
		ch := rl.GetCharPressed()
		if ch == 0 {
			break
		}
		b, w := utf8.encode_rune(ch)
		copy(text_input[offset:], b[:w])
		offset += w
	}
	mu.input_text(mctx, string(text_input[:offset]))

	// Mouse input
	pos := [2]i32{rl.GetMouseX(), rl.GetMouseY()}
	mu.input_mouse_move(mctx, pos.x, pos.y)
	mu.input_scroll(mctx, 0, i32(rl.GetMouseWheelMove() * -30))

	@(static) buttons := [?]struct {
		rl_button: rl.MouseButton,
		mu_button: mu.Mouse,
	}{{.LEFT, .LEFT}, {.RIGHT, .RIGHT}, {.MIDDLE, .MIDDLE}}

	for b in buttons {
		if rl.IsMouseButtonPressed(b.rl_button) {
			mu.input_mouse_down(mctx, pos.x, pos.y, b.mu_button)
		} else if rl.IsMouseButtonReleased(b.rl_button) {
			mu.input_mouse_up(mctx, pos.x, pos.y, b.mu_button)
		}
	}

	@(static) keys := [?]struct {
		rl_key: rl.KeyboardKey,
		mu_key: mu.Key,
	} {
		{.LEFT_SHIFT, .SHIFT},
		{.RIGHT_SHIFT, .SHIFT},
		{.LEFT_CONTROL, .CTRL},
		{.RIGHT_CONTROL, .CTRL},
		{.LEFT_ALT, .ALT},
		{.RIGHT_ALT, .ALT},
		{.ENTER, .RETURN},
		{.KP_ENTER, .RETURN},
		{.BACKSPACE, .BACKSPACE},
	}
	for key in keys {
		if rl.IsKeyPressed(key.rl_key) {
			mu.input_key_down(mctx, key.mu_key)
		} else if rl.IsKeyReleased(key.rl_key) {
			mu.input_key_up(mctx, key.mu_key)
		}
	}
}

render :: proc(ctx: ^Context) {
	mctx := &ctx.mu_ctx

	render_texture := proc(ctx: ^Context, rect: mu.Rect, pos: [2]i32, color: mu.Color) {
		source := rl.Rectangle{f32(rect.x), f32(rect.y), f32(rect.w), f32(rect.h)}
		position := rl.Vector2{f32(pos.x), f32(pos.y)}
		rl.DrawTextureRec(ctx.atlas_texture, source, position, transmute(rl.Color)color)
	}

	// rl.ClearBackground(transmute(rl.Color)ctx.bg)
	// rl.BeginDrawing()
	// defer rl.EndDrawing()
	rl.BeginScissorMode(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight())
	defer rl.EndScissorMode()

	command_backing: ^mu.Command
	for variant in mu.next_command_iterator(mctx, &command_backing) {
		switch cmd in variant {
		case ^mu.Command_Text:
			pos := [2]i32{cmd.pos.x, cmd.pos.y}
			for ch in cmd.str do if ch & 0xc0 != 0x80 {
				r := min(int(ch), 127)
				rect := mu.default_atlas[mu.DEFAULT_ATLAS_FONT + r]
				render_texture(ctx, rect, pos, cmd.color)
				pos.x += rect.w
			}
		case ^mu.Command_Rect:
			rl.DrawRectangle(
				cmd.rect.x,
				cmd.rect.y,
				cmd.rect.w,
				cmd.rect.h,
				transmute(rl.Color)cmd.color,
			)
		case ^mu.Command_Icon:
			rect := mu.default_atlas[cmd.id]
			x := cmd.rect.x + (cmd.rect.w - rect.w) / 2
			y := cmd.rect.y + (cmd.rect.h - rect.h) / 2
			render_texture(ctx, rect, {x, y}, cmd.color)
		case ^mu.Command_Clip:
			rl.EndScissorMode()
			rl.BeginScissorMode(cmd.rect.x, cmd.rect.y, cmd.rect.w, cmd.rect.h)
		case ^mu.Command_Jump:
			unreachable()
		}
	}
}
