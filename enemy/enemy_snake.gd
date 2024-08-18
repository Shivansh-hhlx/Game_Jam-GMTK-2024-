extends CharacterBody2D

var speed = 50
var player = false
var pbody
var falling = 1
var fallen = -1

func _ready():
	$AnimatedSprite2D.global_position.y += 40

func _process(delta):
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
		
	
	
	move_and_slide()
	
	if fallen == 1:
		$AnimatedSprite2D.play("default")
	
	if player:
		if pbody.global_position.x > global_position.x:
			$AnimatedSprite2D.flip_h = !false
			velocity.x = 50
		else:
			$AnimatedSprite2D.flip_h = !true
			velocity.x = -50
	else:
		$AnimatedSprite2D.stop()
		velocity.x = 0
	
	
	
	


func _on_area_2d_body_entered(body):
	player = true
	pbody = body
	


func _on_area_2d_body_exited(body):
	player = false


func _on_animated_sprite_2d_animation_finished():
	fallen += 1
	$AnimatedSprite2D.global_position.y -= 40
