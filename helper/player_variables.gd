extends Node

var player_name: String
var highscores: Highscores

const HIGHSCORE_PATH = "user://highscores.json"

func _ready():
	load_highscores()

func save_highscores():
	var result = ResourceSaver.save(highscores, HIGHSCORE_PATH)
	pass

func load_highscores():
	if ResourceLoader.exists(HIGHSCORE_PATH):
		highscores = ResourceLoader.load(HIGHSCORE_PATH)
	else:
		highscores = Highscores.new()
		save_highscores()

func get_highscores(number: int):
	return highscores.get_highscores(number)

func add_highscore(score):
	highscores.add_highscore(score, player_name)
