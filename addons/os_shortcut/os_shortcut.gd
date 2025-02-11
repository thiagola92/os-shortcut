extends Node


@export var keys_down: Array[int] = []


func _ready() -> void:
	OSListener.get_singleton().start_listen()


func _exit_tree() -> void:
	OSListener.get_singleton().stop_listen()


func _process(_delta: float) -> void:
	var event: OSEvent = OSListener.get_singleton().get_event()
	
	if not event:
		return
	
	match event.type:
		event.KEY_PRESS:
			if event.code not in keys_down:
				keys_down.append(event.code)
		event.KEY_RELEASE:
			keys_down.erase(event.code)
