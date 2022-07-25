extends Node2D



export(PoolStringArray) var facts = ["wow facts"]
var score = 0
export(Array, PackedScene) var patterns
export(Array, PackedScene) var maps

export var pattern_time_start = 4.0
export var pattern_time_delta = 0.5
export var pattern_time_max = 15.0
var pattern_time = pattern_time_start

export var break_time_start = 0.7
export var break_time_multiplier = 1.0
export var break_time_min = 0.2
export var break_time_max = 1.5
var break_time = break_time_start

export var difficulty_start = 70.0
export var difficulty_delta = 10.0
export var difficulty_max = 100.0
var difficulty = difficulty_start


signal score(s)
signal over(score)
signal won


func use_difficulty(hard):
	if hard:
		pattern_time_start = 5.0
		pattern_time_delta = 1.0
		
		break_time_start = 0.5
		break_time_multiplier = 0.9
		
		difficulty_start = 100.0
		difficulty_delta = 10.0
		difficulty_max = 120.0
	else:
		pattern_time_start = 3.5
		pattern_time_delta = 0.7
		
		break_time_start = 0.7
		break_time_multiplier = 1.0
		
		difficulty_start = 70.0
		difficulty_delta = 10.0
		difficulty_max = 100.0


func _ready():
	randomize()
	setup_map()
	reset_patterns()
	$Player.connect("hit", self, "game_over")


func _process(_delta):
	$Canvas/Score.text = str(score)
	$Canvas/FunFact.text = facts[score] if score < facts.size() else ""
	$Background/WaveTime.text = "%1.1f" % [$ChangePattern.time_left]


func _on_ScoreTimer_timeout():
	score += 1
	emit_signal("score", score)


func setup_map():
	var which_map = maps[randi() % maps.size()]
	var map = which_map.instance()
	$Level.add_child(map)


func reset_patterns():
	pattern_time += pattern_time_delta
	pattern_time = clamp(pattern_time, 0, pattern_time_max)
	break_time *= break_time_multiplier
	break_time = clamp(break_time, break_time_min, break_time_max)
	difficulty += difficulty_delta
	difficulty = clamp(difficulty, 0.0, difficulty_max)
	
	$ChangePattern.wait_time = pattern_time + break_time
	for i in $Patterns.get_children():
		i.queue_free()
	
	yield(get_tree().create_timer(break_time), "timeout")
	
	setup_patterns()

func setup_patterns():
	var which_patterns = []
	
	for i in patterns:
		if randi() % 2 == 0:
			which_patterns.append(i)
	
	var num_patterns = which_patterns.size()
	if num_patterns == 0:
		return setup_patterns()

	var each_difficulty = difficulty / sqrt(num_patterns)
	
	for i in which_patterns:
		var p = i.instance().use_difficulty(each_difficulty).start($Player)
		$Patterns.add_child(p)


func _on_ChangePattern_timeout():
	reset_patterns()


func game_over():
	emit_signal("over", score)
