extends Node2D
class_name LevelBase

@onready var player: Player = get_node("Player")
@onready var spawn_marker: Marker2D = get_node("SpawnMarker2D")

func _ready():
	player.reset(spawn_marker.position)
