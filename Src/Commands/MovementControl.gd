extends Node2D

class MoveCommand extends Command:
	var direction: float
	
	func _init(dir: float):  # Constructor with direction parameter
		direction = dir
	
	func set_direction(new_direction: float) -> void:
		direction = new_direction		
	
	func execute(target: CharacterBody2D, delta: float) -> void:
		target.move(direction, delta)

class JumpCommand extends Command:
	func execute(target: CharacterBody2D, delta: float) -> void:
		target.jump(delta)


# Assuming MoveCommand and JumpCommand are defined within this script or imported
func get_move_command(direction: float) -> Command:
	return MoveCommand.new(direction)

func get_jump_command() -> Command:
	return JumpCommand.new()
