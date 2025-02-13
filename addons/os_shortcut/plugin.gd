@tool
extends EditorPlugin


const SINGLETON_NAME = "OSShortcut"


func _enter_tree() -> void:
	add_autoload_singleton(SINGLETON_NAME, "res://addons/os_shortcut/os_shortcut.gd")


func _exit_tree() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
