extends CharacterBody2D

@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25
@export var bufferTime = 0.5
@export var coyoteTime = 0.1 # Time in seconds for the coyote time

var jump_buffer_timer = 0
var coyote_timer = 0 # Timer to track coyote time

func _input(event):
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = bufferTime
		

func _physics_process(delta):
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	# Update coyote timer
	if not is_on_floor():
		if coyote_timer > 0:
			coyote_timer -= delta
	else:
		coyote_timer = coyoteTime
	
	velocity.y += gravity * delta
	var dir = Input.get_axis("walk_left", "walk_right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	
	if (jump_buffer_timer > 0 or Input.is_action_just_pressed("jump")) and (is_on_floor() or coyote_timer > 0):
		velocity.y = jump_speed
		jump_buffer_timer = 0 # Reset buffer timer after jumping
		coyote_timer = 0 # Reset coyote timer after jumping

	
	move_and_slide()
