extends CharacterBody2D

var speed = 50
var player = false
var pbody

func _process(delta):
	# Check for collisions with both RayCast2D nodes
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		if $AnimatedSprite2D.animation != "attack":
			$AnimatedSprite2D.play("attack")
			$Timer.start()  # Start the timer when the attack animation starts
	else:
		# Stop the timer if the attack animation stops
		if $AnimatedSprite2D.animation == "attack":
			$Timer.stop()
		
		# Handle vertical movement
		if is_on_floor():
			velocity.y = 0
		else:
			velocity.y += 1000 * delta

		# Handle horizontal movement
		if player:
			if pbody.global_position.x > global_position.x:
				$AnimatedSprite2D.flip_h = false
				velocity.x = speed
				$AnimatedSprite2D.play("default")
			else:
				$AnimatedSprite2D.flip_h = true
				velocity.x = -speed
				$AnimatedSprite2D.play("default")
		else:
			$AnimatedSprite2D.stop()
			velocity.x = 0
		
	# Apply movement
	move_and_slide()

func _on_area_2d_body_entered(body):
	player = true
	pbody = body

func _on_area_2d_body_exited(body):
	player = false

func _on_timer_timeout() -> void:
	if $AnimatedSprite2D.animation == "attack":
		Global.current_health -= 10
