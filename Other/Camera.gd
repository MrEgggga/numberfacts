extends Camera2D


export var level_bounds_left = 0
export var level_bounds_right = 512
export var level_bounds_top = 0
export var level_bounds_bottom = 512


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = clamp($"../Player".position.x, level_bounds_left + 256, level_bounds_right - 256)
	position.y = clamp($"../Player".position.y, level_bounds_top + 256, level_bounds_bottom - 256)
