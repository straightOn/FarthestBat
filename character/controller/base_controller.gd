class_name BaseController extends Node

@export var character: Bat

var move_command:= MovementCommand.new()
var flap_command:= FlapCommand.new()

func _ready():
	character.will_be_destroyed.connect(destroy)

func destroy():
	queue_free()
