extends CharacterBody2D


func _ready():
	$AnimatedSprite2D.play("default")

func _process(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += 1000 * delta
		
	move_and_slide()
	

