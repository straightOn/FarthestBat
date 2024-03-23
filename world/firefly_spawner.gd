extends Area2D

@onready var collision_shape_2d = %CollisionShape2D
@onready var fire_fly_scene = preload("res://world/firefly.tscn")

var min_amount = 5
var max_amount = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_amount = randi_range(min_amount, max_amount)
	for i in range(random_amount):
		var new_firefly = fire_fly_scene.instantiate()
		new_firefly.position = get_random_location_in_area()
		collision_shape_2d.add_child(new_firefly)

func get_random_location_in_area():
	# Get the size of the collision shape
	var shape_extents = collision_shape_2d.shape.extents

	# Calculate random coordinates within the collision shape
	var random_x = randf_range(-shape_extents.x, shape_extents.x)
	var random_y = randf_range(-shape_extents.y, shape_extents.y)

	# Return the random position vector
	return Vector2(random_x, random_y)
