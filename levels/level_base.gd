extends Node2D
class_name LevelBase

signal score_change(_score: int)

@onready var player: Player = get_node("Player")
@onready var spawn_marker: Marker2D = get_node("SpawnMarker2D")
@onready var world: TileMap = get_node("WorldTileMap")
@onready var items: TileMap = get_node("ItemsTileMap")
@onready var hud: HUD = get_node("CanvasLayer/HUD")

@export var item_scene: PackedScene
@export var door_scene: PackedScene

var score := 0: 
	set(_value):
		score = _value
		score_change.emit(score)

func _ready() -> void:
	score = 0
	items.visible = false
	player.reset(spawn_marker.position)
	_set_camera()
	_spawn_items()

func _set_camera() -> void:
	var map_size := world.get_used_rect()
	var cell_size := world.tile_set.tile_size

	var buffer_size := 5
	var top := 0
	var right := (map_size.end.x + buffer_size) * cell_size.x
	var left := (map_size.position.x - buffer_size) * cell_size.x
	var bottom := int(240 * 1.5)
	

	player.set_camera_limit(top, right, bottom, left)

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
			"door":
				_add_door(cell)
			_:
				pass

func _add_item(_type: Item.ItemType, _cell: Vector2i) -> void:
	var item := item_scene.instantiate() as Item
	add_child(item)
	item.init(_type, items.map_to_local(_cell))
	item.picked_up.connect(self._on_item_picked_up)

func _add_door(_cell: Vector2i) -> void:
	var door := door_scene.instantiate() as Door
	door.z_index = -1
	add_child(door)
	door.position = items.map_to_local(_cell)
	door.body_entered.connect(_on_door_body_entered)

func _on_item_picked_up() -> void:
	score += 1

func _on_door_body_entered(_body: Node2D) -> void:
	GameState.next_level()	

func _on_player_life_changed(_life: int) -> void:
	hud.set_life(_life)

func _on_score_change(_score: int) -> void:
	hud.set_score(_score)

func _on_player_dead() -> void:
	GameState.restart()
