extends Control

signal back_to_room()
signal end_scene_started()

@onready var home_nav = $HomeNav
@onready var read_me_icon = $ReadMeIcon
@onready var to_do_icon = $ToDoIcon
@onready var file_folder_icon = $FileIcon

@onready var read_me_doc = $ReadMeDoc
@onready var to_do_doc = $ToDoDoc
@onready var file_folder = $FileFolder
@onready var end_scene = $EndScene

const DOC_WINDOW_POS = Vector2(43, 44)


var read_me_has_viewed = false
var to_do_has_viewed = false
var folder_has_viewed = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_me_icon.connect("read_me_clicked", Callable(self, "_on_read_me_clicked"))
	to_do_icon.connect("to_do_clicked", Callable(self, "_on_to_do_clicked"))
	file_folder_icon.connect("file_folder_clicked", Callable(self, "_on_file_folder_clicked"))
	
	home_nav.connect("navigation_clicked", Callable(self, "_on_navigation_clicked"))
	home_nav.hide()
	
	read_me_doc.hide()
	to_do_doc.hide()
	
	file_folder.connect("show_end_scene", Callable(self, "_on_show_end_scene"))
	file_folder.hide()

	end_scene.position = Vector2(0,0)
	end_scene.hide()


func _on_navigation_clicked():
	emit_signal("back_to_room")
	hide()
	

func _on_read_me_clicked():
	read_me_doc.position = DOC_WINDOW_POS
	read_me_doc.show()
	if read_me_has_viewed == false:
		read_me_has_viewed = true
		_update_nav_display()


func _on_to_do_clicked():
	to_do_doc.position = DOC_WINDOW_POS
	to_do_doc.show()
	if to_do_has_viewed == false:
		to_do_has_viewed = true
		_update_nav_display()


func _on_file_folder_clicked():
	file_folder.position = DOC_WINDOW_POS
	file_folder.show()
	if folder_has_viewed == false:
		folder_has_viewed = true
		_update_nav_display()
		

func _update_nav_display():
	if read_me_has_viewed and to_do_has_viewed and folder_has_viewed:
		home_nav.show()


func _on_show_end_scene():
	# let main stop bgm
	emit_signal("end_scene_started")
	end_scene.play_scene()
