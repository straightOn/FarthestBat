class_name Bat extends CharacterBody2D

@onready var animation_player: AnimationPlayer = %BatAnimation
@onready var score: Label = %Score
@onready var label_animation: AnimationPlayer = %LabelAnimation
@onready var stamina_bar: ProgressBar = %StaminaBar
@onready var wind_particles_left = %WindParticlesLeft
@onready var wind_particles_right = %WindParticlesRight
@onready var caught_particles = %CaughtParticles
@onready var flap_audio = %FlapAudio
@onready var snack_audio = %SnackAudio

const SPEED = 300.0
const DECELERATION = 250.0
const ACCELERATION = 500.0
const FLAP_VELOCITY = -150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 200
var default_gravity = 200
var stamina = 100
var flap_cost = 3
var flapping = false
var direction = 0
var active = true
var endless_stamina = false

signal on_caught
signal will_be_destroyed
signal position_updated(new_position: Vector2)
signal add_score(amount: int)

func _ready():
	init()

func init():
	stamina = 100
	animation_player.play("flap")
	flap_audio.play()
	flap_audio.finished.connect(on_flap_audio_finished)
	flapping = true

func on_flap_audio_finished():
	flap_audio.play()

func enable_endless_stamina():
	endless_stamina = true
	stamina_bar.get("theme_override_styles/fill").bg_color = Color.HOT_PINK

func disable_gravity():
	gravity = 0

func set_direction(new_direction: int):
	if !active || gravity == 0:
		return
	direction = new_direction

func flap():
	if gravity != default_gravity:
		gravity = default_gravity
	if stamina <= 0 || !active:
		return
	velocity.y = FLAP_VELOCITY 
	update_stamina(stamina - 2)
	if !flapping:
		flapping = true
		animation_player.play("flap")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.y < 0:
		animation_player.set_speed_scale(3.0)
		# emit particle
		wind_particles_left.emitting = true
		wind_particles_right.emitting = true		
		flap_audio.pitch_scale = 1
	else:
		animation_player.set_speed_scale(1.0)
		wind_particles_left.emitting = false
		wind_particles_right.emitting = false
		flap_audio.pitch_scale = 0.5
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	rotation_degrees = velocity.x / 10
	move_and_slide()
	position_updated.emit(global_position)

func update_stamina(new_stamina: float):
	if endless_stamina:
		return
	if stamina == new_stamina:
		return
	stamina = new_stamina
	stamina_bar.value = stamina
	var stamina_percentage = (stamina_bar.value * stamina_bar.max_value) / 100
	stamina_bar.get("theme_override_styles/fill").bg_color = ColorProvider.get_color_for_percentage(stamina_percentage)

func _on_eat_area_body_entered(body):
	if body is Firefly:
		var color = body.color
		var points = body.hp
		add_score.emit(points)
		score.label_settings.font_color = color
		score.text = str(points)
		update_stamina(stamina + points)
		label_animation.play("score")
		snack_audio.play()
		body.get_eaten()

func caught():
	# splatter-particle here
	active = false
	caught_particles.emitting = true
	on_caught.emit()
	caught_particles.finished.connect(destroy)

func destroy():
	will_be_destroyed.emit()
