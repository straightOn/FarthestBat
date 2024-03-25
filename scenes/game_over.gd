extends Node2D

@onready var scene_switcher = %SceneSwitcher

func _on_replay_pressed():
	scene_switcher.transition_to()


func _on_replay_2_pressed():
	scene_switcher.transition_to("res://scenes/start.tscn")
