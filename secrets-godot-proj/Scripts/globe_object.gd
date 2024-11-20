extends Control


signal globe_unlocked()
signal milestone_completed(milestone_name)


@onready var map = $Map
@onready var content = $Content
@onready var key_icon = $Content/Key
@onready var action_button = $Content/ActionButton
@onready var exit_icon = $ExitIcon
@onready var audio = $Audio
@onready var timer = $Timer


var status
enum status_val {inactive, active, opened} # inactive, active, opened
var milestone_name = "key"
var is_first_show = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map.connect("target_clicked", Callable(self, "_on_target_clicked"))
	action_button.connect("action_clicked", Callable(self, "_complete_milestone"))
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	map.position = Vector2(0,0)
	content.position = Vector2(0,0)
	
	status = status_val.inactive


func _on_exit_clicked():
	hide()


func _on_target_clicked():
	emit_signal("globe_unlocked")


func activate_globe():
	# update status
	status = status_val.active
	
	# play battery sound
	audio.play()
	
	# activate map
	await get_tree().create_timer(3).timeout
	map.activate_map()


func open_globe():
	status = status_val.opened
	display_scene()


func _complete_milestone(e):
	emit_signal("milestone_completed", milestone_name)
	key_icon.hide()
	action_button.hide()
	hide()
	

func display_scene():
	if status == status_val.opened:
		map.hide()
		if is_first_show:
			# temporarily hide action button
			action_button.hide()
			exit_icon.hide()
			timer.wait_time = 3
			timer.start() # timer timeout will trigger button display
			is_first_show = false
		content.show()

	else:
		map.show()
		content.hide()
	
	show()
	
	
func _on_timer_timeout():
	action_button.show()
	exit_icon.show()
