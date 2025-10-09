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
		], [
			"Would you like to enter the realm of the spirits?",
			"If you do so, there is no return"
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
	],
	"2": [
		["Oh hello there little one,",
		"What are you doing here in this cave?",
		"What am I doing here?",
		"I have to pay for my sins",
		"What do I need? I don't need anything",
		"I wish you best of luck"], 
		["Oh hello there little one,",
		"What are you doing here in this cave?",
		"What am I doing here?",
		"I have to pay for my sins",
		"What do I need? I don't need anything",
		"I wish you best of luck"]
	],
	"3": [
		[
			"Wow you got me? That's unexpected",
			"Have a reward",
			"Press Q to go back into spectral form"
		],
		[
			"Wow you got me? That's unexpected",
			"Have a reward",
			"Press Q to go back into spectral form"
		]
	]
}
var task_completion = {
	"0": [false, [0, 0], false, false, false],
	"1": [
		false, [25, 2], false, false, false # format is [completed, [wish, willpower], player_talked_to_mission_npc, reward granted, gave_quest_req_to_player]
	],
	"2": [true, [75, 0], false, false, true], # when only dialogue is needed, you can set completed and gave_quest_req_to_player to true
	"3": [true, [50, 10], true, false,true]
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

func is_communicated() -> bool:
	return task_completion[str(task_number)][4];
func did_communicate():
	task_completion[str(task_number)][4] = true

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
			player_stats.wish += task_completion[str(task_number)][1][0]
			player_stats.willpower += task_completion[str(task_number)][1][1]
		# detect if level up
		if (player_stats.wish >= player_stats.wish_max[player_stats.level]):
			player_stats.wish -= player_stats.wish_max[player_stats.level]
			player_stats.level += 1
			
