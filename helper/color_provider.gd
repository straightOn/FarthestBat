class_name ColorProvider extends Object

static func get_colors() -> Array[Color]:
	return [
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

static func get_color_by_index(index: int) -> Color:
	if index < ColorProvider.get_colors().size():
		return ColorProvider.get_colors()[index]
	return Color(1,1,1)

static func get_color_for_percentage(percentage: float) -> Color:
	if percentage < 10:
		return get_colors()[1]
	if percentage < 30:
		return get_colors()[3]
	if percentage < 50:
		return get_colors()[5]
	if percentage < 70:
		return get_colors()[7]
	if percentage < 95:
		return get_colors()[8]
	return get_colors()[9] 
