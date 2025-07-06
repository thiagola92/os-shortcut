extends Control


# TESTING
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.echo:
			print(event)
