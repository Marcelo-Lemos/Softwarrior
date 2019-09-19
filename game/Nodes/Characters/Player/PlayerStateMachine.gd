extends "res://Nodes/Characters/StateMachine.gd"

func _ready():
	states_map = {
		"move": $Move,
		"jump": $Jump
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["jump"]:
		states_stack.push_front(states_map[state_name])
	if state_name == "jump" and current_state == $Move:
		$Jump.initialize()
	
	._change_state(state_name)

func _input(event):
	pass
