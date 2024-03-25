class_name Highscores extends Resource

var highscores = []

func add_highscore(score, player_name):
	highscores.append({"name": player_name, "score": score})
	highscores.sort_custom(compare_scores)
	if highscores.size() > 10:
		highscores.resize(10)
	
func compare_scores(a, b):
	return a["score"] - b["score"] if "score" in a and "score" in b else 0

func get_highscores(number: int):
	var result = ""
	for entry in highscores:
		result = result + entry["name"] + ": " + str(entry["score"]) + "\n"
		number -=1
		if number <= 0:
			break
	return result
