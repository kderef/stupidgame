package ui

import mur "../microui_raylib"
import "base:builtin"
import mu "vendor:microui"

@(private)
ctx: ^mur.Context = nil

active: bool = true

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

process_inputs :: #force_inline proc() {
	if active do mur.update_input(ctx)
}

init :: #force_inline proc() {
	ctx = new(mur.Context)
	mur.init(ctx)
}


get_context :: #force_inline proc() -> ^mur.Context {
	return ctx
}

free :: #force_inline proc() {
	if ctx != nil {
		mur.free(ctx)
		builtin.free(ctx)
	}
}

render :: #force_inline proc() {
	if active do mur.render(ctx)
}


// --- bindings from here

begin_window :: #force_inline proc(title: string, rect: mu.Rect) -> bool {
	return mu.begin_window(mu_ctx(), title, rect)
}
begin :: #force_inline proc() {mu.begin(mu_ctx())}
begin_panel :: #force_inline proc(name: string, opts: Options = Options{}) {
	mu.begin_panel(mu_ctx(), name, opts)
}

begin_popup :: #force_inline proc(name: string) -> bool {
	return mu.begin_popup(mu_ctx(), name)
}


begin_treenode :: #force_inline proc(
	label: string,
	opt: Options = Options{},
) -> bit_set[Result;u32] {
	return mu.begin_treenode(mu_ctx(), label, opt)
}


bring_to_front :: #force_inline proc(cnt: ^Container) {
	mu.bring_to_front(mu_ctx(), cnt)
}

button_clicked :: #force_inline proc(
	label: string,
	icon: Icon = .NONE,
	opt: Options = {.ALIGN_CENTER},
) -> bool {
	return button(label, icon, opt) == {.SUBMIT}
}

button :: #force_inline proc(
	label: string,
	icon: Icon = .NONE,
	opt: Options = {.ALIGN_CENTER},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.button(mu_ctx(), label, icon, opt)
}


check_clip :: #force_inline proc(r: Rect) -> Clip {
	return mu.check_clip(mu_ctx(), r)
}


checkbox :: #force_inline proc(label: string, state: ^bool) -> (res: bit_set[Result;u32]) {
	return mu.checkbox(mu_ctx(), label, state)
}


default_atlas_text_height :: #force_inline proc(font: Font) -> i32 {
	return mu.default_atlas_text_height(font)
}


default_atlas_text_width :: #force_inline proc(font: Font, text: string) -> (width: i32) {
	return mu.default_atlas_text_width(font, text)
}


draw_box :: #force_inline proc(rect: Rect, color: Color) {
	mu.draw_box(mu_ctx(), rect, color)
}


draw_control_frame :: #force_inline proc(
	id: Id,
	rect: Rect,
	colorid: Color_Type,
	opt: Options = {},
) {
	mu.draw_control_frame(mu_ctx(), id, rect, colorid, opt)
}


draw_control_text :: #force_inline proc(
	str: string,
	rect: Rect,
	colorid: Color_Type,
	opt: Options = {},
) {
	mu.draw_control_text(mu_ctx(), str, rect, colorid, opt)
}


draw_icon :: #force_inline proc(id: Icon, rect: Rect, color: Color) {
	mu.draw_icon(mu_ctx(), id, rect, color)
}


draw_rect :: #force_inline proc(rect: Rect, color: Color) {
	mu.draw_rect(mu_ctx(), rect, color)
}


draw_text :: #force_inline proc(font: Font, str: string, pos: Vec2, color: Color) {
	mu.draw_text(mu_ctx(), font, str, pos, color)
}


end :: #force_inline proc() {
	mu.end(mu_ctx())
}


end_panel :: #force_inline proc() {
	mu.end_panel(mu_ctx())
}


end_popup :: #force_inline proc() {
	mu.end_popup(mu_ctx())
}


end_treenode :: #force_inline proc() {
	mu.end_treenode(mu_ctx())
}


end_window :: #force_inline proc() {
	mu.end_window(mu_ctx())
}


expand_rect :: #force_inline proc(rect: Rect, n: i32) -> Rect {
	return mu.expand_rect(rect, n)
}


get_clip_rect :: #force_inline proc() -> Rect {
	return mu.get_clip_rect(mu_ctx())
}


get_container :: #force_inline proc(name: string, opt: Options = {}) -> ^Container {
	return mu.get_container(mu_ctx(), name, opt)
}


get_current_container :: #force_inline proc() -> ^Container {
	return mu.get_current_container(mu_ctx())
}


get_id_bytes :: #force_inline proc(bytes: []u8) -> Id {
	return mu.get_id_bytes(mu_ctx(), bytes)
}

get_id_rawptr :: #force_inline proc(data: rawptr, size: int) -> Id {
	return mu.get_id_rawptr(mu_ctx(), data, size)
}


get_id_string :: #force_inline proc(str: string) -> Id {
	return mu.get_id_string(mu_ctx(), str)
}


get_id_uintptr :: #force_inline proc(ptr: uintptr) -> Id {
	return mu.get_id_uintptr(mu_ctx(), ptr)
}


get_layout :: #force_inline proc() -> ^Layout {
	return mu.get_layout(mu_ctx())
}


header :: #force_inline proc(label: string, opt: Options = {}) -> bit_set[Result;u32] {
	return mu.header(mu_ctx(), label, opt)
}


// input_key_down :: #force_inline proc(key: Key) {}
// input_key_up :: #force_inline proc(key: Key) {}
// input_mouse_down :: #force_inline proc(x, y: i32, btn: Mouse) {}
// input_mouse_move :: #force_inline proc(x, y: i32) {}
// input_mouse_up :: #force_inline proc(x, y: i32, btn: Mouse) {}
// input_scroll :: #force_inline proc(x, y: i32) {}
// input_text :: #force_inline proc(text: string) {}

