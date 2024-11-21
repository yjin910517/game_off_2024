extends Control


signal letter_clicked()

@onready var highlight_icon = $HighlightIcon


func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))
	highlight_icon.hide()


func show_highlight():
	show()
	highlight_icon.show()
	highlight_icon.play("default")


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("letter_clicked")
		highlight_icon.hide()
