extends CanvasLayer

var facts = []
var facts_path = "res://facts.tres"

func _ready():
	var facts_file = File.new()
	facts_file.open(facts_path, File.READ)
	var facts_lines = facts_file.get_as_text().split('\n')
	for i in facts_lines:
		if i == "":
			continue
		var line_split = i.split(": ")
		if line_split.size() != 2:
			facts.append("")
			continue
		facts.append(line_split[1])

func score(s):
	$Score.text = str(s)
	$FunFact.text = facts[s]
