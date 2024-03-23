class_name Player extends Node2D

@onready var camera_animation: AnimationPlayer = %CameraAnimation
@onready var bat: Bat = %Bat

signal player_caught

func _ready():
	bat.will_be_destroyed.connect(caught)

func caught():
	player_caught.emit()

func start():
	zoom()

func zoom():
	camera_animation.play("zoom_in")
