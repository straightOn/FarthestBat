class_name Firefly extends RigidBody2D

@onready var polygon_2d: Polygon2D = %Polygon2D
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D

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

func _physics_process(delta):
	var direction_x = randi_range(-1, 1)
	var direction_y = randi_range(-1, 1)
	var direction = Vector2(direction_x, direction_y)
	move_and_collide(delta * direction * speed)

func get_eaten():
	# maybe animation or particle for eating
	queue_free()
