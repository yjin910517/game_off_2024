extends Control


signal passport_callout_clicked()


@onready var passport_icon = $PassportIcon


func _ready():
	passport_icon.connect("gui_input", Callable(self, "_on_gui_input"))


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("passport_callout_clicked")
