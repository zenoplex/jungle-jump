extends Node

var num_levels := 2
var current_level := 1
var game_scene := "res://main.tscn"
var title_scene := "res://ui/title.tscn"

func restart() -> void:
	current_level = 0
	get_tree().change_scene_to_file(title_scene)

func next_level() -> void:
	current_level += 1
	if current_level > num_levels:
		current_level = 1
	get_tree().change_scene_to_file(game_scene)
