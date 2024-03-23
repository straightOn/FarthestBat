class_name SceneSwitcher extends CanvasLayer

@export var next_scene_path: PackedScene
@onready var background = %Background

func _ready() -> void:
	background.position = Vector2(0, 0)
	background.modulate = Color.BLACK
	var tween = create_tween()
	tween.tween_property(background, "modulate", Color.TRANSPARENT, 2)
	tween.play()
	await tween.finished	
	background.position = Vector2(0, 768)
	background.modulate = Color.BLACK

func transition_to(_next_scene := next_scene_path) -> void:
	var tween = create_tween()
	tween.tween_property(background, "position", Vector2(0, 0), 1)
	tween.play()
	await tween.finished
	get_tree().change_scene_to_packed(_next_scene)
