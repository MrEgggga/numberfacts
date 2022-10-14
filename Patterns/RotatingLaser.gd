extends Node2D


export var arms = 4
export var speed = 40
var player

signal hit


func use_difficulty(diff):
	speed = diff / 2.0
	arms = int(diff / 20)
	return self


func start(p, b):
	player = p
	$Lasers/Laser.speed = speed
	for i in range(1, arms):
		var arm = $Lasers/Laser.duplicate()
		arm.rect_rotation = 360.0 * (float(i) / arms)
		arm.speed = speed
		$Lasers.add_child(arm)
	for arm in $Lasers.get_children():
		arm.get_node("Collider").connect("hit", player, "hit")
	return self


func _on_Timer_timeout():
	for i in $Lasers.get_child_count():
		var l = $Lasers.get_child(i)
		l.color = Color.white
		l.get_node("Collider/Shape").disabled = false


func hit():
	print_debug("pattern registers hit")
	emit_signal("hit")
