extends CharacterBody2D

var speed = 50
var player = false
var pbody
var falling = 1
var fallen = -1

func _ready():
	$AnimatedSprite2D.global_position.y += 40

func _process(delta):
	if $RayCast2D.is_colliding():
		# Stop movement and play attack animation if RayCast2D is colliding
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("attack")
	elif $RayCast2D2.is_colliding():
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("attack")
	else:
		if is_on_floor():
			if fallen == 0:
				$AnimatedSprite2D.play("fallen")
			velocity.y = 0
		else:
			fallen = 0
			$AnimatedSprite2D.play("falling")
			if falling == 1:
				falling = 0
				$AnimatedSprite2D.flip_h = true
			else:
				falling = 1
				$AnimatedSprite2D.flip_h = false
			velocity.y += 1000 * delta

		if fallen == 1:
			$AnimatedSprite2D.play("default")

		if player:
			if pbody.global_position.x > global_position.x:
				$AnimatedSprite2D.flip_h = true
				velocity.x = speed
			else:
				$AnimatedSprite2D.flip_h = false
				velocity.x = -speed
		else:
			$AnimatedSprite2D.stop()
			velocity.x = 0

	move_and_slide()
	
func _on_area_2d_body_entered(body):
	player = true
	pbody = body
	
func _on_area_2d_body_exited(body):
	player = false

func _on_animated_sprite_2d_animation_finished():
	fallen += 1
	$AnimatedSprite2D.global_position.y -= 40
