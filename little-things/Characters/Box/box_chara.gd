extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var disable := true

var highlight = false

func _physics_process(delta: float) -> void:
	if (!disable):
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

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

	move_and_slide()

func setHighlight():
	highlight = true
	
