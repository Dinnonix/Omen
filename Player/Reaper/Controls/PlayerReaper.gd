extends KinematicBody2D

const UP = Vector2(0, -1)
const SLOPE_STOP = 64

var velocity = Vector2()
var move_speed = 5 * 40
var gravity = 1200
var jump_velocity = -500
var is_grounded 

onready var animator = $Body/AnimatedReaper
onready var raycasts = $Raycasts

func _physics_process(delta):
	var move = _get_input()
	velocity.y += gravity * delta 
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	is_grounded = _check_is_grounded()
	if not is_grounded:
		animator.play("Jump")
	elif move != 0:
		$Body.scale.x = move
		animator.play("Run")
	elif move == 0:
		animator.play("Idle")

func _input(event):
	if event.is_action_pressed("jump") && is_grounded: 
		velocity.y = jump_velocity 
		animator.play("Jump")

func _get_input():
	var move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, _get_h_weight())
	return move_direction

func _get_h_weight():
	return 0.2 if is_grounded else 0.1

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true

