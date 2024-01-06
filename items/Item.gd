extends Area2D
class_name Item

const gem_texture = "./gem.png"
const cherry_texture = "./cherry.png"
enum ItemType { GEM, CHERRY }

@onready var sprite: Sprite2D = get_node("Sprite2D")

func init(_type: ItemType, _position: Vector2) -> void:
  var texture: Resource
  match _type:
    ItemType.GEM:
      texture = load(gem_texture)
    ItemType.CHERRY:
      texture = load(cherry_texture)
    _:
      assert(false, "Invalid item type")
  
  sprite.texture = texture
  position = _position
