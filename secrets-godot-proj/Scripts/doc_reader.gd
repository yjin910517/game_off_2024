extends Control

@onready var exit_icon = $ExitIcon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	

func _on_exit_clicked():
	hide()
