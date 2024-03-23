extends Node2D

enum GAME_STATE {
	NEW,
	STARTED,
	FINISHED
}

@onready var spy_glass = preload("res://assets/spyglass.png")
@onready var camera_animation: AnimationPlayer = %CameraAnimation

var game_state: GAME_STATE = GAME_STATE.NEW

func _on_player_on_catched():
	game_state = GAME_STATE.FINISHED
	# show game over + highscore
	pass
	
func reset_game():
	game_state = GAME_STATE.NEW
	Input.set_custom_mouse_cursor(null)

func start_game():
	game_state = GAME_STATE.STARTED
	Input.set_custom_mouse_cursor(null)
	camera_animation.play("zoom_in")


func _on_mouse_area_mouse_entered():
	if game_state == GAME_STATE.NEW:
		Input.set_custom_mouse_cursor(spy_glass, Input.CursorShape.CURSOR_ARROW, Vector2(100, 100))

func _on_mouse_area_mouse_exited():
	if game_state == GAME_STATE.NEW:
		Input.set_custom_mouse_cursor(null)


func _on_mouse_area_input_event(_viewport, event, _shape_idx):
	if game_state == GAME_STATE.NEW && event.is_action_pressed("click"):
		start_game()
