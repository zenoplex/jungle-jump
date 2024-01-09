extends Area2D
class_name Item

## Emits on body entered
signal picked_up

const GEM_TEXTURE = "res://items/gem.png"
const CHERRY_TEXTURE = "res://items/cherry.png"
enum ItemType { GEM, CHERRY }

@onready var sprite: Sprite2D = get_node("Sprite2D")

func init(_type: ItemType, _position: Vector2) -> void:
  var texture: Resource
  match _type:
    ItemType.GEM:
      texture = load(GEM_TEXTURE)
    ItemType.CHERRY:
      texture = load(CHERRY_TEXTURE)
    _:
      assert(false, "Invalid item type")
  
  sprite.texture = texture
  position = _position


func _on_body_entered(_body: Node2D) -> void:
  picked_up.emit()
  queue_free()
