class_name AiBat extends Node2D

@onready var bat: Bat = %Bat
@onready var ai_controller: AiController = %AiController

signal position_updated(new_position: Vector2)
signal caught

# Called when the node enters the scene tree for the first time.
func _ready():
	bat.position_updated.connect(on_position_updated)
	bat.on_caught.connect(destroy)

func on_position_updated(new_position: Vector2):
	ai_controller.position_updated(new_position)

func _on_detection_area_body_entered(body):
	ai_controller.target_in_range(body)

func destroy():
	caught.emit()
	queue_free()
