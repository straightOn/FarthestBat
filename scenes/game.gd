class_name Game extends Node2D

enum GAME_STATE {
	NEW,
	STARTED,
	FINISHED
}

@onready var player: Player = %Player
@onready var ui = %Ui
@onready var scene_switcher = %SceneSwitcher

var score = 0

var game_state: GAME_STATE = GAME_STATE.NEW

func _ready():
	get_tree().paused = true
	start_game()

func _on_player_player_caught():
	set_state(GAME_STATE.FINISHED)
	scene_switcher.transition_to()

func start_game():
	get_tree().paused = false
	set_state(GAME_STATE.STARTED)
	Input.set_custom_mouse_cursor(null)
	ui.start_timer()
	player.zoom()

func set_state(new_state: GAME_STATE):
	game_state = new_state
	if game_state == GAME_STATE.FINISHED:
		pass

