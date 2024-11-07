extends Control

@onready var read_me_icon = $ReadMeIcon
@onready var to_do_icon = $ToDoIcon
@onready var file_folder_icon = $FileIcon

@onready var read_me_doc = $ReadMeDoc
@onready var to_do_doc = $ToDoDoc
@onready var file_folder = $FileFolder

const DOC_WINDOW_POS = Vector2(44, 44)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_me_icon.connect("read_me_clicked", Callable(self, "_on_read_me_clicked"))
	to_do_icon.connect("to_do_clicked", Callable(self, "_on_to_do_clicked"))
	file_folder_icon.connect("file_folder_clicked", Callable(self, "_on_file_folder_clicked"))
	

func _on_read_me_clicked():
	read_me_doc.position = DOC_WINDOW_POS
	read_me_doc.show()


func _on_to_do_clicked():
	to_do_doc.position = DOC_WINDOW_POS
	to_do_doc.show()


func _on_file_folder_clicked():
	file_folder.position = DOC_WINDOW_POS
	file_folder.display_window()
