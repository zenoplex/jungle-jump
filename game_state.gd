extends Node

var num_levels := 2
var current_level := 0
var game_scene := "res://main.tscn"
var title_scene := "res://ui/title.tscn"

func restart() -> void:
	current_level = 0
	# https://github.com/godotengine/godot/issues/85852
	get_tree().change_scene_to_file.bind(title_scene).call_deferred()

func next_level() -> void:
	current_level += 1
	if current_level > num_levels:
		current_level = 1
	# https://github.com/godotengine/godot/issues/85852
	get_tree().change_scene_to_file.bind(game_scene).call_deferred()
