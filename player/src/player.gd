class_name Player
extends CharacterBody2D
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : Node = $StateMachine

@export var move_speed: float = 300
@export var jump : int = 750
@export var jump_horizontal_speed : int = 1000
@export var max_jump_horizontal_speed: int = 300
@export var acceleration : int = 3000
@export var friction: int = 3000
@export var gravity: int = 2000

var collision_direction : int = 0;

func _ready():
	state_machine.init_player(self)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_hurt_box_area_entered(area):
	collision_direction = -1 if area.global_position.x > global_position.x else 1

	state_machine.process_signal(area, null) # Replace with function body.
