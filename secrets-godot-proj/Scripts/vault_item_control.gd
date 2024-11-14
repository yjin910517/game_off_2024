extends Control


signal item_clicked(control_node)


@onready var hover_rect = $HoverRect
@onready var block_rect = $BlockRect


var item_name


func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))
	activate_icon()


func set_item_name(new_name):
	item_name = new_name


func activate_icon():
	block_rect.hide()
	hover_rect.show()


func highlight_icon():
	block_rect.hide()
	hover_rect.hide()


func deactivate_icon():
	block_rect.show()
	hover_rect.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("item_clicked", self)
