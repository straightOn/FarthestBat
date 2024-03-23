class_name Bat extends CharacterBody2D

@onready var animation_player: AnimationPlayer = %BatAnimation
@onready var score: Label = %Score
@onready var label_animation: AnimationPlayer = %LabelAnimation
@onready var stamina_bar: ProgressBar = %StaminaBar

const SPEED = 300.0
const DECELERATION = 250.0
const ACCELERATION = 500.0
const FLAP_VELOCITY = -150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 200
var stamina = 100
var flap_cost = 2
var flapping = false

signal on_catched

func _ready():
	init()

func init():
	stamina = 100
	animation_player.play("flap")
	flapping = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
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

func _input(event):
	if event.is_action_pressed("ui_accept"):
		velocity.y = FLAP_VELOCITY
		update_stamina(stamina - 2)
		if !flapping:
			flapping = true
			animation_player.play("flap")

func update_stamina(new_stamina: float):
	stamina = new_stamina
	stamina_bar.value = stamina
	stamina_bar.get("theme_override_styles/fill").bg_color = ColorProvider.get_color_for_percentage(stamina)

func _on_eat_area_body_entered(body):
	if body is Firefly:
		var color = body.color
		var points = body.hp
		score.label_settings.font_color = color
		score.text = str(points)
		update_stamina(stamina + points)
		label_animation.play("score")
		body.get_eaten()

func catched():
	# splatter-particle here
	print("### catched called")
	animation_player.play("catched")
	on_catched.emit()
