extends CanvasLayer

func _ready():
	if is_mobile_device():
		show()
	else:
		hide()

func is_mobile_device() -> bool:
	return OS.get_name() == "Android"
