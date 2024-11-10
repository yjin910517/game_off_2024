extends Node2D

# children node references
@onready var computer_control = $ComputerControl
@onready var calendar_control = $CalendarControl
@onready var vault_control = $VaultControl
@onready var top_book_control = $TopBookControl
@onready var globe_control = $GlobeControl
@onready var book_pile_control = $BookPileControl
@onready var projector_control = $ProjectorControl
@onready var food_container_control = $FoodContainerControl
@onready var bowl_control = $BowlControl

# dialogue box node
@onready var dialogue_box = $DialogueBox


# key game progress flags
var toby_fed = false
var passport_found = false
var disk_acquired = false
var disk_played = false
var globe_activated = false
var globe_opened = false
var has_vault_key = false
var vault_opened = false


# test data, should be moved to main node along with dialogue box
var dialogue_dataset = {
	"bowl": {
		"text_data": "Toby is still with the catsitter. The food bowl is empty. I better refill it.",
		"btn_data": {"label": "Add Food", "value": "feed"}
	},
	"container": {
		"text_data": "A box of cat food for Toby.",
		"btn_data": {"label": "Add Food", "value": "feed"}
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Interactive objects
	computer_control.connect("computer_clicked", Callable(self, "_on_computer_clicked"))
	calendar_control.connect("calendar_clicked", Callable(self, "_on_calendar_clicked"))
	vault_control.connect("vault_clicked", Callable(self, "_on_vault_clicked"))
	top_book_control.connect("passport_acquired", Callable(self, "_on_passport_acquired"))
	globe_control.connect("globe_clicked", Callable(self, "_on_globe_clicked"))
	book_pile_control.connect("book_pile_clicked", Callable(self, "_on_book_pile_clicked"))
	projector_control.connect("projector_clicked", Callable(self, "_on_projector_clicked"))
	food_container_control.connect("food_container_clicked", Callable(self, "_on_food_container_clicked"))
	bowl_control.connect("food_bowl_clicked", Callable(self, "_on_food_bowl_clicked"))
	
	
	# Dialogue box
	dialogue_box.connect("chosen_action", Callable(self, "_on_dialogue_action_chosen"))
	dialogue_box.z_index = 2
	dialogue_box.hide()


func _on_dialogue_action_chosen(action_name):
	print("room knows ", action_name)
	if action_name == "feed":
		toby_fed = true
		bowl_control.add_food()
		food_container_control.pour_food()
		# animation play
		# disable click with shield
		# show story scene to reveal notes in container

func _on_computer_clicked():
	pass

func _on_calendar_clicked():
	pass
	
func _on_vault_clicked():
	pass
	
func _on_passport_acquired():
	pass
	
func _on_globe_clicked():
	pass
	
func _on_book_pile_clicked():
	pass
	
func _on_projector_clicked():
	pass
	
func _on_food_container_clicked():
	# check fed or not
	if toby_fed:
		pass
	else:
		food_container_control.has_viewed = true
		var text_data = dialogue_dataset["container"]["text_data"]
		var btn_data = dialogue_dataset["container"]["btn_data"]
		# only display feed button when player has examined both food bowl and food container
		if bowl_control.has_viewed:
			dialogue_box.display_dialogue(text_data, btn_data)
		else:
			dialogue_box.display_dialogue(text_data, null)
	
	
func _on_food_bowl_clicked():
	# check fed or not
	if toby_fed:
		pass
	else:
		bowl_control.has_viewed = true
		var text_data = dialogue_dataset["bowl"]["text_data"]
		var btn_data = dialogue_dataset["bowl"]["btn_data"]
		# only display feed button when player has examined both food bowl and food container
		if food_container_control.has_viewed:
			dialogue_box.display_dialogue(text_data, btn_data)
		else:
			dialogue_box.display_dialogue(text_data, null)
