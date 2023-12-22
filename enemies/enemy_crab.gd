extends CharacterBody2D

@export var gravity : int = -650

func _ready():
	pass
	
func _physics_process(delta : float):
	pass
	
func enemy_gravity(delta : float):
	velocity.y += gravity * delta
