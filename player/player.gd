extends CharacterBody2D
class_name Player

## Emits when life changes. life_changed(life: int)
signal life_changed

@onready var sprite: Sprite2D = get_node("Sprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

# Could be fetched via project settings
# ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity := 750
var run_speed := 150
var jump_speed := -300
enum State { IDLE, RUN, JUMP, HURT, DEAD}
var state := State.IDLE
var life := Global.PLAYER_DEFAULT_LIFE:
	set(_value):
		life = _value
		life_changed.emit(life)
		if life <= 0:
			_change_state(State.DEAD)

func _ready():
	_change_state(State.IDLE)

func _change_state(_state: State) -> void:
	match _state:
		State.IDLE:
			animation_player.play("idle")
		State.RUN:
			animation_player.play("run")
		State.JUMP:
			animation_player.play("jump_up")
		State.HURT:
			animation_player.play("hurt")
		State.DEAD:
			hide()
	state = _state

func _get_input() -> void:
	var is_right_pressed := Input.is_action_pressed("right")
	var is_left_pressed := Input.is_action_pressed("left")
	var is_jump_pressed := Input.is_action_just_pressed("jump")

	velocity.x = 0
	if is_right_pressed:
		velocity.x += run_speed
		sprite.flip_h = false
	if is_left_pressed:
		velocity.x -= run_speed
		sprite.flip_h = true
	# Only allow jump if player is touching the floor
	if is_jump_pressed and is_on_floor():
		_change_state(State.JUMP)
		velocity.y = jump_speed
	
	if state in [State.IDLE, State.RUN] and !is_on_floor():
		_change_state(State.JUMP)
	elif state == State.IDLE and velocity.x != 0:
		_change_state(State.RUN)
	elif state == State.RUN and velocity.x == 0:
		_change_state(State.IDLE)	
	
func _physics_process(_delta: float) -> void:
	_get_input()
	velocity.y += gravity * _delta
	move_and_slide()

	if state == State.JUMP and is_on_floor():
		_change_state(State.IDLE)
	
	if state == State.JUMP and velocity.y > 0:
		animation_player.play("jump_down")

func _reset(_position: Vector2) -> void:
	position = _position
	life = Global.PLAYER_DEFAULT_LIFE
	show()
	_change_state(State.IDLE)
	