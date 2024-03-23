extends Node2D

enum GAME_STATE {
	NEW,
	STARTED,
	FINISHED
}

@onready var player: Player = %Player
@onready var ui = %Ui

var score = 0

var game_state: GAME_STATE = GAME_STATE.NEW

func _ready():
	start_game()

func _on_player_on_caught():
	set_state(GAME_STATE.FINISHED)
	player.player_caught()
	# show game over + highscore
	pass
	
func reset_game():
	game_state = GAME_STATE.NEW
	ui.reset()

func start_game():
	set_state(GAME_STATE.STARTED)
	Input.set_custom_mouse_cursor(null)
	ui.start_timer()
	player.zoom()

func set_state(new_state: GAME_STATE):
	game_state = new_state
	if game_state == GAME_STATE.FINISHED:
		pass
