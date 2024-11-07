extends Control

signal password_verified()
signal window_closed()


@onready var exit_icon = $ExitIcon
@onready var pw_edit = $PWInput
@onready var feedback_msg = $FeedbackMsg


const CORRECT_PW = "2016"


# Called when the node enters the scene tree for the first time.
func _ready():
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	pw_edit.connect("text_submitted", Callable(self, "_on_pw_entered"))
	
	feedback_msg.hide()
	pw_edit.text = ""


func _on_exit_clicked():
	emit_signal("window_closed")
	
	
func _on_pw_entered(entered_password: String):
	
	# Clear pw input box
	pw_edit.text = ""
	
	# Verify pw
	if entered_password.to_lower() == CORRECT_PW.to_lower():
		# To do: Play sound affect
		emit_signal("password_verified")
	else:
		# to do: draw from a pool of feedback messages
		# move the method to msg node script?
		feedback_msg.text = "Submitted wrong pw: " + entered_password
		feedback_msg.show()
		await get_tree().create_timer(3).timeout
		feedback_msg.hide()
	
	
