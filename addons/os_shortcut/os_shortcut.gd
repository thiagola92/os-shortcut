extends Node


## [Control] to be focused when the application lose focus. This is highly
## recommended because user input in another applications
## could accidentally trigger the last focus [Control].
## [br][br]
## [b]For example[/b]: A user click a [Button] in Godot window and them decide to start
## writing some text into another application. If they press [constant KEY_ENTER],
## the [Button] (last focus [Control]) would be pressed.
var target_focus: Control:
	set(t):
		if target_focus:
			target_focus.tree_exiting.disconnect(_remove_target_focus)
			
		target_focus = t
		
		if target_focus:
			target_focus.focus_mode = Control.FOCUS_ALL
			target_focus.tree_exiting.connect(_remove_target_focus)


func _ready() -> void:
	OSListener.get_singleton().start_listen()


func _exit_tree() -> void:
	OSListener.get_singleton().stop_listen()


func _notification(what: int) -> void:
	if target_focus and what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		target_focus.grab_focus()


func _process(_delta: float) -> void:
	# Get event from queue.
	var event: InputEvent = OSListener.get_singleton().get_event()
	
	if not event:
		return
	
	if event is InputEventKey:
		_process_event_key(event)


func _process_event_key(event: InputEventKey) -> void:
	# On Windows, it is always the Alt key.
	if OS.get_name() == "Windows" and event.keycode == KEY_MENU:
		event.keycode = KEY_ALT
	
	# INFO:
	# On Windows, Godot CONSUME events while window has focus, which means
	# that we NEVER receive events while window has focus.
	# On Linux, Godot LISTEN for events while window has focus, which means
	# that we ALSO receive events while window has focus.
	#
	# So to avoid receiving two times the same input on Linux,
	# we ignore when the window has focus.
	if get_window().has_focus():
		return
	
	event.alt_pressed = Input.is_key_pressed(KEY_ALT) and event.keycode != KEY_ALT
	event.ctrl_pressed = Input.is_key_pressed(KEY_CTRL) and event.keycode != KEY_CTRL
	event.meta_pressed = Input.is_key_pressed(KEY_META) and event.keycode != KEY_META
	event.shift_pressed = Input.is_key_pressed(KEY_SHIFT) and event.keycode != KEY_SHIFT
	event.echo = Input.is_key_pressed(event.keycode) and event.pressed
	
	Input.parse_input_event(event)
	Input.flush_buffered_events()


func _remove_target_focus() -> void:
	target_focus = null
