extends Control


signal trigger_next_highlight()


@onready var exit_icon = $ExitIcon

var has_clicked


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	has_clicked = false


func _on_exit_clicked():
	# trigger reveal of the next highlight if this is the first time open/close the zoom-in
	if has_clicked == false:
		emit_signal("trigger_next_highlight")
		has_clicked = true
		
	hide()
