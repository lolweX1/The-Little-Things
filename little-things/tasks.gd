extends Node

var over_text = false
var task_number = -1; 

var current_text_num = 0;

const tasks = {
	"0": [
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
	"0": [
		false, [5, 2] # format is [completed, [xp, willpower]]
	]
}

func get_task_dialogue(complete = false) -> Array:
	if (task_number >= 0):
		return tasks[str(task_number)][1 if complete else 0]
	return []

func set_current_text_num(num) -> void:
	current_text_num = num
	
func set_task_number(num) -> void:
	task_number = num

func set_over_text(yes) -> void:
	over_text = yes
