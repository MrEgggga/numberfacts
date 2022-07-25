extends KinematicBody2D


export var gravity = 1536.0
export var jump_force = 512.0
export var speed = 256.0
var yvel = 0.0
var jumps_left = 0


signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	yvel += gravity * delta
	var xvel = Input.get_axis("left","right") * speed
	var vel = Vector2(xvel, yvel)
	move_and_slide(vel, Vector2.UP)
	if is_on_floor():
		yvel = 0
		jumps_left = 2
	if is_on_ceiling():
		yvel = 0
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		jumps_left -= 1
		yvel = -jump_force


func hit():
	emit_signal("hit")
