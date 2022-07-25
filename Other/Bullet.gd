extends Area2D


export var velocity = Vector2(0, 0)


signal hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("hit")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
