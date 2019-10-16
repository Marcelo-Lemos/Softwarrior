extends "Motion.gd"

const MAX_AIR_SPEED = 200
const AIR_ACCELERATION = 20
const AIR_SLOWDOWN = 1

const SECOND_JUMP_HEIGHT = -250

var jump_var_height = 100

func enter():
	pass
	#print("Entered AIR")

func exit():
	#print("Exiting AIR")
	.exit()

func handle_input(event):
	if event.is_action_pressed("jump") and player.has_double_jump:
		player.velocity.y = SECOND_JUMP_HEIGHT
		player.has_double_jump = false
	.handle_input(event)

func update(delta):
	if body.is_on_floor():
		emit_signal("finished", "previous")
	
	if (player.velocity.y < 25 and player.velocity.y > -25) or player.velocity.y > 50:
		if check_wall_left() and get_input_direction()[0] < 0 and player.velocity.x <= 0:
			emit_signal("finished", "on_wall")
		elif check_wall_right() and get_input_direction()[0] > 0 and player.velocity.x >= 0:
			emit_signal("finished", "on_wall")
			
	if player.velocity.y < 0:
		sprite.play("JumpUp")
	else:
		sprite.play("JumpDown")
		
	var input_direction = get_input_direction()
	if input_direction:
		player.velocity.x += input_direction[0] * AIR_ACCELERATION
	elif player.velocity.x != 0:
		apply_air_slowdown()
	player.velocity.x = (cap_velocity(player.velocity.x, MAX_AIR_SPEED))
	if(Input.is_action_just_released("jump")):
		check_jump_cut(jump_var_height)
	
	.update(delta)

func check_jump_cut(jump_height):
	if player.velocity.y < -jump_height:
		player.velocity.y = -jump_height

func apply_air_slowdown():
	if player.velocity.x > 0:
		player.velocity.x -= AIR_SLOWDOWN
	elif player.velocity.x < 0:
		player.velocity.x += AIR_SLOWDOWN