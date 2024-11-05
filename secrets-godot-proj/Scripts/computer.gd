extends Control

var DOC_WINDOW_POS = Vector2(44, 44)

@onready var read_me = $ReadMeIcon
@onready var to_do = $ToDoIcon
@onready var file_folder = $FileIcon

@onready var read_me_doc = $ReadMeDoc

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	read_me.connect("read_me_clicked", Callable(self, "_on_read_me_clicked"))
	to_do.connect("to_do_clicked", Callable(self, "_on_to_do_clicked"))
	file_folder.connect("file_folder_clicked", Callable(self, "_on_file_folder_clicked"))
	

func _on_read_me_clicked():
	read_me_doc.position = DOC_WINDOW_POS
	read_me_doc.show()


func _on_to_do_clicked():
	print("computer knows to do")


func _on_file_folder_clicked():
	print("file folder clicked")
