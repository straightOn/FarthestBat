class_name PlayerUi extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var score_animator = %ScoreAnimator

var score: int = 0
signal finished_animation_done
	
func game_over():
	score_animator.play("finished")
	await score_animator.animation_finished
	finished_animation_done.emit()

func add_score(amount: int):
	update_score(amount)
	
func update_score(amount: int):
	score += amount
	score_label.text = "Score: " + str(score)
	if amount > 0:
		score_animator.play("pulse_green")
	else:
		score_animator.play("pulse_red")
