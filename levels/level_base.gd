extends Node2D
class_name LevelBase

@onready var player: Player = get_node("Player")
@onready var spawn_marker: Marker2D = get_node("SpawnMarker2D")
@onready var world: TileMap = get_node("World")

func _ready():
	player.reset(spawn_marker.position)
	_set_camera()

func _set_camera() -> void:
	var map_size := world.get_used_rect()
	var cell_size := world.tile_set.tile_size

	var buffer_size := 5
	var left := (map_size.position.x - buffer_size) * cell_size.x
	var right := (map_size.end.x + buffer_size) * cell_size.x

	player.set_camera_limit(left, right)
