extends State

@export var attack_state : State
@export var idle_state : State


func enter():
	enemy_parent.patrol_timer.start()
	super()

func process_physics(delta: float) -> State:
	enemy_parent.velocity.y += enemy_parent.gravity * delta
	enemy_parent.time_pass_from_attack += delta
	
	if enemy_parent.time_pass_from_attack > enemy_parent.idle_time:
		enemy_parent.can_attack = true
	
	if !enemy_parent.can_walk:
		enemy_parent.move_and_slide()
		return idle_state
	
	enemy_parent.velocity.x += enemy_parent.direction.x * enemy_parent.acceleration * delta
	enemy_parent.velocity.x = clamp(enemy_parent.velocity.x, -enemy_parent.move_speed, enemy_parent.move_speed)
	
	enemy_parent.move_and_slide()
	return null

func process_signal(context, parameters) -> State:
	if parameters == "player_enter":
		if enemy_parent.can_attack:
			return attack_state
	elif parameters == "patrol_timeout":
		enemy_parent.direction *= -1;
		enemy_parent.can_walk = false
		return idle_state
	return null
