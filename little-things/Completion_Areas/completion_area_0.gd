extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "lamp"):
		tasks.task_completion["1"][0] = true
	if (body.name == "missing wall"):
		tasks.task_completion["4"][0] = true

func _on_body_exited(body: Node2D) -> void:
	if (tasks.get_spec_mission_complete(1) && tasks.get_mission_spec_dialogue_complete(1) && body.name == "lamp"):
		tasks.root.get_node("Main/Player/Camera2D/Control/txt").visible = true
		await tasks.root.get_node("Main/Player/Camera2D/Control/txt").write_text_param(["Why am I taking away their light? I am truly cruel"])
		tasks.root.get_node("Main/Player/Camera2D/Control/txt").visible = false
