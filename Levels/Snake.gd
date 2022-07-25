extends Node2D


signal score(s)
signal over(score)
signal won


var score = 0


func use_difficulty(hard):
	if hard:
		$Clones.delay = 30
		$Timer.wait_time = 12.0
	else:
		$Clones.delay = 60
		$Timer.wait_time = 10.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Clones.start($Player)
	$DeathFloor.start($Player)
	$Player.connect("hit", self, "hit")


func _process(delta):
	$UI/Time.text = "%1.1f" % [$Timer.time_left]


func hit():
	emit_signal("over", score)


func _on_Timer_timeout():
	emit_signal("won")


func _on_ScoreTimer_timeout():
	score += 1
	emit_signal("score", score)
