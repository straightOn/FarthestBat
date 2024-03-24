extends CanvasLayer

@onready var spyglass_animation = %SpyglassAnimation

func zoom():
	spyglass_animation.play("zoom")
