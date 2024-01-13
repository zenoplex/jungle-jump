extends MarginContainer
class_name HUD

@onready var score_label: Label = get_node("HBoxContainer/ScoreLabel")
@onready var life_counter: HBoxContainer = get_node("HBoxContainer/LifeCounter")

func set_life(_life: int) -> void:
	# NOTE: Max displayable life is 5 due to UI restriction.
	# Maybe append depending on setting first.
	var children := life_counter.get_children()
	for i in life_counter.get_child_count():
		var child := children[i]
		if child is TextureRect:
			child.visible = i < _life
	
func set_score(_score: int) -> void:
	score_label.text = str(_score)
