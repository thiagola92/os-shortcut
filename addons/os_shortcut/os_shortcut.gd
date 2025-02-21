extends Node


var keys_down: Array = []


func _ready() -> void:
	OSListener.get_singleton().start_listen()


func _exit_tree() -> void:
	OSListener.get_singleton().stop_listen()


func _process(_delta: float) -> void:
	# Get event from queue.
	var event: OSEvent = OSListener.get_singleton().get_event()
	
	if not event:
		return
	
	# INFO:
	# On Windows, Godot CONSUME events while window has focus, which means
	# that we NEVER receive events while window has focus.
	# On Linux, Godot LISTEN for events while window has focus, which means
	# that we ALSO receive events while window has focus.
	#
	# So to avoid receiving two times the same input on Linux,
	# we ignore when the window has focus.
	#
	# NOTE: If the user press a key while focusing another window and
	# release in godot window, we still needs to remove the key.
	if get_window().has_focus():
		if event.type == event.KEY_RELEASE:
			keys_down.erase(event.code)
		return
	
	match event.type:
		event.KEY_PRESS:
			_on_key_press(event.code)
		event.KEY_RELEASE:
			_on_key_release(event.code)


func _on_key_press(keycode: int) -> void:
	var event_key = InputEventKey.new()
	event_key.keycode = keycode
	event_key.pressed = true
	event_key.alt_pressed = KEY_ALT in keys_down and keycode != KEY_ALT
	event_key.ctrl_pressed = KEY_CTRL in keys_down and keycode != KEY_CTRL
	event_key.meta_pressed = KEY_META in keys_down and keycode != KEY_META
	event_key.shift_pressed = KEY_SHIFT in keys_down and keycode != KEY_SHIFT
	
	if keycode not in keys_down:
		keys_down.append(keycode)
	else:
		event_key.echo = true
	
	Input.parse_input_event(event_key)


func _on_key_release(keycode: int) -> void:
	var event_key = InputEventKey.new()
	event_key.keycode = keycode
	event_key.pressed = false
	event_key.alt_pressed = KEY_ALT in keys_down and keycode != KEY_ALT
	event_key.ctrl_pressed = KEY_CTRL in keys_down and keycode != KEY_CTRL
	event_key.meta_pressed = KEY_META in keys_down and keycode != KEY_META
	event_key.shift_pressed = KEY_SHIFT in keys_down and keycode != KEY_SHIFT
	
	keys_down.erase(keycode)
	
	Input.parse_input_event(event_key)
