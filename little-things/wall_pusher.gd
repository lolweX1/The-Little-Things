extends CharacterBody2D


const SPEED = 100.0

@onready var disable := true

var highlight = false

func _physics_process(delta: float) -> void:
	if (!disable):
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if (disable):
		if (highlight):
			$Sprite2D.material.set_shader_parameter("outline_enabled", true) # this is in the sprite2D shader script, variable called outline_enabled
		else:
			$Sprite2D.material.set_shader_parameter("outline_enabled", false)
		
		highlight = false
	
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_force(col.get_normal() * -300)

	move_and_slide()

func setHighlight():
	highlight = true
