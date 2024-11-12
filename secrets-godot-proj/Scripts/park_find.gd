extends Control


signal park_item_found()


@onready var find_control = $FindControl
@onready var milestone_scene = $ParkMilestone
@onready var milestone_action = $ParkMilestone/ActionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	find_control.connect("highlight_clicked", Callable(self, "_on_highlight_clicked"))
	milestone_action.connect("action_clicked", Callable(self, "_on_milestone_completed"))
	
	milestone_scene.position = Vector2(0,0)
	milestone_scene.hide()


func _on_highlight_clicked(e):
	milestone_scene.show()


func _on_milestone_completed(e):
	emit_signal("park_item_found")
	hide()
