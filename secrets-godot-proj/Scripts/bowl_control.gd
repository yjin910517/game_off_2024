extends Control


signal food_bowl_clicked()

var has_fed = false

func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("food_bowl_clicked")
		print("clicked food bowl")
