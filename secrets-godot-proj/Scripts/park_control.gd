extends Control


signal highlight_clicked(highlight_name)


@onready var highlight_icon = $HighlightIcon

var highlight_name


func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))
	highlight_icon.play("default")


func set_highlight_name(new_name):
	highlight_name = new_name
	

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("highlight_clicked", highlight_name)
		highlight_icon.stop()
