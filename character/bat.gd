class_name Bat extends CharacterBody2D

@onready var animation_player: AnimationPlayer = %BatAnimation
@onready var score: Label = %Score
@onready var label_animation: AnimationPlayer = %LabelAnimation

const SPEED = 300.0
const DECELERATION = 250.0
const ACCELERATION = 500.0
const JUMP_VELOCITY = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 200
signal on_catched

func _ready():
	animation_player.play("flap")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	if velocity.y < 0:
		animation_player.set_speed_scale(3.0)
	else:
		animation_player.set_speed_scale(1.0)
			
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		
	rotation_degrees = velocity.x / 10
		
	move_and_slide()


func _on_eat_area_body_entered(body):
	if body is Firefly:
		var color = body.color
		var points = body.hp
		score.label_settings.font_color = color
		score.text = str(points)
		label_animation.play("score")
		body.get_eaten()

func catched():
	# splatter-particle
	on_catched.emit()
	queue_free()
