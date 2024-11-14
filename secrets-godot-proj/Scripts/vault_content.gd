extends Control

@onready var icon_container = $IconContainer
@onready var doc_control = $IconContainer/DocControl
@onready var photo_book_control = $IconContainer/PhotoBookControl
@onready var zoom_in = $ZoomIn
@onready var exit_icon = $ExitIcon


var zoom_dataset = {
	"document": "Elysia's medical records, insurance files, and legal documents. She kept everything organized for me.",
	"photobook": "A photo album of our shared memories. I didn't know she has printed these photos and put this together..."	
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	doc_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	doc_control.set_item_name("document")
	
	photo_book_control.connect("item_clicked", Callable(self, "_on_item_clicked"))
	photo_book_control.set_item_name("photobook")
	
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	

func _on_item_clicked(control_node):
	if control_node.item_name == "clue":
		zoom_in.display_clue()
		# to do: display the picture of pw clue in zoom in 
		
	else:
		# show zoom-in text info
		var text_data = zoom_dataset[control_node.item_name]
		zoom_in.display_zoom_in(control_node, text_data)
		
	_update_icon_display(control_node)	


# deactivate other icons and only highlight the clicked icon
func _update_icon_display(control_node):
		
	var all_icons = icon_container.get_children()
	for node in all_icons:
		if node == control_node:
			node.highlight_icon()
		else:
			node.deactivate_icon()


func _on_exit_clicked():
	hide()
