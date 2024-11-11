extends Control

signal chosen_action(action_name)
signal open_milestone(associated_milestone)

@onready var shield_layer = $TransparentShield
@onready var info_text_box = $UIBox/InfoText
@onready var action_ui_box = $UIBox/ActionUI
@onready var action_button = $UIBox/ActionUI/ActionButton
@onready var later_button = $UIBox/ActionUI/LaterButton
@onready var continue_icon = $UIBox/ContinueIcon


# use it to trigger milestone events
var associated_milestone


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.connect("action_clicked", Callable(self, "_on_action_clicked"))
	later_button.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	shield_layer.connect("gui_input", Callable(self, "_on_shield_gui_input"))
	shield_layer.color = Color("#ffffff00")


func _on_action_clicked(action_name):
	emit_signal("chosen_action", action_name)
	hide()


func _on_exit_clicked():
	hide()
	

func _on_shield_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if associated_milestone:
			emit_signal("open_milestone", associated_milestone)
		hide()


func display_dialogue(text_data, btn_data):
	if btn_data == null:
		_hide_action_ui()
		# put the shield layer on full screen to receive exit signal
		shield_layer.size.y = 540
		continue_icon.show()
	else:
		_show_action_ui()
		_update_button_data(btn_data)
		# reduce shield size and give reveal ui box
		shield_layer.size.y = 432
		continue_icon.hide()
	
	_update_info_text(text_data)
	show()	


func _show_action_ui():
	action_ui_box.show()
	# shorten text box to give space to ui box
	info_text_box.size.x = 560
	

func _hide_action_ui():
	action_ui_box.hide()
	# longer text box to fill the space
	info_text_box.size.x = 620


func _update_info_text(text_data):
	info_text_box.text = text_data
	

func _update_button_data(btn_data):
	action_button.set_button_data(btn_data)
