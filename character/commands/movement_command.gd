class_name MovementCommand extends Command

func execute(character: Bat, data) -> void:
	character.set_direction(data)
