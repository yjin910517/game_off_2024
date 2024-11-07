extends Node2D


@onready var password_box = $PasswordInputBox
@onready var folder_content = $FolderContent


var pw_verified = false


func _ready():
	password_box.connect("password_verified", Callable(self, "_on_password_verified"))
	password_box.connect("window_closed", Callable(self, "_on_window_closed"))
	folder_content.connect("window_closed", Callable(self, "_on_window_closed"))
	
	password_box.hide()
	folder_content.hide()


# when the icon is clicked, choose content to display
func display_window():
	if pw_verified == true:
		folder_content.show()
		password_box.hide()
	else:
		password_box.show()
		folder_content.hide()
	
	show()
		

func _on_password_verified():
	pw_verified = true
	display_window()


func _on_window_closed():
	hide()
