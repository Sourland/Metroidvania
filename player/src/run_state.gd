extends State

@export var fall_state : State
@export var idle_state : State
@export var shoot_state : State
@export var jump_state : State
@export var hurt_state : State

@export var CoyoteTime: float = 0.4 # Seconds allowed to jump after leaving the ground
var coyote_timer: float = 0.0

func enter():
	super()
	coyote_timer = CoyoteTime

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump'):
		if player_parent.is_on_floor() or coyote_timer > 0:
			return jump_state
	if Input.is_action_just_pressed("shoot") and player_parent.is_on_floor():
		return shoot_state
	return null

	
func process_physics(delta: float) -> State:
	player_parent.velocity.y += player_parent.gravity * delta
	coyote_timer -= delta
	var direction = Input.get_axis('move_left', 'move_right')
	
	if direction == 0:
		return idle_state
	
	player_parent.animations.flip_h =direction < 0
	player_parent.velocity.x +=  direction *  player_parent.acceleration * delta
	player_parent.velocity.x = clamp(player_parent.velocity.x, -player_parent.move_speed, player_parent.move_speed)
	player_parent.move_and_slide()
	
	if !player_parent.is_on_floor() and coyote_timer < 0:
		return fall_state
	return null

func process_signal(context, parameters) -> State:
	return hurt_state
