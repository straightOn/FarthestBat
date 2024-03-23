class_name PlayerUi extends CanvasLayer

@onready var score_timer: Timer = %ScoreTimer
@onready var score_label: Label = %ScoreLabel

var score: float = 0

func _on_score_timer_timeout():
	score += 1
	score_label.text = str(score)

func start_timer():
	score_timer.start()
	
func stop_timer():
	score_timer.stop()

func reset():
	score = 0
