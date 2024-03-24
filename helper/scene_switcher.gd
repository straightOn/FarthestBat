class_name SceneSwitcher extends CanvasLayer

@export var next_scene_path: String
@export var use_sprite = false
@onready var background = %Background
@onready var sprite_2d = %Sprite2D

func _process(delta):
	if visible:
		pass
	pass

func _ready() -> void:
	if use_sprite:
		sprite_2d.show()
	var tween = create_tween()
	tween.tween_property(background, "modulate", Color(0,0,0,0), 2)
	tween.play()
	await tween.finished
	hide()

func transition_to(_next_scene: String = next_scene_path) -> void:
	show()
	var new_scene = load(_next_scene)
	var tween = create_tween()
	tween.tween_property(background, "modulate", Color.BLACK, 2)
	tween.play()
	await tween.finished
	get_tree().change_scene_to_packed(new_scene)
