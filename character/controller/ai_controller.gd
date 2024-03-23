class_name AiController extends BaseController

var target
var current_position: Vector2
@export var max_range = 200

var idle_y = 620
var idle_x = 680
var input_delay = 0
var target_input_delay = 20

func position_updated(new_position: Vector2):
	#check distance to target
	current_position = new_position
	if target && !is_instance_valid(target):
		target = null
	if target is Node2D:
		if new_position.distance_to(target.global_position) > max_range:
			target = null
	else:
		if abs(idle_y - new_position.y) < 1:
			idle_y = randi_range(300, 620)
		if abs(idle_x - new_position.x) < 1:
			idle_x = randi_range(200, 1080)

func target_in_range(_target: Node2D):
	if !target && _target is Firefly && _target.has_positiv_hp():
		target = _target

func _on_timer_timeout():
	if !current_position:
		return
	# idle if no target is near
	if !target:
		if current_position.y >= idle_y:
			flap_command.execute(character, null)
		var direction = 0
		if current_position.x <= idle_x:
			direction = 1
		else:
			direction = -1
		move_command.execute(character, direction)
	else:
		if current_position.y > target.global_position.y:
			flap_command.execute(character, null)
		var direction = 0
		if current_position.x < target.global_position.x:
			direction = 1
		else:
			direction = -1
		move_command.execute(character, direction)
