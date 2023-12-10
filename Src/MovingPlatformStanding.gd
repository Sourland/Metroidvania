extends CharacterBody2D  # Replace with KinematicBody2D or RigidBody2D if needed

# Movement parameters
var amplitude = 900  # Maximum movement distance from the starting position
var period = 5  # Period of the movement in seconds
@export var direction = 1


var starting_position: Vector2
var elapsed_time = 0.0

func _ready():
	starting_position = global_position

func _process(delta):
	elapsed_time += delta
	var sine_wave = direction * sin(elapsed_time * 2 * PI / period)
	global_position.x = starting_position.x + sine_wave * amplitude