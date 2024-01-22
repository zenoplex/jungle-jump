extends Node2D
class_name  MovingPlatform

@onready var tileMap: TileMap = get_node("TileMap")

const OFFSET := Vector2(320, 0)
const DURATION := 10.0

func _ready() -> void:
	var tween := create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(tileMap, "position", OFFSET, DURATION * 0.5).from_current()
	tween.tween_property(tileMap, "position", Vector2.ZERO, DURATION * 0.5)
