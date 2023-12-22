extends CharacterBody2D

var move_command = MovementControl.get_move_command(0)
var jump_command = MovementControl.get_jump_command()

@export var starting_position = Vector2.ZERO
@export var speed = 1200
@export var jump_speed = -1800
@export var gravity = 4000
@export_range(0.0, 100.0) var friction = 10.0
@export_range(0.0 , 100.0) var acceleration = 25.0
@export var buffer_time = 0.5
@export var coyote_time = 0.1 # Time in seconds for the coyote time


var jump_buffer_timer = 0
var coyote_timer = 0 # Timer to track coyote time

func move(direction: float, delta: float) -> void:
	velocity.x = lerp(velocity.x, direction * speed, acceleration * delta)
	
func jump(delta: float) -> void:
	# Update coyote and jump buffer timers
	update_jump_timers(delta)

	# Apply gravity
	velocity.y += gravity * delta

	# Perform jump if conditions are met
	if can_jump():
		perform_jump()

func update_jump_timers(delta: float) -> void:
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	if is_on_floor():
		coyote_timer = coyote_time
	elif coyote_timer > 0:
		coyote_timer -= delta

func can_jump() -> bool:
	return (jump_buffer_timer > 0 or Input.is_action_just_pressed("jump")) and (is_on_floor() or coyote_timer > 0)

func perform_jump() -> void:
	velocity.y = jump_speed
	jump_buffer_timer = 0  # Reset jump buffer timer
	coyote_timer = 0      # Reset coyote timer


func _input(event):
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = buffer_time
		

func _physics_process(delta):
	var dir = Input.get_axis("walk_left", "walk_right")
	
	move_command.set_direction(dir)
	move_command.execute(self, delta)
	jump_command.execute(self, delta)
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		velocity = Vector2.ZERO
		position =  starting_position # Replace with function body.
		jump_buffer_timer = 0
		coyote_timer = 0
		