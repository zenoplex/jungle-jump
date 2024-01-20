extends CharacterBody2D
class_name Player

signal life_changed(_life: int)
signal dead()

@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var jump_sound: AudioStreamPlayer = get_node("JumpSound")
@onready var hurt_sound: AudioStreamPlayer = get_node("HurtSound")

# Could be fetched via project settings
# ProjectSettings.get_setting("physics/2d/default_gravity")
const GRAVITY := 750
const RUN_SPEED := 150
const JUMP_SPEED := -300
const INVINCIBILITY_TIME := 1.0
const HURT_PUSHBACK := Vector2(-100, -200)
enum State { IDLE, RUN, JUMP, HURT, DEAD}
var state := State.IDLE
var life := Global.PLAYER_DEFAULT_LIFE:
	set(_value):
		life = _value
		life_changed.emit(life)
		print_debug("Player life: " + str(life))

func _ready():
	_change_state(State.IDLE)

func _change_state(_state: State) -> void:
	state = _state
	match state:
		State.IDLE:
			animation_player.play("idle")
		State.RUN:
			animation_player.play("run")
		State.JUMP:
			animation_player.play("jump_up")
		State.HURT:
			animation_player.play("hurt")
			velocity.y = HURT_PUSHBACK.y
			# TODO: This may not be working as velocity.x is reset to 0 in _get_input
			velocity.x = HURT_PUSHBACK.x * sign(velocity.x)
			print_debug(velocity.x)
			life -= 1
			var timer := get_tree().create_timer(INVINCIBILITY_TIME)
			await timer.timeout
			_change_state(State.IDLE)
			if life <= 0:
				_change_state(State.DEAD)
		State.DEAD:
			hide()
			dead.emit()

func _get_input() -> void:
	var is_right_pressed := Input.is_action_pressed("right")
	var is_left_pressed := Input.is_action_pressed("left")
	var is_jump_pressed := Input.is_action_just_pressed("jump")

	velocity.x = 0
	if is_right_pressed:
		velocity.x += RUN_SPEED
		sprite.flip_h = false
	if is_left_pressed:
		velocity.x -= RUN_SPEED
		sprite.flip_h = true
	# Only allow jump if player is touching the floor
	if is_jump_pressed and is_on_floor():
		_change_state(State.JUMP)
		velocity.y = JUMP_SPEED
		jump_sound.play()
	
	if state in [State.IDLE, State.RUN] and !is_on_floor():
		_change_state(State.JUMP)
	elif state == State.IDLE and velocity.x != 0:
		_change_state(State.RUN)
	elif state == State.RUN and velocity.x == 0:
		_change_state(State.IDLE)	
	
func _physics_process(_delta: float) -> void:
	_get_input()
	velocity.y += GRAVITY * _delta
	move_and_slide()

	if state == State.JUMP and is_on_floor():
		_change_state(State.IDLE)
	
	if state == State.JUMP and velocity.y > 0:
		animation_player.play("jump_down")

	if state != State.HURT:
		for i in get_slide_collision_count():
			var collistion := get_slide_collision(i)
			var collider := collistion.get_collider()
			if collider is DangerTileMap:
				hurt()
			if collider is Enemy:
				if position.y < collider.position.y:
					collider.take_damage()
				else:
					hurt()

func reset(_position: Vector2) -> void:
	position = _position
	life = Global.PLAYER_DEFAULT_LIFE
	show()
	_change_state(State.IDLE)
	
func hurt() -> void:
	if state != State.HURT:
		_change_state(State.HURT)
		hurt_sound.play()

func set_camera_limit(top: int, right: int, bottom: int, left: int) -> void:
	camera.limit_top = top;
	camera.limit_left = left
	camera.limit_right = right
	camera.limit_bottom = bottom
