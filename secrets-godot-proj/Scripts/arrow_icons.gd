extends TextureRect


signal page_turn(arrow_direction)


# left or right, defined by parent node
var arrow_direction 


func _ready() -> void:
	# For hovering action
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("gui_input", Callable(self, "_on_gui_input"))


func set_arrow_direction(direction):
	arrow_direction  = direction


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("page_turn", arrow_direction)
		

func _on_mouse_entered():
	position = position + Vector2(2,2)
	

func _on_mouse_exited():
	position = position - Vector2(2,2)
