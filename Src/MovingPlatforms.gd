extends CharacterBody2D

@export var starting_position : Vector2


func _ready():
	position = starting_position

func _physics_process(delta):
	if abs(position.y) >  abs(get_parent().reset_trigger_y):
		position = get_parent().reset_position
	velocity = Vector2(0, get_parent().direction * get_parent().speed)  # Velocity for downward movement
	move_and_collide(velocity * delta)


