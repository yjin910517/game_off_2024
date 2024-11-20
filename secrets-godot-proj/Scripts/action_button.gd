extends Control

signal action_clicked(action_value)

@onready var text_node = $ActionText
@onready var highlight = $OptionHighlight

var option_value = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("gui_input", Callable(self, "_on_gui_input"))
	highlight.hide()


func set_button_data(btn_data):
	option_value = btn_data["value"]
	text_node.text = btn_data["label"]


func _on_mouse_entered():
	highlight.show()
	

func _on_mouse_exited():
	highlight.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("action_clicked", option_value)
