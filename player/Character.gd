extends CharacterBody2D

var kill := preload("res://zones/enemy_kill_zone.tscn")

var canScale: bool = true
var currentScale: bool = false; # true for big, false for small
var scaleFactor = 1;
var scaleCount: int = 0;

const RUNNING_SPEED = 400
const WALKING_SPEED = 150
const GRAVITY = 1000
const JUMP_SPEED = 400
const AIR_DASH = 800
var speed = WALKING_SPEED
var gravity = GRAVITY
var is_dashing = 0
var is_stomping = 0
var jump = JUMP_SPEED
var is_attacking = 0

var health = 100
var strength = 10
var stamina = 50
var poise = 10

var time_count = -1

var killzone

func _ready():
	killzone = kill.instantiate()

func _process(delta):
	
	
	var direction = Input.get_axis("left", "right")
	
	if is_on_floor():
		velocity.y = 0
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump
	if !is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = direction * speed
	
	if !is_on_floor() and Input.is_action_just_pressed("dash") and is_dashing == 0:
		speed = AIR_DASH
		is_dashing = 1
		gravity = 0
		jump = 0
		add_child(killzone)
		$Timer.start()
		$Timer2.start()
	elif Input.is_action_pressed("dash") and is_on_floor():
		speed = RUNNING_SPEED
	elif is_on_floor():
		speed = WALKING_SPEED
	elif is_dashing == 0:
		speed = WALKING_SPEED
	
	
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
		var tween = create_tween()
		tween.tween_property($Camera2D, "global_position", $Markers/Marker2D2.global_position, 2.25)
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
		var tween = create_tween()
		tween.tween_property($Camera2D, "global_position", $Markers/Marker2D.global_position, 2.25)
	if direction == 0:
		var tween = create_tween()
		tween.tween_property($Camera2D, "global_position", $Markers/Marker2D4.global_position, 2.25)
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

	if !is_on_floor() and Input.is_action_just_pressed("attack"):
		add_child(killzone)
		gravity = GRAVITY * 10
		is_stomping = 1
		$Timer.start()
		$Timer2.start()
		
	if Input.is_action_just_pressed("scale") and canScale:
		print("boy")
		if currentScale:
			print("scaling down");
			currentScale = false;
			scaleFactor = -1;
			
			$Timer3.start()
		else:
			print("scaling up");
			currentScale = true;
			scaleFactor = 1;
		
			$Timer3.start()
		
	move_and_slide()


func _on_timer_timeout():
	gravity = GRAVITY
	speed = WALKING_SPEED
	jump = JUMP_SPEED

func _on_timer_2_timeout():
	is_dashing = 0
	is_stomping = 0
	remove_child(killzone)

func _on_timer_3_timeout():
	
	scale.x += 0.5 * scaleFactor;
	scale.y += 0.5 * scaleFactor;
	if currentScale:
		$Markers/Marker2D4.position.y += 25.0
		$Markers/Marker2D2.position.y += 25.0
		$Markers/Marker2D.position.y +=  25.0
	else:
		$Markers/Marker2D4.position.y -= 25.0
		$Markers/Marker2D2.position.y -= 25.0
		$Markers/Marker2D.position.y -=  25.0
	
	time_count+=1
	
	if time_count < 3:
		$Timer3.start()
	else:
		time_count = -1
	

