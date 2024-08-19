extends Node2D

func _ready():
	$CollisionShape2D.one_way_collision = true

func _process(delta):
	if Input.is_action_just_pressed("down"):
		$CollisionShape2D.disabled = true
		$Timer.start()


func _on_timer_timeout():
	$CollisionShape2D.disabled = false
