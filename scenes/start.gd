extends Node2D

@onready var spy_glass = preload("res://assets/spyglass.png")
@onready var ai_bat_scene = preload("res://character/ai_bat.tscn")
@onready var player_name: TextEdit = %PlayerName
@onready var scene_switcher: SceneSwitcher = %SceneSwitcher

var active_bats: int
var max_bats = 3

func _ready():
	create_bat()

func create_bat():
	if active_bats >= max_bats:
		return
	var new_bat = ai_bat_scene.instantiate()
	add_child(new_bat)
	new_bat.global_position = Vector2(698, 600)
	new_bat.will_be_destroyed.connect(bat_caught)
	active_bats += 1

func bat_caught():
	active_bats -= 1
	
func _on_spawn_timer_timeout():
	create_bat()

func _on_button_pressed():
	if player_name.text != "":
		scene_switcher.transition_to()
