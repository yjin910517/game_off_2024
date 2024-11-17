extends Node2D


signal show_end_scene()


@onready var password_box = $PasswordInputBox
@onready var shield = $TransparentShield


func _ready():
	password_box.connect("password_verified", Callable(self, "_on_password_verified"))
	password_box.connect("window_closed", Callable(self, "_on_window_closed"))
	
	shield.color = Color("#ffffff00")
	shield.position = Vector2(0,0)
	shield.z_index = 2 # already set in node inspector
	shield.hide()
		

func _on_password_verified():
	
	shield.show()
	await get_tree().create_timer(2).timeout
	shield.hide()
	
	emit_signal("show_end_scene")
	password_box.hide()


func _on_window_closed():
	hide()
