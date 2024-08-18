extends CharacterBody2D


const GRAVITY = 1000
var gravity = GRAVITY

func _process(delta):
	
	if is_on_floor():
		velocity.y = 0
	if !is_on_floor():
		velocity.y += gravity * delta

	
	move_and_slide()	
