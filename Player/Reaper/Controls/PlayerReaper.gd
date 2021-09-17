extends KinematicBody2D

const UP = Vector2(0, -1)
const SLOPE_STOP = 64
var move 
var velocity = Vector2()
var move_speed = 5 * 40
var gravity = 1200
var jump_velocity = -500
var is_grounded 
var is_dead = false
var isAttacking = false

onready var animator = $Body/AnimationTree.get("parameters/playback")
onready var raycasts = $Raycasts
func attack():
	animator.travel("attack");
	
	isAttacking = true
	
func end_attack():
	isAttacking = false
	
		
func _physics_process(delta):

	if is_dead == false:
		
	
		is_grounded = _check_is_grounded()
		if not isAttacking:
			move = _get_input()
			
			if Input.is_action_pressed("jump") && is_grounded:
				velocity.y = jump_velocity
				animator.travel("jump")
			elif not is_grounded:
				if velocity.y > 0:
					animator.travel("fall")
				elif velocity.y < 0:
					animator.travel("jump")
			elif move != 0:
				$Body.scale.x = move
				animator.travel("running")
			elif move == 0:
				animator.travel("idle")
			
			if Input.is_action_just_pressed("attack"):
				attack()
		if isAttacking:
			if velocity.y != 0:
				velocity.x = move_toward(velocity.x,0, 3)
			else:
				velocity.x = move_toward(velocity.x,0, 10)
		velocity.y += gravity * delta 
		velocity = move_and_slide(velocity, Vector2.UP, true)	
#		if Input.is_action_pressed("jump") && is_grounded: 
#			velocity.y = jump_velocity 
#			animator.travel("jump") 
#		if not is_grounded:
#			animator.travel("jump") 
#		elif move != 0:
#			$Body.scale.x = move
#			animator.travel("running")
#		if Input.is_action_just_pressed("attack"):
#			animator.travel("attack");
#		elif move == 0:
#			animator.travel("idle")




func dead():
	is_dead = true
	velocity = Vector2(0,0)
	#animator.play("Dead")
	$ReaperCollision.disabled = true
	$Timer.start()

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



func _on_Timer_timeout():
	pass # Replace with function body.
