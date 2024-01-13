class_name EnemyDino
extends CharacterBody2D

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var player = $"../Player"
@onready var scan_area = $ScanArea
@onready var timer = $Timer

@export var idle_time : float = 2

@export var move_speed: float = 230
@export var acceleration : int = 2000
@export var friction: int = 3000
@export var gravity: int = 3000

@export var patrol_points : Node

var can_attack : bool = true
var can_walk : bool
var time_pass_from_attack : float = 0
# Holds the global positions of all patrol points.
var patrol_point_positions : Array[Vector2]

# The global position of the current patrol point.
var current_patrol_point_position : Vector2

# Index to track the current patrol point in the array.
var patrol_point_index : int

func _ready():
	timer.wait_time = idle_time
	if patrol_points != null:
		for point in patrol_points.get_children():
			patrol_point_positions.append(point.global_position)
		current_patrol_point_position = patrol_point_positions[patrol_point_index]
	else:
		print("No patrol points detected.")
	state_machine.init_enemy(self)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_body_entered():
	state_machine.process_signal()

func _on_scan_area_body_entered(body):
	state_machine.process_signal(body, "player_enter") # Replace with function body.

func _on_scan_area_body_exited(body):
	state_machine.process_signal(body, "player_exit") # Replace with function body.

func _on_hurt_box_area_entered(area):
	state_machine.process_signal(area, "player_touch")

func _on_timer_timeout():
	state_machine.process_signal(null, "timeout")
