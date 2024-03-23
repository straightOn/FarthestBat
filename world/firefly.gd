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

var colors: Array[Color] = [
	Color(0.86, 0.08, 0.24), #dark red
	Color(1,0,0), #red
	Color(1, 0.14, 0), #vibrant red-orange
	Color(1, 0.39, 0.28), #bright orange-red
	Color(1, 0.55, 0), #dark orange
	Color(1, 1, 0), # pure yellow
	Color(1, 0.84, 0), #golden yellow
	Color(0.5, 1, 0), #bright green-yellow
	Color(0.5, 1, 0.2), #vibrant yellow-green
	Color(0, 1, 0) #pure green
]

func _ready():
	hp = randi_range(min_hp, max_hp)
	color = colors[hp + 3]
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
