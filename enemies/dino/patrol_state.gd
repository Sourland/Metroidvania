extends State

@export var attack_state : State
@export var idle_state : State

func enter():
	super()

func process_physics(delta: float) -> State:
	return null

func process_signal(context, parameters) -> State:
	if parameters == "player_enter":
		if enemy_parent.can_attack:
			return attack_state
	return null
