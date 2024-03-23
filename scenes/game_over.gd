extends Node2D

@onready var scene_switcher = %SceneSwitcher

func _on_replay_pressed():
	scene_switcher.transition_to()