intersect_rects :: #force_inline proc(r1, r2: Rect) -> Rect {
	return mu.intersect_rects(r1, r2)
}


label :: #force_inline proc(text: string) {
	mu.label(mu_ctx(), text)
}


layout_begin_column :: #force_inline proc() {
	mu.layout_begin_column(mu_ctx())
}


layout_column :: #force_inline proc() -> bool {
	return mu.layout_column(mu_ctx())
}


layout_end_column :: #force_inline proc() {
	mu.layout_end_column(mu_ctx())
}

layout_height :: #force_inline proc(height: i32) {}


layout_next :: #force_inline proc() -> (res: Rect) {
	return mu.layout_next(mu_ctx())
}


layout_row :: #force_inline proc(widths: []i32, height: i32 = 0) {
	mu.layout_row(mu_ctx(), widths, height)
}


layout_row_items :: #force_inline proc(items: i32, height: i32 = 0) {
	mu.layout_row_items(mu_ctx(), items, height)
}


layout_set_next :: #force_inline proc(r: Rect, relative: bool) {
	mu.layout_set_next(mu_ctx(), r, relative)
}


layout_width :: #force_inline proc(width: i32) {
	mu.layout_width(mu_ctx(), width)
}


mouse_over :: #force_inline proc(rect: Rect) -> bool {
	return mu.mouse_over(mu_ctx(), rect)
}


next_command :: mu.next_command
next_command_iterator :: mu.next_command_iterator

number :: #force_inline proc(
	value: ^f32,
	step: f32,
	fmt_string: string = SLIDER_FMT,
	opt: Options = {.ALIGN_CENTER},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.number(mu_ctx(), value, step, fmt_string, opt)
}


number_textbox :: #force_inline proc(value: ^f32, r: Rect, id: Id, fmt_string: string) -> bool {
	return mu.number_textbox(mu_ctx(), value, r, id, fmt_string)
}


open_popup :: #force_inline proc(name: string) {
	mu.open_popup(mu_ctx(), name)
}

pool_get :: #force_inline proc(items: []Pool_Item, id: Id) -> (int, bool) {
	return mu.pool_get(mu_ctx(), items, id)
}


pool_init :: #force_inline proc(items: []Pool_Item, id: Id) -> int {
	return mu.pool_init(mu_ctx(), items, id)
}


pool_update :: #force_inline proc(item: ^Pool_Item) {
	mu.pool_update(mu_ctx(), item)
}


pop :: mu.pop
pop_clip_rect :: #force_inline proc() {mu.pop_clip_rect(mu_ctx())}
pop_id :: #force_inline proc() {mu.pop_id(mu_ctx())}


popup :: #force_inline proc(name: string) -> bool {
	return mu.popup(mu_ctx(), name)
}


// This is scoped and is intended to be use in the condition of a if-statement
push :: mu.push

push_clip_rect :: #force_inline proc(rect: Rect) {
	mu.push_clip_rect(mu_ctx(), rect)
}


push_command :: #force_inline proc($Type: typeid, extra_size: int = 0) -> ^typeid {
	return mu.push_command(mu_ctx(), Type, extra_size)
}

push_id_bytes :: #force_inline proc(bytes: []u8) {mu.push_id_bytes(mu_ctx(), bytes)}
push_id_rawptr :: #force_inline proc(data: rawptr, size: int) {mu.push_id_rawptr(
		mu_ctx(),
		data,
		size,
	)}
push_id_string :: #force_inline proc(str: string) {mu.push_id_string(mu_ctx(), str)}
push_id_uintptr :: #force_inline proc(ptr: uintptr) {mu.push_id_uintptr(mu_ctx(), ptr)}


rect_overlaps_vec2 :: mu.rect_overlaps_vec2


scoped_end_popup :: #force_inline proc(_s: string, ok: bool) {
	mu.scoped_end_popup(mu_ctx(), _s, ok)
}


scoped_end_treenode :: #force_inline proc(
	_s: string,
	_o: Options,
	result_set: bit_set[Result;u32],
) {
	mu.scoped_end_treenode(mu_ctx(), _s, _o, result_set)
}


scoped_end_window :: #force_inline proc(_s: string, _r: Rect, _o: Options, ok: bool) {
	mu.scoped_end_window(mu_ctx(), _s, _r, _o, ok)
}
set_clip :: #force_inline proc(rect: Rect) {mu.set_clip(mu_ctx(), rect)}
set_focus :: #force_inline proc(id: Id) {mu.set_focus(mu_ctx(), id)}


slider :: #force_inline proc(
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


text :: #force_inline proc(text: string) {mu.text(mu_ctx(), text)}


textbox :: #force_inline proc(buf: []u8, textlen: ^int, opt: Options = {}) -> bit_set[Result;u32] {
	return mu.textbox(mu_ctx(), buf, textlen, opt)
}


textbox_raw :: #force_inline proc(
	textbuf: []u8,
	textlen: ^int,
	id: Id,
	r: Rect,
	opt: Options = {},
) -> (
	res: bit_set[Result;u32],
) {
	return mu.textbox_raw(mu_ctx(), textbuf, textlen, id, r, opt)
}


treenode :: #force_inline proc(label: string, opt: Options = {}) -> bit_set[Result;u32] {
	return mu.treenode(mu_ctx(), label, opt)
}


// This is scoped and is intended to be use in the condition of a if-statement
update_control :: #force_inline proc(id: Id, rect: Rect, opt: Options = {}) {
	mu.update_control(mu_ctx(), id, rect, opt)
}


window :: #force_inline proc(title: string, rect: Rect, opt: Options = {}) -> bool {
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
