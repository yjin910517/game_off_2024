extends Control


signal milestone_completed(milestone_name)

@onready var action_button = $ActionButton
@onready var later_button = $LaterButton
@onready var video_footage = $VideoFootage
@onready var exit_icon = $ExitIcon
@onready var audio = $Audio

var milestone_name


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.connect("action_clicked", Callable(self, "_leave_projector_to_park"))
	later_button.connect("exit_clicked", Callable(self, "_leave_projector_to_room"))
	exit_icon.connect("exit_clicked", Callable(self, "_leave_projector_to_room"))
	
	video_footage.play("default")


func read_disk():
	audio.play()	


# hide action buttons after the battery is found in park
func hide_actions():
	action_button.hide()
	later_button.hide()
	

func _leave_projector_to_park(action_name):
	emit_signal("milestone_completed", milestone_name)
	hide()


func _leave_projector_to_room():
	hide()
