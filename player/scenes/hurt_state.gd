extends State

@export var fall_state : State

func enter() -> void:
	super()
	player_parent.velocity.y = -player_parent.jump
	player_parent.velocity.x = player_parent.move_speed * player_parent.collision_direction * 0.75


func process_physics(delta: float) -> State:
	player_parent.velocity.y += player_parent.gravity * delta
	player_parent.move_and_slide()
	
	if player_parent.velocity.y > 0:
		return fall_state
		
	return null

