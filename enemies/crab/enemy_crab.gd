extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

var enemy_death_effect = preload("res://enemies/enemy_death_effect.tscn")

@export var gravity : int = 1000
@export var speed : int = 1500
@export var direction : Vector2 = Vector2.LEFT
@export var patrol_points : Node
@export var wait_time : int
@export var health_points: int = 5

enum States {Idle, Walk}

var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int

var current_state : States
var can_walk : int

func _ready():
	if patrol_points != null:
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")
	current_state = States.Idle
	timer.wait_time = wait_time
	
func _physics_process(delta : float):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	
	move_and_slide()
	
	enemy_animation()
	
func enemy_gravity(delta : float):
	velocity.y += gravity * delta

func enemy_idle(delta : float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = States.Idle
	
func enemy_walk(delta : float):
	if !can_walk:
		return
	if abs(position.x - current_point.x) > 0.5 :
		velocity.x = direction.x * speed * delta
		current_state = States.Walk
	else:
		current_point_position = !current_point_position
		
		current_point = point_positions[current_point_position]
	
		if current_point.x > position.x: 
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
			
		can_walk = false
		timer.start()
	

func enemy_animation():
	if current_state == States.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == States.Walk:
		animated_sprite_2d.play("walk")


func _on_timer_timeout():
	can_walk = true
	animated_sprite_2d.flip_h = direction.x > 0


func _on_hurtbox_area_entered(area):
	 # Replace with function body.
	if area.get_parent().has_method("get_damage_points"):
		var node = area.get_parent() as Node
		health_points -= node.damage_points
		print("Health Points: ", health_points)
		kill_entity()
	
	
func kill_entity():
	if health_points == 0:
		var enemy_death_effect_instance =  enemy_death_effect.instantiate() as Node2D
		enemy_death_effect_instance.global_position = global_position
		get_parent().add_child(enemy_death_effect_instance)
		queue_free()
