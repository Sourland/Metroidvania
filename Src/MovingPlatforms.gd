extends CharacterBody2D

@export var starting_position : Vector2


func _ready():
	position = starting_position

func _physics_process(delta):
	velocity = Vector2(0, get_parent().direction * get_parent().speed)  # Velocity for downward movement
	move_and_collide(velocity * delta)

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D: 
		body.position = get_parent().reset_position
