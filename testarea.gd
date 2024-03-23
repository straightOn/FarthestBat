extends Node2D

enum GAME_STATE {
	NEW,
	STARTED,
	FINISHED
}

@onready var spy_glass = preload("res://assets/spyglass.png")
@onready var camera_animation: AnimationPlayer = %CameraAnimation
@onready var score_label: Label = %ScoreLabel
@onready var score_timer: Timer = %ScoreTimer
@onready var ui: CanvasLayer = %Ui

var score = 0

var game_state: GAME_STATE = GAME_STATE.NEW

func _on_player_on_catched():
	set_state(GAME_STATE.FINISHED)
	score_timer.stop()
	# show game over + highscore
	pass
	
func reset_game():
	game_state = GAME_STATE.NEW
	Input.set_custom_mouse_cursor(null)

func start_game():
	set_state(GAME_STATE.STARTED)
	Input.set_custom_mouse_cursor(null)
	camera_animation.play("zoom_in")
	ui.show()
	score = 0
	score_timer.start()

func set_state(new_state: GAME_STATE):
	game_state = new_state
	if game_state == GAME_STATE.FINISHED:
		#get_tree().paused = true
		pass

func _on_mouse_area_mouse_entered():
	if game_state == GAME_STATE.NEW:
		Input.set_custom_mouse_cursor(spy_glass, Input.CursorShape.CURSOR_ARROW, Vector2(100, 100))

func _on_mouse_area_mouse_exited():
	if game_state == GAME_STATE.NEW:
		Input.set_custom_mouse_cursor(null)

func _on_mouse_area_input_event(_viewport, event, _shape_idx):
	if game_state == GAME_STATE.NEW && event.is_action_pressed("click"):
		start_game()

func _on_timer_timeout():
	score += 1
	score_label.text = str(score)
	
