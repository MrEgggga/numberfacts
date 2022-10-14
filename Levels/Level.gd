extends Node2D


signal score(s)
signal over(s)
signal won

var winned = false
export var goal_position = 3648


func use_difficulty(hard):
	if hard:
		$pattern.wait_time = 0.18
	else:
		$pattern.wait_time = 0.3


# Called when the node enters the scene tree for the first time.
func _ready():
	$pattern.screen_edges = $Camera
	$pattern.offset = Vector2.ZERO
	$pattern.start($Player, self)
	$Player.connect("hit", self, "over")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("score", int(($Player.position.x / goal_position) * 100))
	if $Player.position.x > goal_position and not winned:
		emit_signal("won")
		winned = true


func over():
	emit_signal("over", int(($Player.position.x / goal_position) * 100))
