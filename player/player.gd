extends CharacterBody2D
class_name Player

# Could be fetched via project settings
# ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity := 750
var run_speed := 150
var jump_speed := -300
enum State { IDLE, RUN, JUMP, HURT, DEAD}
var state := State.IDLE

func _ready():
	_change_state(State.IDLE)

func _change_state(_state: State) -> void:
	match _state:
		State.IDLE:
			$AnimationPlayer.play("idle")
		State.RUN:
			$AnimationPlayer.play("run")
		State.JUMP:
			$AnimationPlayer.play("jump_up")
		State.HURT:
			$AnimationPlayer.play("hurt")
		State.DEAD:
			hide()

func _get_input() -> void:
	var is_right_pressed := Input.is_action_pressed("right")
	var is_left_pressed := Input.is_action_pressed("left")
	var is_jump_pressed := Input.is_action_just_pressed("jump")

	if is_right_pressed:
		velocity.x += run_speed
	if is_left_pressed:
		velocity.x -= run_speed
	# Only allow jump if player is touching the floor
	if is_jump_pressed and is_on_floor():
		_change_state(State.JUMP)
		velocity.y = jump_speed
	
	if velocity.x != 0:
		_change_state(State.RUN)
	elif velocity.x == 0:
		_change_state(State.IDLE)

func _physics_process(_delta: float) -> void:
	_get_input()
	velocity.y += gravity * _delta
	move_and_slide()
	