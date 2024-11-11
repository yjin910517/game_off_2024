extends Control


signal globe_unlocked()

@onready var map = $Map
@onready var content = $Content
@onready var exit_icon = $ExitIcon


var status
enum status_val {active, inactive, opened} # inactive, active, opened


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map.connect("target_clicked", Callable(self, "_on_target_clicked"))
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	
	map.position = Vector2(0,0)
	content.position = Vector2(0,0)
	
	status = status_val.inactive


func _on_exit_clicked():
	hide()

func _on_target_clicked():
	emit_signal("globe_unlocked")


func activate_globe():
	status = status_val.active
	map.activate_map()


func open_globe():
	status = status_val.opened
	display_scene()
	

func display_scene():
	if status == status_val.opened:
		map.hide()
		content.show()
	else:
		map.show()
		content.hide()
	
	show()
	
