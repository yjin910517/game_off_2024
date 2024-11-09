extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	# For hovering action
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	# Set to transparent when not hovered
	color = Color("#00000000")
	
	# Pass click signals to mother node to handle
	mouse_filter = MOUSE_FILTER_PASS


func _on_mouse_entered():
	color = Color("#F5FF9F70")
	

func _on_mouse_exited():
	color = Color("#00000000")
