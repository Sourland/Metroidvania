extends State

@export var idle_state : State

func enter() -> void:
	super()
	if enemy_parent.patrol_points:
		enemy_parent.patrol_points.queue_free()
	enemy_parent.time_pass_from_attack = 0
	enemy_parent.can_attack = false;
	
# TODO: Make stuff to exit the attack state
# TODO: Make patrol points to stop the dino from attacking
func process_physics(delta: float) -> State:
	enemy_parent.velocity.y += enemy_parent.gravity * delta

	var direction = 1 if enemy_parent.player.position.x > enemy_parent.position.x else -1
	enemy_parent.scan_area.position.x = abs(enemy_parent.scan_area.position.x) if enemy_parent.player.position.x > enemy_parent.position.x else -abs(enemy_parent.scan_area.position.x)
	enemy_parent.animations.flip_h = direction > 0
	enemy_parent.velocity.x += direction * enemy_parent.acceleration * delta
	enemy_parent.velocity.x = clamp(enemy_parent.velocity.x, -enemy_parent.attack_speed, enemy_parent.attack_speed)
	enemy_parent.move_and_slide()

	return null
	
func process_signal(context, parameters) -> State:
	if parameters == "player_exit":
		return idle_state
	if parameters == "player_touch":
		return idle_state
	return null
