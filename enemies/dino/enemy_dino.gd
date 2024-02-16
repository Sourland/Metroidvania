class_name EnemyDino
extends CharacterBody2D

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var player = $"../Player"
@onready var scan_area = $ScanArea
@onready var idle_timer = $IdleTimer
@onready var patrol_timer = $PatrolTimer
@onready var patrol_points = $PatrolPoints

@export var idle_time : float = 2
@export var patrol_time : float = 5

@export var move_speed: float = 115
@export var attack_speed: float = 230
@export var acceleration : int = 2000
@export var friction: int = 3000
@export var direction : Vector2 = Vector2.LEFT
@export var gravity: int = 3000

var can_attack : bool = true
var can_walk : bool = true
var time_pass_from_attack : float = 0

var starting_position : Vector2

func _ready():
	idle_timer.wait_time = idle_time
	patrol_timer.wait_time = patrol_time
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

func _on_patrol_timer_timeout():
	state_machine.process_signal(null, "patrol_timeout")
