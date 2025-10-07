extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body is CharacterBody2D):
		$Area/Press_E.visible = true
		tasks.set_over_text(true)


func _on_body_exited(body: Node2D) -> void:
	if (body is CharacterBody2D):
		$Area/Press_E.visible = false
		tasks.set_over_text(false)

func set_num(body: Node2D, num) -> void:
	tasks.set_task_number(num)
