extends Control
class_name Title

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		GameState.next_level()
