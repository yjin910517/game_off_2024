extends Control

signal zoom_closed(item_node)

@onready var shield_layer = $TransparentShield
@onready var text_node = $NoteText

var item_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shield_layer.connect("gui_input", Callable(self, "_on_shield_gui_input"))
	shield_layer.color = Color("#ffffff00")
	position = Vector2(0,0)
	hide()


func display_zoom_in(control_node, text_data):
	item_node = control_node
	text_node.text = text_data
	show()


func display_clue():
	text_node.text = "will display pw clue"
	show()
		

func _on_shield_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("zoom_closed", item_node)
		print("zoom closed for ", item_node.name)
		hide()
