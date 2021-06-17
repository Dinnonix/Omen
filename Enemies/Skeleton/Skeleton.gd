extends KinematicBody2D

var gravity = 1200
var velocity = Vector2(0,0)
var speed = 32
var is_grounded 
onready var animator = $Body/AnimatedSkeleton

func _process(_delta):
	_move_character()
	detect_turn_around()
	velocity = move_and_slide(velocity, Vector2.UP)
	animator.play("Walk")

func _move_character():
	velocity.x = -speed
	velocity.y += gravity

func detect_turn_around():
	if not $Raycasts/RayCast2D.is_colliding() and is_on_floor():
		pass
