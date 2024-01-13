extends AnimatedSprite2D

var bullet_impact_effect = preload("res://player/scenes/bullet_impact.tscn")

@onready var timer = $Timer

var speed : int = 600
var wait_time : float = 1
var direction : int
var damage_points : int = 1

func get_damage_points() -> int:
	return damage_points


func _ready():
	timer.wait_time = wait_time
	

func _physics_process(delta):
	play("fired")
	move_local_x(direction * speed * delta)


func _on_timer_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	bullet_impact() # Replace with function body.

func _on_hitbox_body_entered(body):
	bullet_impact() # Replace with function body.

func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
