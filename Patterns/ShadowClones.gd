extends Node2D


# previous positions of player. item 0 is most recent.
var buffer = []
var last_position
var buffer_length = 1000

var player

export(PackedScene) var clone
var clones = []
export var clone_spacing = 60
export var num_clones = 5
export var delay = 0

var running = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.visible = running
	$Label.text = str(num_clones - clones.size())
	if running:
		buffer.push_front(player.position)
		if buffer.size() % clone_spacing == 0 && buffer.size() <= buffer_length && buffer.size() > delay:
			print_debug(clones.size())
			var c = clone.instance()
			clones.append(c)
			c.connect("hit", player, "hit")
			add_child(c)
		if buffer.size() > buffer_length:
			buffer.pop_back()
		for c in range(clones.size()):
			clones[c].position = buffer[delay + (c+1) * clone_spacing - 1]
	else:
		if last_position:
			if (player.position - last_position).length_squared() > 100.0:
				running = true
				$Label.rect_position = player.position - Vector2(10, 10)
		else:
			last_position = player.position


func use_difficulty(diff):
	clone_spacing = int(4000 / diff)
	num_clones = int(diff / 10)
	buffer_length = clone_spacing * num_clones + delay
	return self

func start(p, b):
	player = p
	return self
