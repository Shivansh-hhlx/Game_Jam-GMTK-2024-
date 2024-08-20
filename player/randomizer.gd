extends Node2D

signal notifyScaleChange

func _ready():
	var scaleTime: int = randi_range(10, 20)
	$Timer.wait_time = scaleTime
	$Timer.start()


func _process(delta):
	if($Timer.time_left <= 2):
		notifyScaleChange.emit(int($Timer.time_left))


