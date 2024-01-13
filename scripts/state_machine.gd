extends Node

@export var starting_state : State

@export var current_state : State

@export var controller : CharacterBody2D

func init_player(parent: Player) -> void:
	for child in get_children():
		if child is State:
			child.player_parent = parent
	controller = parent
	change_state(starting_state)

	
func init_enemy(parent: EnemyDino) -> void:
	for child in get_children():
		if child is State:
			child.enemy_parent = parent
	controller = parent
	change_state(starting_state)
	
func change_state(new_state : State) -> void:
	if current_state:
		current_state.exit()
		
	current_state = new_state
	print("State of ,", controller, "is : ", current_state.name)
	current_state.enter()
	
func process_physics(delta : float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
	
	
func process_input(event : InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
	
	
func process_frame(delta : float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
	
func process_signal(context, parameters)-> void:
	var new_state = current_state.process_signal(context, parameters)
	if new_state:
		change_state(new_state)
