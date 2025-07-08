package ui

import mur "../microui_raylib"
import "base:builtin"
import mu "vendor:microui"

ctx: ^mur.Context = nil

mu_ctx :: #force_inline proc() -> ^mu.Context {
	return &ctx.mu_ctx
}

// --- types
Rect :: mu.Rect
Clip :: mu.Clip
Result :: mu.Result
Icon :: mu.Icon
Container :: mu.Container
Options :: mu.Options
Font :: mu.Font
Color :: mu.Color
Color_Type :: mu.Color_Type
Vec2 :: mu.Vec2
Id :: mu.Id
Key :: mu.Key
Stack :: mu.Stack
Layout :: mu.Layout
Pool_Item :: mu.Pool_Item
SLIDER_FMT :: mu.SLIDER_FMT

init :: proc() {
	mur.init(ctx)
}

begin_window :: proc(title: string, rect: mu.Rect) {
	mu.begin_window(mu_ctx(), title, rect)
}

get_context :: proc() -> ^mur.Context {
	return ctx
}

free :: proc() {
	if ctx != nil {
		mur.free(ctx)
		builtin.free(ctx)
	}
}


begin :: proc() {mu.begin(mu_ctx())}
begin_panel :: proc(name: string, opts: Options = Options{}) {
	mu.begin_panel(mu_ctx(), name, opts)
}

begin_popup :: proc(name: string) -> bool {
	return mu.begin_popup(mu_ctx(), name)
}


begin_treenode :: proc(label: string, opt: Options = Options{}) -> bit_set[Result;u32] {
	return mu.begin_treenode(mu_ctx(), label, opt)
}


bring_to_front :: proc(cnt: ^Container) {
	mu.bring_to_front(mu_ctx(), cnt)
}


button :: proc(
	label: string,
	icon: Icon = .NONE,
	opt: Options = {.ALIGN_CENTER},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.button(mu_ctx(), label, icon, opt)
}


check_clip :: proc(r: Rect) -> Clip {
	return mu.check_clip(mu_ctx(), r)
}


checkbox :: proc(label: string, state: ^bool) -> (res: bit_set[Result;u32]) {
	return mu.checkbox(mu_ctx(), label, state)
}


default_atlas_text_height :: proc(font: Font) -> i32 {
	return mu.default_atlas_text_height(font)
}


default_atlas_text_width :: proc(font: Font, text: string) -> (width: i32) {
	return mu.default_atlas_text_width(font, text)
}


draw_box :: proc(rect: Rect, color: Color) {
	mu.draw_box(mu_ctx(), rect, color)
}


draw_control_frame :: proc(id: Id, rect: Rect, colorid: Color_Type, opt: Options = {}) {
	mu.draw_control_frame(mu_ctx(), id, rect, colorid, opt)
}


draw_control_text :: proc(str: string, rect: Rect, colorid: Color_Type, opt: Options = {}) {
	mu.draw_control_text(mu_ctx(), str, rect, colorid, opt)
}


draw_icon :: proc(id: Icon, rect: Rect, color: Color) {
	mu.draw_icon(mu_ctx(), id, rect, color)
}


draw_rect :: proc(rect: Rect, color: Color) {
	mu.draw_rect(mu_ctx(), rect, color)
}


draw_text :: proc(font: Font, str: string, pos: Vec2, color: Color) {
	mu.draw_text(mu_ctx(), font, str, pos, color)
}


end :: proc() {
	mu.end(mu_ctx())
}


end_panel :: proc() {
	mu.end_panel(mu_ctx())
}


end_popup :: proc() {
	mu.end_popup(mu_ctx())
}


end_treenode :: proc() {
	mu.end_treenode(mu_ctx())
}


end_window :: proc() {
	mu.end_window(mu_ctx())
}


expand_rect :: proc(rect: Rect, n: i32) -> Rect {
	return mu.expand_rect(rect, n)
}


get_clip_rect :: proc() -> Rect {
	return mu.get_clip_rect(mu_ctx())
}


get_container :: proc(name: string, opt: Options = {}) -> ^Container {
	return mu.get_container(mu_ctx(), name, opt)
}


get_current_container :: proc() -> ^Container {
	return mu.get_current_container(mu_ctx())
}


get_id_bytes :: proc(bytes: []u8) -> Id {
	return mu.get_id_bytes(mu_ctx(), bytes)
}

get_id_rawptr :: proc(data: rawptr, size: int) -> Id {
	return mu.get_id_rawptr(mu_ctx(), data, size)
}


get_id_string :: proc(str: string) -> Id {
	return mu.get_id_string(mu_ctx(), str)
}


get_id_uintptr :: proc(ptr: uintptr) -> Id {
	return mu.get_id_uintptr(mu_ctx(), ptr)
}


get_layout :: proc() -> ^Layout {
	return mu.get_layout(mu_ctx())
}


header :: proc(label: string, opt: Options = {}) -> bit_set[Result;u32] {
	return mu.header(mu_ctx(), label, opt)
}


// input_key_down :: proc(key: Key) {}
// input_key_up :: proc(key: Key) {}
// input_mouse_down :: proc(x, y: i32, btn: Mouse) {}
// input_mouse_move :: proc(x, y: i32) {}
// input_mouse_up :: proc(x, y: i32, btn: Mouse) {}
// input_scroll :: proc(x, y: i32) {}
// input_text :: proc(text: string) {}

intersect_rects :: proc(r1, r2: Rect) -> Rect {
	return mu.intersect_rects(r1, r2)
}


