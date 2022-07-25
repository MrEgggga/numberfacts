extends ColorRect


export var speed = 180


func _process(delta):
	rect_rotation -= speed * delta
