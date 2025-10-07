extends CharacterBody2D


const MAX_VELOCITY = 500
const ACCEL = 50

var force = 100

var controllable_characters = {
}

var disable = false

var control_chara

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if (!disable): 
		var direction_x := Input.get_axis("move_left", "move_right")
		if direction_x:
			velocity.x += direction_x * ACCEL 
			velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCEL)
			
		var direction_y := Input.get_axis("move_up", "move_down")
		if direction_y:
			velocity.y += direction_y * ACCEL
			velocity.y = clamp(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
		else:
			velocity.y = move_toward(velocity.y, 0, ACCEL)

	var degree = atan2(velocity.y, velocity.x)
	$tail_container.rotation = degree
	var max_scale = sqrt(2 * pow(MAX_VELOCITY, 2))
	var scale = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
	$tail_container.scale.x = scale/max_scale
	# $tail_container.scale.y = scale/max_scale
	obj_collision()
	
	if (Input.is_action_just_pressed("begin_dialogue")):
		if (tasks.over_text && !$Camera2D/Control/txt.visible):
			$Camera2D/Control/txt.visible = true
			await $Camera2D/Control/txt.write_text()
			if (tasks.get_mission_complete()):
				tasks.set_dialogue_mission_complete()
			$Camera2D/Control/txt.visible = false
	
	if (player_stats.level) >= 0: # change to 1
		var charaBody = get_closest_to_player()
		if (charaBody):
			charaBody.setHighlight()
		if (Input.is_action_just_pressed("control") && !disable && charaBody):
			charaBody.disable = false
			control_chara = charaBody
			disable = true
			velocity = Vector2(0, 0)
		elif (Input.is_action_just_pressed("release") && disable):
			disable = false
			if (control_chara):
				control_chara.disable = true
			$Camera2D.position = Vector2(0, 0)
	if (disable): 
		$Camera2D.global_position = control_chara.global_position
	
	move_and_slide()
	
func obj_collision() -> void:
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_force(col.get_normal() * -force)

func get_closest_to_player() -> CharacterBody2D:
	if (controllable_characters.is_empty()):
		return null
	var closest := ""
	var closest_len := INF
	for i in controllable_characters.keys():
		var len = position.distance_to(controllable_characters[i].position)
		if (len < closest_len):
			closest = i
			closest_len =  len
	return controllable_characters[closest]

func _on_control_zone_body_entered(body: Node2D) -> void:
	if body.name != "Player" && body is CharacterBody2D:
		controllable_characters[body.name] = body
	print(controllable_characters)

func _on_control_zone_body_exited(body: Node2D) -> void:
	if body.name != "Player" && body is CharacterBody2D:
		controllable_characters.erase(body.name)
