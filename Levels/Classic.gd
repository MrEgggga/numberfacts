extends Node2D


signal score(s)
signal over(score)
signal won


var score = 0


func use_difficulty(hard):
	if hard:
		$Pattern.wait_time = 0.18
	else:
		$Pattern.wait_time = 0.3


# Called when the node enters the scene tree for the first time.
func _ready():
	$Pattern.start($Player)
	$Player.connect("hit", self, "over")


func _on_ScoreTimer_timeout():
	score += 1
	emit_signal("score", score)
	if score == 30:
		emit_signal("won")


func over():
	emit_signal("over", score)
