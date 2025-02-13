extends Node


var keys_down: Array = []


func _ready() -> void:
	OSListener.get_singleton().start_listen()


func _exit_tree() -> void:
	OSListener.get_singleton().stop_listen()


# TESTING
#func _input(event: InputEvent) -> void:
	#if event is InputEventKey:
		#if not event.echo:
			#print(event)


func _process(_delta: float) -> void:
	# Get event from queue.
	var event: OSEvent = OSListener.get_singleton().get_event()
	
	if not event:
		return
	
	# INFO
	# On Windows, Godot consume events while has focus.
	# On Linux, Godot don't consume so we receive the same event here.
	
	# Avoid double input events in Linux.
	if get_window().has_focus():
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
	event_key.alt_pressed = KEY_ALT in keys_down
	event_key.ctrl_pressed = KEY_CTRL in keys_down
	event_key.meta_pressed = KEY_META in keys_down
	event_key.shift_pressed = KEY_SHIFT in keys_down
	
	keys_down.append(keycode)
	
	Input.parse_input_event(event_key)


func _on_key_release(keycode: int) -> void:
	# First remove the key, so it doesn't metion it own modifier.
	# For example, pressing and releasing Ctrl shouldn't
	# set ctrl_pressed unless another Ctrl is pressed.
	keys_down.erase(keycode)
	
	var event_key = InputEventKey.new()
	event_key.keycode = keycode
	event_key.pressed = false
	event_key.alt_pressed = KEY_ALT in keys_down
	event_key.ctrl_pressed = KEY_CTRL in keys_down
	event_key.meta_pressed = KEY_META in keys_down
	event_key.shift_pressed = KEY_SHIFT in keys_down
	
	Input.parse_input_event(event_key)
