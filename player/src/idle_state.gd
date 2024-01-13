extends State

@export var fall_state : State
@export var jump_state : State
@export var run_state : State
@export var hurt_state: State
func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and player_parent.is_on_floor():
		return jump_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return run_state
	return null
		
func process_physics(delta: float) -> State:
	player_parent.velocity.y += player_parent.gravity * delta
	player_parent.velocity.x = move_toward(player_parent.velocity.x, 0 , player_parent.friction * delta)
	player_parent.move_and_slide()
	
	if !player_parent.is_on_floor():
		return fall_state
	return null

func process_signal(context, parameters) -> State:
	return hurt_state


