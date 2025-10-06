extends Node

var over_text = false
var task_number = -1; 

@onready var root = get_tree().get_root()

var current_text_num = 0;

const tasks = {
	"0": [
		[
			"what's this? It looks broken?",
			"There's some small text here...",
			"It says [needs more light]"
		]
	],
	"1": [
		[
			"Oh, hello there free spirit!", 
			"Haven't seen you before, pretty small as well...", 
			"Not that it matters, we've been trapped in darkness for quite some time now. Could you help bring some light into our small world?", 
			"Something small like a lamp would be good, just place it by the town hall."
		],
		[
			"Thank you little for brighting our world!",
			"We haven't seen any light for ages, we were beginning to lose hope",
			"But this little light has strengthened our spirits",
			"I suppose it is time for you to go now",
			"May you have a safe and wonderful journey little one"
		]
	]
}
var task_completion = {
	"0": [false, [0, 0], false, false],
	"1": [
		false, [5, 2], false, false # format is [completed, [wish, willpower], player_talked_to_mission_npc, reward granted]
	]
}

func get_task_dialogue() -> Array:
	if (task_number >= 0 && task_completion[str(task_number)].size() > 0):
		return tasks[str(task_number)][1 if task_completion[str(task_number)][2] else 0]
	return []

func set_current_text_num(num) -> void:
	current_text_num = num
	
func set_task_number(num) -> void:
	task_number = num

func set_over_text(yes) -> void:
	over_text = yes

func get_mission_complete() -> bool:
	if (task_completion[str(task_number)].size() > 0):
		return task_completion[str(task_number)][0]
	return false
	
func get_spec_mission_complete(tn) -> bool:
	if (task_completion[str(tn)].size() > 0):
		return task_completion[str(tn)][0]
	return false
	
func get_mission_spec_dialogue_complete(tn) -> bool:
	if (task_completion[str(tn)].size() > 0):
		return task_completion[str(tn)][0]
	return false

func set_dialogue_mission_complete() -> void:
	if (task_completion[str(task_number)].size() > 0):
		task_completion[str(task_number)][2] = true
		if (task_completion[str(task_number)][0] && !task_completion[str(task_number)][3]):
			task_completion[str(task_number)][3] = true
			root.get_node("Main/Player/Camera2D/Control/UI").wish += task_completion[str(task_number)][1][0]
			root.get_node("Main/Player/Camera2D/Control/UI").willpower += task_completion[str(task_number)][1][1]
