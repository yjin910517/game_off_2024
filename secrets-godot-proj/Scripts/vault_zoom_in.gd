extends Control

signal zoom_closed()

@onready var shield_layer = $TransparentShield
@onready var info_container = $InfoContainer
@onready var doc_info = $InfoContainer/FileInfo
@onready var photo_book_info = $InfoContainer/PhotoBookInfo
@onready var letter_info = $InfoContainer/LetterInfo
@onready var ticket_info = $InfoContainer/TicketInfo
@onready var clue_info = $InfoContainer/ClueInfo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shield_layer.connect("gui_input", Callable(self, "_on_shield_gui_input"))
	shield_layer.color = Color("#ffffff00")
	position = Vector2(0,0)
	hide()


func display_zoom_in(zoom_in_name):
	
	# hide all info box
	var info_boxes = info_container.get_children()
	for box in info_boxes:
		box.hide()
	
	# show the selected info box
	if zoom_in_name == "document":
		doc_info.show()
	if zoom_in_name == "photobook":
		photo_book_info.show()
	if zoom_in_name == "letter":
		letter_info.show()
	if zoom_in_name == "ticket":
		ticket_info.show()
	if zoom_in_name == "clue":
		clue_info.show()
 
	show()


func _on_shield_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("zoom_closed")
		hide()
