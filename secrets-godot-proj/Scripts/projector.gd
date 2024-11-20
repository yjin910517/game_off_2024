extends Control


signal milestone_completed(milestone_name)

@onready var action_button = $ActionButton
@onready var later_button = $LaterButton
@onready var video_footage = $VideoFootage
@onready var exit_icon = $ExitIcon
@onready var audio = $Audio
@onready var timer = $Timer


var milestone_name
var is_first_show = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.connect("action_clicked", Callable(self, "_leave_projector_to_park"))
	later_button.connect("exit_clicked", Callable(self, "_leave_projector_to_room"))
	exit_icon.connect("exit_clicked", Callable(self, "_leave_projector_to_room"))
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	video_footage.play("default")


func read_disk():
	audio.play()	


func display_scene():
	
	if is_first_show:
		# temporarily hide action button
		hide_actions()
		exit_icon.hide()
		timer.wait_time = 5
		timer.start() # timer timeout will trigger button display
		is_first_show = false
	
	show()


func _on_timer_timeout():
	action_button.show()
	later_button.show()
	exit_icon.show()
	

# hide action buttons 
func hide_actions():
	action_button.hide()
	later_button.hide()
	

func _leave_projector_to_park(action_name):
	emit_signal("milestone_completed", milestone_name)
	hide()


func _leave_projector_to_room():
	hide()
