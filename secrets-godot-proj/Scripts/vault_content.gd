extends Control

@onready var icon_container = $IconContainer
@onready var doc_control = $IconContainer/DocControl
@onready var photo_book_control = $IconContainer/PhotoBookControl
@onready var letter_control = $IconContainer/LetterControl
@onready var ticket_control = $IconContainer/TicketControl
@onready var clue_control = $IconContainer/ClueControl

@onready var zoom_in = $ZoomIn
@onready var exit_icon = $ExitIcon
@onready var audio = $Audio


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	doc_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	doc_control.set_item_name("document")
	
	photo_book_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	photo_book_control.set_item_name("photobook")

	letter_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	letter_control.set_item_name("letter")
	
	ticket_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	ticket_control.set_item_name("ticket")

	clue_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	clue_control.set_item_name("clue")
	
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	
	zoom_in.connect("zoom_closed", Callable(self, "_on_zoom_closed"))


func open_door():
	audio.play()
	await get_tree().create_timer(1).timeout
	show()
	

func _on_item_clicked(control_node):

	var zoom_in_name = control_node.item_name
	zoom_in.display_zoom_in(zoom_in_name)
		
	_update_icon_display(control_node)	


# deactivate other icons and only highlight the clicked icon
func _update_icon_display(control_node):
		
	var all_icons = icon_container.get_children()
	for node in all_icons:
		if node == control_node:
			node.activate_icon()
		else:
			node.deactivate_icon()


func _on_zoom_closed():
	
	var all_icons = icon_container.get_children()
	for node in all_icons:
		node.activate_icon()
		

func _on_exit_clicked():
	hide()
