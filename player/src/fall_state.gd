extends State

@export var idle_state: State
@export var run_state: State
@export var hurt_state: State


func process_physics(delta: float) -> State:
	player_parent.velocity.y += player_parent.gravity * delta

	var movement = Input.get_axis('move_left', 'move_right') * player_parent.move_speed
	
	if movement != 0:
		player_parent.animations.flip_h = movement < 0
	player_parent.velocity.x = movement
	player_parent.move_and_slide()
	
	if player_parent.is_on_floor():
		if movement != 0:
			return run_state
		return idle_state
	return null

func process_signal(context, parameters) -> State:
	return hurt_state
