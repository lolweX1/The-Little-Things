extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func write_text() -> bool:
	var dialogue = tasks.get_task_dialogue()
	for text in dialogue:
		$Text_area/Text.text = ""
		$Text_area/Enter.visible = false
		for i in text:
			$Text_area/Text.text += i
			await get_tree().create_timer(0.05).timeout
		$Text_area/Enter.visible = true
		await wait_for_enter()
	return true
	
func write_text_param(dialogue: Array) -> bool:
	for text in dialogue:
		$Text_area/Text.text = ""
		$Text_area/Enter.visible = false
		for i in text:
			$Text_area/Text.text += i
			await get_tree().create_timer(0.05).timeout
		$Text_area/Enter.visible = true
		await wait_for_enter()
	return true

func wait_for_enter() -> bool:
	while true:
		await get_tree().process_frame
		if (Input.is_action_just_pressed("next")):
			return true
	return false
