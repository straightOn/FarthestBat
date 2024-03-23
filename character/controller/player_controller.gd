class_name PlayerController extends BaseController

func _process(_delta):
	move_command.execute(character, Input.get_axis("ui_left", "ui_right"))

func _input(event):
	if event.is_action_pressed("ui_accept"):
		flap_command.execute(character, null)
