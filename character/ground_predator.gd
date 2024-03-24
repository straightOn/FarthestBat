class_name GroundPredator extends CharacterBody2D


const SPEED = 100.0
const CHASE_SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var body_polygons = %BodyPolygons
@onready var snarl_audio = %SnarlAudio
@onready var catch_audio = %CatchAudio

var target
var direction = 1
var max_chase_range = 450

func _physics_process(_delta):
	if target && !is_instance_valid(target):
		target_lost()
	if target:
		var target_distance = global_position.distance_to(target.global_position)
		if target_distance > max_chase_range || target.global_position.y < 600:
			target_lost()
			return
		else:
			velocity.x = global_position.direction_to(target.global_position).x * CHASE_SPEED
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	body_polygons.rotation_degrees = velocity.x / 10

		
	if move_and_slide():
		direction = direction * -1

func _on_detection_body_entered(body):
	if body is Bat && target == null:
		animation_player.play("attention")
		snarl_audio.play()
		direction = 0
		target = body

func target_lost():
	animation_player.play_backwards("attention")
	direction = 1
	target = null

func _on_attack_body_entered(body):
	if body is Bat:
		catch_audio.play()
		body.caught()
