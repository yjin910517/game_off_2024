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
@onready var passport_callout = $PassportCallout

# reusable info scenes
@onready var dialogue_box = $DialogueBox
@onready var milestone_scene = $Milestone

# object scenes
@onready var passport = $PassportContent 
@onready var globe_map = $GlobeMap



# key game progress flags
var toby_fed = false
var passport_found = false
var disk_acquired = false # not happen in this node
var disk_played = false
var has_globe_key = false
var has_vault_key = false
var vault_opened = false


# dialogue data
var dialogue_dataset = {
	"bowl": {
		"text_data": "Toby is still with the catsitter. The food bowl is empty. I better refill it.",
		"btn_data": {"label": "Add Food", "value": "feed"}
	},
	"container": {
		"text_data": "A box of cat food for Toby.",
		"btn_data": {"label": "Add Food", "value": "feed"}
	},
	"inactive_globe": {
		"text_data": "A globe with world map on it. The surface seems to be a touch screen."
	},
	"globe_activation": {
		"text_data": "The gadget worked on the globe. Now the touch screen has been swtiched on."
	},
	"globe_unlock": {
		"text_data": "The globe starts making sound. A lock clicked sound. Is it a lockbox?"
	},
}

var milestone_dataset = {
	"passport":{
		"text": "This book feels different.\n\nIt is not a book. It is a disguised box.\n\nElysia keeps her passport in it.\n\nNow I remember it. ",
		"icon_texture": load("res://Arts/passport_milestone_icon.png"),
		"btn_label": "Open E's Passport!"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Interactive objects
	computer_control.connect("computer_clicked", Callable(self, "_on_computer_clicked"))
	calendar_control.connect("calendar_clicked", Callable(self, "_on_calendar_clicked"))
	vault_control.connect("vault_clicked", Callable(self, "_on_vault_clicked"))
	top_book_control.connect("passport_box_found", Callable(self, "_on_passport_box_found"))
	top_book_control.connect("show_book_info", Callable(self, "_on_show_book_info"))
	globe_control.connect("globe_clicked", Callable(self, "_on_globe_clicked"))
	book_pile_control.connect("book_pile_clicked", Callable(self, "_on_book_pile_clicked"))
	projector_control.connect("projector_clicked", Callable(self, "_on_projector_clicked"))
	food_container_control.connect("food_container_clicked", Callable(self, "_on_food_container_clicked"))
	bowl_control.connect("food_bowl_clicked", Callable(self, "_on_food_bowl_clicked"))
	
	passport_callout.connect("passport_callout_clicked", Callable(self, "_on_passport_callout_clicked"))
	passport_callout.hide()
	
	# Dialogue box
	dialogue_box.connect("chosen_action", Callable(self, "_on_dialogue_action_chosen"))
	dialogue_box.connect("open_milestone", Callable(self, "_on_open_milestone"))
	dialogue_box.position = Vector2(0,0)
	dialogue_box.z_index = 2 # already set in node inspector, otherwise need render again
	dialogue_box.hide()

	# Milestone scene
	milestone_scene.connect("milestone_completed", Callable(self, "_on_dialogue_action_chosen"))
	milestone_scene.position = Vector2(0,0)
	milestone_scene.z_index = 1 # already set in node inspector
	milestone_scene.hide()

	# Passport scene
	passport.position = Vector2(0,0)
	passport.z_index = 1 # already set in node inspector
	passport.hide()
	
	# Globe map scene
	globe_map.connect("globe_unlocked", Callable(self, "_on_globe_unlocked"))
	globe_map.position = Vector2(0,0)
	globe_map.z_index = 1 # already set in node inspector
	globe_map.hide()


# Handle action signals from dialogue
func _on_dialogue_action_chosen(action_name):
	
	if action_name == "feed":
		toby_fed = true
		bowl_control.add_food()
		food_container_control.pour_food()
		# animation play
		# disable click with shield
		# show story scene to reveal notes in container
		
	if action_name == "passport":
		passport_found = true
		passport_callout.show()
		passport.show()


# Display milestone page
func _on_open_milestone(milestone_name):
		
		# show the standard milestone scene
		if milestone_name in ("passport"):
			# reformat milestone data
			var milestone_data = milestone_dataset[milestone_name]
			milestone_data["name"] = milestone_name
			milestone_data["btn_data"] = {"label": milestone_data["btn_label"], "value": milestone_name}
			
			# show milestone scene
			milestone_scene.update_display(milestone_data)
		
		# show the custom reaction or scene
		if milestone_name == "globe_unlock":
			globe_map.open_globe()
			
		# reset dialogue box associated milestone
		dialogue_box.associated_milestone = null
	

func _on_computer_clicked():
	pass

func _on_calendar_clicked():
	# test only
	has_globe_key = true
	
func _on_vault_clicked():
	pass
	
func _on_passport_box_found(info_text):

	if passport_found:
		# directly show passport content for return visit
		passport.show()
	else:
		# show dialogue
		dialogue_box.associated_milestone = "passport"
		dialogue_box.display_dialogue(info_text, null)


func _on_passport_callout_clicked():
	passport.show()


func _on_show_book_info(info_text):
	dialogue_box.display_dialogue(info_text, null)
			
	
func _on_globe_clicked():
	if globe_map.status == 1: # inactive enum
		var info_text
		if has_globe_key:
			globe_map.activate_globe()
			info_text = dialogue_dataset["globe_activation"]["text_data"]
		else: 
			info_text = dialogue_dataset["inactive_globe"]["text_data"]
			
		globe_map.display_scene()
		dialogue_box.display_dialogue(info_text, null)
	else:
		globe_map.display_scene()


func _on_globe_unlocked():
	
	dialogue_box.associated_milestone = "globe_unlock"
	var info_text = dialogue_dataset["globe_unlock"]["text_data"]
	dialogue_box.display_dialogue(info_text, null)


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
