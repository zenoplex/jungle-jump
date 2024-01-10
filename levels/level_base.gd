extends Node2D
class_name LevelBase

signal score_change(score: int)

@onready var player: Player = get_node("Player")
@onready var spawn_marker: Marker2D = get_node("SpawnMarker2D")
@onready var world: TileMap = get_node("World")
@onready var items: TileMap = get_node("Items")

@export var item_scene: PackedScene
var score := 0: 
	set(_value):
		score = _value
		score_change.emit(score)

func _ready():
	player.reset(spawn_marker.position)
	_set_camera()
	_spawn_items()

func _set_camera() -> void:
	var map_size := world.get_used_rect()
	var cell_size := world.tile_set.tile_size

	var buffer_size := 5
	var left := (map_size.position.x - buffer_size) * cell_size.x
	var right := (map_size.end.x + buffer_size) * cell_size.x

	player.set_camera_limit(left, right)

func _spawn_items() -> void:
	var item_cells := items.get_used_cells(0)
	for cell in item_cells:
		var data := items.get_cell_tile_data(0, cell)
		var type: Variant = data.get_custom_data("type")

		match type:
			"gem":
				_add_item(Item.ItemType.GEM, cell)
			"cherry":
				_add_item(Item.ItemType.CHERRY, cell)
			_:
				pass

func _add_item(type: Item.ItemType, cell: Vector2i) -> void:
	var item := item_scene.instantiate() as Item
	add_child(item)
	item.init(type, items.map_to_local(cell))
	item.picked_up.connect(self._on_item_picked_up)
	
func _on_item_picked_up() -> void:
	score += 1
