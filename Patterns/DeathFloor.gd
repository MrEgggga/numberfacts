extends ColorRect


export var speed = 16.0
var player


func _process(delta):
	margin_top -= speed * delta
	if player.position.y > margin_top - 12:
		player.hit()


func use_difficulty(diff):
	speed = diff / 3
	return self


func start(p,b):
	player = p
	return self
