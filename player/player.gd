extends CharacterBody2D
class_name Player

# Could be fetched via project settings
# ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity := 750
var run_speed := 150
var jump_speed := -300
enum State { IDLE, RUNNING, JUMPING, HURT, DEAD}
var state := State.IDLE

func _ready():
		change_state(State.IDLE)

func change_state(_state: State) -> void:
	match _state:
		State.IDLE:
			$AnimationPlayer.play("idle")
		State.RUNNING:
			$AnimationPlayer.play("run")
		State.JUMPING:
			$AnimationPlayer.play("jump_up")
		State.HURT:
			$AnimationPlayer.play("hurt")
		State.DEAD:
			hide()
