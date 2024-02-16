extends State

@export var attack_state : State
@export var patrol_state : State

func enter():
	super()

func process_frame(delta : float) -> State:
	if enemy_parent.scan_area.has_overlapping_areas() and enemy_parent.can_attack:
		return attack_state
	return null

func process_physics(delta: float) -> State:
	enemy_parent.time_pass_from_attack += delta
	enemy_parent.velocity.y += enemy_parent.gravity * delta
	enemy_parent.velocity.x = move_toward(enemy_parent.velocity.x, 0 , enemy_parent.friction * delta)
	enemy_parent.move_and_slide()
	if enemy_parent.time_pass_from_attack > enemy_parent.idle_time:
		enemy_parent.can_attack = true
	return null

func process_signal(context, parameters) -> State:
	if parameters == "player_enter":
		if enemy_parent.can_attack:
			return attack_state
	if parameters == "timeout":
		enemy_parent.can_walk = true
		enemy_parent.animations.flip_h = enemy_parent.direction.x > 0
		enemy_parent.scan_area.position.x = abs(enemy_parent.scan_area.position.x) if enemy_parent.animations.flip_h else -abs(enemy_parent.scan_area.position.x)
		return patrol_state
	return null
