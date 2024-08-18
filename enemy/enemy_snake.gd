extends CharacterBody2D

var speed = 50
var player = false
var pbody


func _process(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += 1000 * delta
		
	move_and_slide()
	
	if player:
		if pbody.global_position.x > global_position.x:
			$AnimatedSprite2D.flip_h = !false
			velocity.x = 50
			$AnimatedSprite2D.play("default")
		else:
			$AnimatedSprite2D.flip_h = !true
			velocity.x = -50
			$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.stop()
		velocity.x = 0
	
	


func _on_area_2d_body_entered(body):
	player = true
	pbody = body
	


func _on_area_2d_body_exited(body):
	player = false
