extends Area2D


signal hit

func entered(body):
	if body.is_in_group("player"):
		print_debug("thing registers hit")
		emit_signal("hit")