label :: proc(text: string) {
	mu.label(mu_ctx(), text)
}


layout_begin_column :: proc() {
	mu.layout_begin_column(mu_ctx())
}


layout_column :: proc() -> bool {
	return mu.layout_column(mu_ctx())
}


layout_end_column :: proc() {
	mu.layout_end_column(mu_ctx())
}

layout_height :: proc(height: i32) {}


layout_next :: proc() -> (res: Rect) {
	return mu.layout_next(mu_ctx())
}


layout_row :: proc(widths: []i32, height: i32 = 0) {
	mu.layout_row(mu_ctx(), widths, height)
}


layout_row_items :: proc(items: i32, height: i32 = 0) {
	mu.layout_row_items(mu_ctx(), items, height)
}


layout_set_next :: proc(r: Rect, relative: bool) {
	mu.layout_set_next(mu_ctx(), r, relative)
}


layout_width :: proc(width: i32) {
	mu.layout_width(mu_ctx(), width)
}


mouse_over :: proc(rect: Rect) -> bool {
	return mu.mouse_over(mu_ctx(), rect)
}


next_command :: mu.next_command
next_command_iterator :: mu.next_command_iterator

number :: proc(
	value: ^f32,
	step: f32,
	fmt_string: string = SLIDER_FMT,
	opt: Options = {.ALIGN_CENTER},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.number(mu_ctx(), value, step, fmt_string, opt)
}


number_textbox :: proc(value: ^f32, r: Rect, id: Id, fmt_string: string) -> bool {
	return mu.number_textbox(mu_ctx(), value, r, id, fmt_string)
}


open_popup :: proc(name: string) {
	mu.open_popup(mu_ctx(), name)
}

pool_get :: proc(items: []Pool_Item, id: Id) -> (int, bool) {
	return mu.pool_get(mu_ctx(), items, id)
}


pool_init :: proc(items: []Pool_Item, id: Id) -> int {
	return mu.pool_init(mu_ctx(), items, id)
}


pool_update :: proc(item: ^Pool_Item) {
	mu.pool_update(mu_ctx(), item)
}


pop :: mu.pop
pop_clip_rect :: proc() {mu.pop_clip_rect(mu_ctx())}
pop_id :: proc() {mu.pop_id(mu_ctx())}


popup :: proc(name: string) -> bool {
	return mu.popup(mu_ctx(), name)
}


// This is scoped and is intended to be use in the condition of a if-statement
push :: mu.push

push_clip_rect :: proc(rect: Rect) {
	mu.push_clip_rect(mu_ctx(), rect)
}


push_command :: proc($Type: typeid, extra_size: int = 0) -> ^typeid {
	return mu.push_command(mu_ctx(), Type, extra_size)
}

push_id_bytes :: proc(bytes: []u8) {mu.push_id_bytes(mu_ctx(), bytes)}
push_id_rawptr :: proc(data: rawptr, size: int) {mu.push_id_rawptr(mu_ctx(), data, size)}
push_id_string :: proc(str: string) {mu.push_id_string(mu_ctx(), str)}
push_id_uintptr :: proc(ptr: uintptr) {mu.push_id_uintptr(mu_ctx(), ptr)}


rect_overlaps_vec2 :: mu.rect_overlaps_vec2


scoped_end_popup :: proc(_s: string, ok: bool) {
	mu.scoped_end_popup(mu_ctx(), _s, ok)
}


scoped_end_treenode :: proc(_s: string, _o: Options, result_set: bit_set[Result;u32]) {
	mu.scoped_end_treenode(mu_ctx(), _s, _o, result_set)
}


scoped_end_window :: proc(_s: string, _r: Rect, _o: Options, ok: bool) {
	mu.scoped_end_window(mu_ctx(), _s, _r, _o, ok)
}
set_clip :: proc(rect: Rect) {mu.set_clip(mu_ctx(), rect)}
set_focus :: proc(id: Id) {mu.set_focus(mu_ctx(), id)}


slider :: proc(
	value: ^f32,
	low, high: f32,
	step: f32 = 0.0,
	fmt_string: string = SLIDER_FMT,
	opt: Options = {.ALIGN_CENTER},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.slider(mu_ctx(), value, low, high, step, fmt_string, opt)
}


text :: proc(text: string) {mu.text(mu_ctx(), text)}


textbox :: proc(buf: []u8, textlen: ^int, opt: Options = {}) -> bit_set[Result;u32] {
	return mu.textbox(mu_ctx(), buf, textlen, opt)
}


textbox_raw :: proc(
	textbuf: []u8,
	textlen: ^int,
	id: Id,
	r: Rect,
	opt: Options = Options{},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.textbox_raw(mu_ctx(), textbuf, textlen, id, r, opt)
}


treenode :: proc(label: string, opt: Options = {}) -> bit_set[Result;u32] {
	return mu.treenode(mu_ctx(), label, opt)
}


// This is scoped and is intended to be use in the condition of a if-statement
update_control :: proc(id: Id, rect: Rect, opt: Options = {}) {
	mu.update_control(mu_ctx(), id, rect, opt)
}


window :: proc(title: string, rect: Rect, opt: Options = {}) -> bool {
	return mu.window(mu_ctx(), title, rect, opt)
}


get_id :: proc {
	get_id_string,
	get_id_bytes,
	get_id_rawptr,
	get_id_uintptr,
}


push_id :: proc {
	push_id_string,
	push_id_bytes,
	push_id_rawptr,
	push_id_uintptr,
}
