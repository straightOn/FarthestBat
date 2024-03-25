class_name Player extends Node2D

@onready var camera_animation: AnimationPlayer = %CameraAnimation
@onready var bat: Bat = %Bat

signal player_caught
signal player_scored(amount: int)

func _ready():
	bat.on_caught.connect(caught)
	bat.add_score.connect(score_added)
	bat.disable_gravity()

func score_added(amount: int):
	player_scored.emit(amount)

func caught():
	player_caught.emit()

func start():
	zoom()

func zoom():
	camera_animation.play("zoom_in")
	
func enable_endless_stamina():
	bat.enable_endless_stamina()
