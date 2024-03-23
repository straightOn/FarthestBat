class_name Player extends Node2D

@onready var camera_animation: AnimationPlayer = %CameraAnimation

func start():
	zoom()

func zoom():
	camera_animation.play("zoom_in")
