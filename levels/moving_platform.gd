extends Node2D
class_name  MovingPlatform

@onready var tileMap: TileMap = get_node("TileMap")

@export var offset := Vector2(320, 0)
@export var duration := 10.0

func _ready() -> void:
	var tween := create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(tileMap, "position", offset, duration * 0.5).from_current()
	tween.tween_property(tileMap, "position", Vector2.ZERO, duration * 0.5)
