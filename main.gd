extends Node
class_name Main

func _ready() -> void:
	var level_num := str(GameState.current_level).pad_zeros(2)
	var path := "res://levels/1level_%s.tscn" % level_num
	var resource := load(path)
	var level = resource.instantiate()
	add_child(level)
