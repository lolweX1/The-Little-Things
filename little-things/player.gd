extends CharacterBody2D


const MAX_VELOCITY = 500
const ACCEL = 50

var force = 100

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	move_and_slide()
	
func obj_collision() -> void:
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_force(col.get_normal() * -force)
