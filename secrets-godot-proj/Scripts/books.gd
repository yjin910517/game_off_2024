extends ColorRect


signal book_clicked(book_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	connect("gui_input", Callable(self, "_on_gui_input"))
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	# Set to transparent when not hovered
	color = Color("#00000000")
	
	# Pass click signals to mother node to handle
	mouse_filter = MOUSE_FILTER_PASS


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("book_clicked", name)
		

func _on_mouse_entered():
	color = Color("#F5FF9F70")
	

func _on_mouse_exited():
	color = Color("#00000000")
