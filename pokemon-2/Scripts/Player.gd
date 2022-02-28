extends KinematicBody2D

export var walk_speed = 4.0
const tile_size = 16

var inital_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0.0


func _ready():
	 inital_position = position
	
func _physics_process(delta):
	if !is_moving:
		player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false
		
func player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		
	if input_direction != Vector2.ZERO:
		inital_position = position
		is_moving = true
		
func move(delta):
	percent_moved_to_next_tile += walk_speed * delta
	if percent_moved_to_next_tile >= 1.0:
		position = inital_position + (tile_size * input_direction)
		percent_moved_to_next_tile = 0.0
		is_moving = false
	else:
		position = inital_position + (tile_size * input_direction * percent_moved_to_next_tile) 
