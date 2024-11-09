extends Control


signal projector_clicked()

var has_disk = false
var played = false

func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("projector_clicked")
		print("clicked projector")
