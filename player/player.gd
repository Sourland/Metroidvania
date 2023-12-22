extends CharacterBody2D
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D

@export var gravity : int = 4000
@export var speed : int = 300
@export var jump : int = -650
@export var jump_horizontal : int = 300

enum State {Idle, Run, Jump}

var current_state : State

func _ready():
	current_state = State.Idle


func _physics_process(delta : float):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	move_and_slide()
	
	player_animation()
	
	print("State: ", str(State.keys()[current_state]))

func player_falling(delta : float):
	if !is_on_floor():
		velocity.y += gravity * delta
		return true


func player_idle(delta : float):
	if is_on_floor():
		current_state = State.Idle
		

func player_run(delta : float):
	if !is_on_floor():
		return
		
	var direction : int = import_movement()
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0 , speed)
		
	if direction != 0:
		current_state = State.Run
		
		animated_sprite_2d.flip_h = false if direction > 0 else true
		

func player_jump(delta : float):
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump
		current_state = State.Jump
	
	if !is_on_floor() and current_state == State.Jump:
		var direction = import_movement()
		velocity.x += direction * delta * jump_horizontal

func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
		

func import_movement():
	var direction : int = Input.get_axis("move_left", "move_right")
	return direction
