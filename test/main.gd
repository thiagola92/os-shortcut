extends Node2D


func _ready() -> void:
	OSListener.get_singleton().start_listen()
