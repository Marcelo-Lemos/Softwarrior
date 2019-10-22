extends "res://Nodes/Characters/StateMachine.gd"

func _ready():
	states_map = {
		"move": $Move,
		"jump": $Jump,
		"dash": $Dash,
		"mid_air": $MidAir,
		"on_wall": $OnWall,
		"second_jump": $SecondJump
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["jump", "dash"]:
		states_stack.push_front(states_map[state_name])
	
	._change_state(state_name)

func _input(event):
	pass
