extends CharacterBody2D
class_name Enemy

@onready var sprite: Sprite2D = get_node("Sprite2D")

const SPEED := 50
const GRAVITY := 900
## Left = -1 right = 1
var leftRight := 1

func _physics_process(_delta: float) -> void:
	velocity.x = leftRight * SPEED
	velocity.y += GRAVITY * _delta
	sprite.flip_h = velocity.x > 0
	move_and_slide()

	for i in get_slide_collision_count():
		var collistion := get_slide_collision(i)
		var collider := collistion.get_collider()

		if collider is Player:
			collider.hurt()
		
		var normal := collistion.get_normal().x
		if normal != 0:
			leftRight = signi(int(normal))
			velocity.y = -100
		
		# Out of bounds
		if position.y > 10000:
			queue_free()

