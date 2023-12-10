extends CharacterBody2D  # Replace with KinematicBody2D or RigidBody2D if needed

# Movement parameters
@export var amplitude = 100  # Maximum movement distance from the starting position
@export var period = 7.5  # Period of the movement in seconds
@export var direction = 1
@export var is_horizontal = false


var starting_position: Vector2
var elapsed_time = 0.0

func _ready():
	starting_position = global_position

func _process(delta):
	elapsed_time += delta
	var t = fmod(elapsed_time, period) / period  # Normalized time for the period

	if is_horizontal:
		# Linearly interpolate between start and end points
		global_position.x = lerp(starting_position.x, starting_position.x + direction * amplitude, t)
	else:
		# Linearly interpolate between start and end points
		global_position.y = lerp(starting_position.y, starting_position.y + direction * amplitude, t)
	
