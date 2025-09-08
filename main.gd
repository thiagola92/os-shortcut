extends Control


# TESTING
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.echo:
			printt(event)
			
			$Label.text = event.as_text_keycode()
