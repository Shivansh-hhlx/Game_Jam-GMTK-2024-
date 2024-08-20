extends CharacterBody2D

signal notifyScaleChange


var kill := preload("res://zones/enemy_kill_zone.tscn")

#var canScale: bool = true
var currentScale: bool = false; # true for big, false for small

var notifyScaleTime: int = 0

var scaleFactor = 1;
var scaleCount: int = 0;

const RUNNING_SPEED = 400
const WALKING_SPEED = 150
const SMALL_RUNNING_SPEED = 500
const SMALL_WALKING_SPEED = 200
const GRAVITY = 1000
const BIG_JUMP_SPEED = 510
const SMALL_JUMP_SPEED = 620
const AIR_DASH = 900
var speed = WALKING_SPEED
var gravity = GRAVITY
var is_dashing = 0
var is_stomping = 0
var jump = BIG_JUMP_SPEED
var is_attacking = 0

var health = 100
var strength = 10
var stamina = 50
var poise = 10
var scaled_down = false
var time_count = 0

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
	
	if !is_on_floor() and Input.is_action_just_pressed("dash") and is_dashing == 0 and scaled_down:
		speed = AIR_DASH
		is_dashing = 1
		gravity = 0
		jump = 0
		add_child(killzone)
		$dashEnd.start()
		$killzoneEnd.start()
		$dashGoing.start()
	elif Input.is_action_pressed("dash") and is_on_floor():
		if scaled_down:
			speed = SMALL_RUNNING_SPEED
		else:
			speed = RUNNING_SPEED
	elif is_on_floor():
		if scaled_down:
			speed = SMALL_WALKING_SPEED
		else:
			speed = WALKING_SPEED
	elif is_dashing == 0:
		if scaled_down:
			speed = SMALL_WALKING_SPEED
		else:
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
		$dashEnd.start()
		$killzoneEnd.start()
		
	if Global.canScale:
		Global.canScale = false
		if currentScale:
			currentScale = false;
			scaleFactor = 1;
			scaled_down = false
			$scalingUp.start()
		else:
			scaled_down = true
			currentScale = true;
			scaleFactor = -1;
		
			$scalingUp.start()
	
	if scaled_down:
		jump = SMALL_JUMP_SPEED
	else:
		jump = BIG_JUMP_SPEED
	move_and_slide()
	
	if($randomScale.time_left == 2):
		notifyScaleChange.emit()

func _on_timer_timeout():
	gravity = GRAVITY
	
	if scaled_down:
		speed = SMALL_WALKING_SPEED
		jump = SMALL_JUMP_SPEED
	else:
		speed = WALKING_SPEED
		jump = BIG_JUMP_SPEED

func _on_timer_2_timeout():
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
	
	if time_count < 1:
		$scalingUp.start()
	else:
		time_count = 0
	
	

func _on_dash_going_timeout():
	is_dashing = 0



#func _on_random_scale_timeout():
	#canScale = true
	#
	#var scaleTime: int = randi_range(10, 20)
	#$randomScale.wait_time = scaleTime
	#$randomScale.start()
	#
	#notifyScaleTime = scaleTime - 2
	
