extends Control

signal milestone_completed(milestone_name)


@onready var info_text_box = $InfoText
@onready var icon_display = $IconDisplay
@onready var action_button = $ActionButton
@onready var timer = $Timer


var milestone_name
var is_reacting = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.connect("action_clicked", Callable(self, "_complete_milestone"))
	icon_display.connect("gui_input", Callable(self, "_on_icon_gui_input"))
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))


func update_display(milestone_data):
	milestone_name = milestone_data["name"]
	info_text_box.text = milestone_data["text"]
	icon_display.texture = milestone_data["icon_texture"]
	action_button.position.x = milestone_data["margin"]
	action_button.set_button_data(milestone_data["btn_data"])
	
	# temporarily hide action button
	action_button.hide()
	timer.wait_time = 2
	timer.start() # timer timeout will trigger button display
	
	show()


func _on_timer_timeout():
	action_button.show()
	is_reacting = true


func _on_icon_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_reacting:
			_complete_milestone(milestone_name)


func _complete_milestone(milestone_name):
	emit_signal("milestone_completed", milestone_name)
	hide()
