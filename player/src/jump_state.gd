extends State

@export var fall_state: State
@export var idle_state: State
@export var run_state: State
@export var hurt_state: State

@export var JumpBufferTime: float = 0.5 # Seconds to buffer a jump before hitting the ground
var jump_buffer_timer: float = 0.0

func enter() -> void:
	super()
	player_parent.velocity.y = -player_parent.jump
	jump_buffer_timer = 0.0


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JumpBufferTime
		
	return null


func process_physics(delta: float) -> State:
	player_parent.velocity.y += player_parent.gravity * delta
	jump_buffer_timer -= delta
	
	if player_parent.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis('move_left', 'move_right') * player_parent.move_speed
	
	if movement != 0:
		player_parent.animations.flip_h = movement < 0
	player_parent.velocity.x = movement
	player_parent.move_and_slide()

	if player_parent.is_on_floor():
		if jump_buffer_timer > 0:
			return self
		if movement != 0:
			return run_state
		else:
			return idle_state
	return null

func process_signal(context, parameters) -> State:
	return hurt_state
