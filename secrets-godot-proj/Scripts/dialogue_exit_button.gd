extends Control

signal exit_clicked()


@onready var highlight = $OptionHighlight


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("gui_input", Callable(self, "_on_gui_input"))
	highlight.hide()
	

func _on_mouse_entered():
	highlight.show()
	

func _on_mouse_exited():
	highlight.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("exit_clicked")
		print("clicked later/exit button")
