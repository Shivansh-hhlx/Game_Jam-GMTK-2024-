extends Control

var health_image = preload("res://assets/ui/hp bar/health_point.png")
var stam_image = preload("res://assets/ui/stam bar/stamina_point.png")

func _process(delta):
	fill()
	

func fill():
	var num_health = (Global.current_health/Global.max_health) * 15
	var num_stam = (Global.current_stam/Global.max_stam) * 15
	
	
	for child in $MarginContainer/VBoxContainer/TextureRect/MarginContainer/HSplitContainer.get_children():
		child.queue_free()
	
	# create 'health' amount of children
	for i in num_health:
		var text_rect = TextureRect.new()
		text_rect.texture = health_image
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer/VBoxContainer/TextureRect/MarginContainer/HSplitContainer.add_child(text_rect)
	
	
	
	for child in $MarginContainer/VBoxContainer/TextureRect2/MarginContainer/HSplitContainer.get_children():
		child.queue_free()
	
	# create 'health' amount of children
	for i in num_stam:
		var text_rect = TextureRect.new()
		text_rect.texture = stam_image
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer/VBoxContainer/TextureRect2/MarginContainer/HSplitContainer.add_child(text_rect)


func _on_randomizer_notify_scale_change(timeLeft):
	$Label.text = str(timeLeft)
