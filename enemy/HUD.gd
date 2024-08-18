extends CanvasLayer

func _ready():
	var camera = get_tree().get_root().get_node($"../Character/Camera2D")
	camera.connect("position_changed", self, "_on_camera_moved")

func _on_camera_moved(new_position):
	position = new_position
