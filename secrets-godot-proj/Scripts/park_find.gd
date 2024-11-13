extends Control


signal park_item_found()


@onready var exit_icon = $ExitIcon
@onready var find_control = $FindControl
@onready var milestone_scene = $ParkMilestone
@onready var battery_icon = $ParkMilestone/IconDisplay
@onready var milestone_action = $ParkMilestone/ActionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	find_control.connect("highlight_clicked", Callable(self, "_on_highlight_clicked"))
	milestone_action.connect("action_clicked", Callable(self, "_on_milestone_completed"))
	
	milestone_scene.position = Vector2(0,0)
	milestone_scene.hide()
	
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	exit_icon.hide()


func _on_exit_clicked():
	milestone_scene.hide()
	hide()
	

func _on_highlight_clicked(e):
	milestone_scene.show()


func _on_milestone_completed(e):
	emit_signal("park_item_found")
	
	# clean up milestone scene for later revisit
	battery_icon.hide()
	milestone_action.hide()
	exit_icon.show()
	
	milestone_scene.hide()
	hide()
