extends Node2D


signal score(s)
signal over(score)
signal won


var score = 0

export var hard_delay = 30
export var easy_delay = 60
export var hard_win = 12.0
export var easy_win = 10.0


func use_difficulty(hard):
	if hard:
		$Clones.delay = hard_delay
		$Timer.wait_time = hard_win
	else:
		$Clones.delay = easy_delay
		$Timer.wait_time = easy_win


# Called when the node enters the scene tree for the first time.
func _ready():
	$Clones.start($Player, self)
	$DeathFloor.start($Player, self)
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
