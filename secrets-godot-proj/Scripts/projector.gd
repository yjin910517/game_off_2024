extends Control


signal milestone_completed(milestone_name)

@onready var action_button = $ActionButton
@onready var later_button = $LaterButton
@onready var video_footage = $VideoFootage


var milestone_name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.connect("action_clicked", Callable(self, "_leave_projector_to_park"))
	later_button.connect("exit_clicked", Callable(self, "_leave_projector_to_room"))
	
	video_footage.play("default")


func _leave_projector_to_park(action_name):
	emit_signal("milestone_completed", milestone_name)
	hide()


func _leave_projector_to_room():
	hide()
