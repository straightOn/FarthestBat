extends Area2D

@onready var collision_shape_2d = %CollisionShape2D
@onready var fire_fly_scene = preload("res://world/firefly.tscn")
@onready var spawn_timer: Timer = %SpawnTimer

var min_amount = 5
var max_amount = 15
var amount_limit
var amount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	amount_limit = randi_range(min_amount, max_amount)

func get_random_location_in_area():
	# Get the size of the collision shape
	var shape_extents = collision_shape_2d.shape.extents

	# Calculate random coordinates within the collision shape
	var random_x = randf_range(-shape_extents.x, shape_extents.x)
	var random_y = randf_range(-shape_extents.y, shape_extents.y)

	# Return the random position vector
	return Vector2(random_x, random_y)

func create():
	if !amount_limit:
		return
	if amount >= amount_limit:
		return
	var new_firefly = fire_fly_scene.instantiate()
	new_firefly.position = get_random_location_in_area()
	new_firefly.destroyed.connect(on_firefly_destroyed)
	collision_shape_2d.add_child(new_firefly)
	amount += 1

func on_firefly_destroyed():
	amount -= 1
	
func _on_spawn_timer_timeout():
	create()
	spawn_timer.wait_time = randf_range(0.1, 2)
