extends Control

signal window_closed()

@onready var exit_icon = $ExitIcon

const WINDOW_POS = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	position = WINDOW_POS
	hide()
	

func _on_exit_clicked():
	emit_signal("window_closed")
