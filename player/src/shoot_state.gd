extends State

@export var fall_state : State
@export var idle_state : State
@export var run_state : State
@export var jump_state : State
@export var hurt_state : State

@onready var muzzle : Marker2D = $"../../Muzzle"
var muzzle_position
var bullet = preload("res://player/scenes/bullet.tscn")

func enter():
	super()
	muzzle_position = muzzle.position

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and player_parent.is_on_floor():
		return jump_state
	return null

	
func process_physics(delta: float) -> State:
	player_parent.velocity.y += player_parent.gravity * delta
	
	var direction = Input.get_axis('move_left', 'move_right')
	
	if direction == 0:
		return idle_state
	
	if direction > 0:
		muzzle.position.x = muzzle_position.x
	else:
		muzzle.position.x = -muzzle_position.x
	
	var bullet_instance = bullet.instantiate() as Node2D
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.direction = direction
	get_parent().add_child(bullet_instance)
	
	if !player_parent.is_on_floor():
		return fall_state
		
	return run_state

func process_signal(context, parameters) -> State:
	return hurt_state
