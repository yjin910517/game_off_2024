extends Control


signal item_clicked(control_node)


@onready var block_rect = $BlockRect


var item_name


func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("gui_input", Callable(self, "_on_gui_input"))
	activate_icon()


func set_item_name(new_name):
	item_name = new_name


func activate_icon():
	block_rect.hide()


func deactivate_icon():
	block_rect.show()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("item_clicked", self)


func _on_mouse_entered():
	position = position + Vector2(2,2)
	

func _on_mouse_exited():
	position = position - Vector2(2,2)
