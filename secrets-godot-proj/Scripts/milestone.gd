extends Control

signal milestone_completed(milestone_name)


@onready var info_text_box = $InfoText
@onready var icon_display = $IconDisplay
@onready var action_button = $ActionButton


var milestone_name


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.connect("action_clicked", Callable(self, "_complete_milestone"))
	icon_display.connect("gui_input", Callable(self, "_on_icon_gui_input"))


func update_display(milestone_data):
	milestone_name = milestone_data["name"]
	info_text_box.text = milestone_data["text"]
	icon_display.texture = milestone_data["icon_texture"]
	action_button.set_button_data(milestone_data["btn_data"])
	show()
	# to do: play sound effect


func _on_icon_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_complete_milestone(milestone_name)


func _complete_milestone(milestone_name):
	emit_signal("milestone_completed", milestone_name)
	hide()
