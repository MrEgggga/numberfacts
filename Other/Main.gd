extends Node2D

var last_score = 0

export(Array, PackedScene) var modes
export(Array, String) var mode_inputs
export(Array, Array, String) var goals

var high_scores = []
var wins = []

export var game_index = 1
var next_game_index = game_index
export var hard = false
var next_hard = hard

var g


func _ready():
	for i in modes:
		high_scores.append([0, 0])
		wins.append([false, false])
	new_game()
	update_scores()


func over(score):
	last_score = score
	if score > high_scores[game_index][1 if hard else 0]:
		high_scores[game_index][1 if hard else 0] = score
	
	hard = next_hard
	game_index = next_game_index
	print_debug(hard, game_index)
	update_scores()
	
	new_game()


func new_game():
	$UI/Win.visible = false
	if g:
		g.queue_free()
	g = modes[game_index].instance()
	g.use_difficulty(hard)
	g.connect("over", self, "over")
	g.connect("won", self, "won")
	g.connect("score", self, "score")
	$Game.add_child(g)
	$Score.score(0)


func _process(delta):
	for i in range(modes.size()):
		if Input.is_action_just_pressed(mode_inputs[i]):
			next_game_index = i
	
	if Input.is_action_just_pressed("hard"):
		next_hard = not next_hard


func update_scores():
	$UI/Label.text = "game mode: %s (%s)\ngoal: %s" % [mode_inputs[game_index], "hard" if hard else "easy", goals[game_index][1 if hard else 0]]
	$UI/HighScore/Number.text = str(high_scores[game_index][1 if hard else 0]) + ("*" if wins[game_index][1 if hard else 0] else "")
	$UI/LastScore/Number.text = str(last_score)


func won():
	wins[game_index][1 if hard else 0] = true
	$UI/Win.visible = true


func score(score):
	$Score.score(score)
