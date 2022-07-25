extends Node2D


var current_direction = Vector2(-1, 0)
export(PackedScene) var bullet
export var bullet_speed = 256
export var min_player_distance = 100
export var wait_time = 0.3
var player


signal hit

func _on_Timer_timeout():
	if(not player): return
	var b = bullet.instance()
	b.position = Vector2(256, 256) - 256 * current_direction
	if current_direction.x == 0:
		b.position.x = player.position.x
	else:
		b.position.y = player.position.y
	b.velocity = current_direction * bullet_speed
	b.connect("hit", player, "hit")
	if (b.position - player.position).length() > min_player_distance:
		$"..".add_child(b)
	else:
		b.queue_free()
	current_direction = Vector2(-current_direction.y, current_direction.x)

func start(p):
	player = p
	$Timer.wait_time = wait_time
	return self

func use_difficulty(diff):
	wait_time = 30 / diff
	return self

func hit():
	emit_signal("hit")
