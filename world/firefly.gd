class_name Firefly extends RigidBody2D

@onready var polygon_2d: Polygon2D = %Polygon2D
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var min_hp = -3
var max_hp = 6
var hp = 0
var color = Color(1,1,1)
var min_distance = 50
var max_distance = 200
var speed = 100

func _ready():
	hp = randi_range(min_hp, max_hp)
	color = ColorProvider.get_color_by_index(hp + 3)
	polygon_2d.color = color
	gpu_particles_2d.process_material.color = color
	# connect animation_finished of despawn to function for queue_free
	animation_player.animation_finished.connect(on_animation_finished)
	trigger_spawn_animation()

func _physics_process(delta):
	var direction_x = randi_range(-1, 1)
	var direction_y = randi_range(-1, 1)
	var direction = Vector2(direction_x, direction_y)
	move_and_collide(delta * direction * speed)

func get_eaten():
	# disable collision after eating
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	trigger_despawn_animation()
	
func trigger_spawn_animation():
	animation_player.play("spawn")
	pass

func trigger_despawn_animation():
	animation_player.play("despawn")
	pass

func on_animation_finished(signal_name: String):
	if signal_name == "despawn":
		destroy()

func destroy():
	animation_player.animation_finished.disconnect(on_animation_finished)
	queue_free()
