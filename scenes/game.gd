class_name Game extends Node2D

enum GAME_STATE {
	NEW,
	STARTED,
	FINISHED
}

@onready var player: Player = %Player
@onready var ui = %Ui
@onready var scene_switcher = %SceneSwitcher
@onready var ai_bat_scene = preload("res://character/ai_bat.tscn")
@onready var player_vars = get_node("/root/PlayerVariables")
@onready var ai_spawner: Timer = %AiSpawner
@onready var enemy_label: Label = %Enemy
@onready var info_box = %Info
@onready var cheat = %Cheat
@onready var general = %General


var score = 0
var player_name: String
var active_bats: int
var max_bats = 3

var game_state: GAME_STATE = GAME_STATE.NEW

func _ready():
	player_name = player_vars.player_name
	general.text = player_name.to_upper() + ", " + general.text
	max_bats = randi_range(1, floor(player_name.length()))
	enemy_label.text = "Es gibt " + str(max_bats) + " Konkurrenten"
	if player_name.to_lower() == "batman":
		cheat.show()
		player.enable_endless_stamina()
	player.player_scored.connect(on_player_scored)
	player.zoom()

func on_player_scored(amount: int):
	ui.update_score(amount)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()

func _on_player_player_caught():
	set_state(GAME_STATE.FINISHED)
	ai_spawner.stop()
	ui.game_over()
	await ui.finished_animation_done
	scene_switcher.transition_to()

func hide_info():
	var tween = create_tween()
	for child in info_box.get_children():
		tween.tween_property(child, "modulate", Color.TRANSPARENT, 1)
	tween.play()
	await tween.finished
	info_box.hide()

func start_game():
	set_state(GAME_STATE.STARTED)
	Input.set_custom_mouse_cursor(null)
	ai_spawner.start()
	hide_info()

func set_state(new_state: GAME_STATE):
	game_state = new_state
	if game_state == GAME_STATE.FINISHED:
		pass
		
func create_ai_bat():
	if active_bats >= max_bats:
		return
	var new_bat = ai_bat_scene.instantiate()
	add_child(new_bat)
	new_bat.global_position = Vector2(698, 600)
	new_bat.will_be_destroyed.connect(bat_caught)
	active_bats += 1

func bat_caught():
	active_bats -= 1

func _on_ai_spawner_timeout():
	create_ai_bat()
