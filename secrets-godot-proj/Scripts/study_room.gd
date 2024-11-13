extends Node2D


signal navigate_to_park()
signal open_computer()


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
@onready var park_nav = $ParkNav

# util node (action blocker, etc)
@onready var shield = $TransparentShield

# reusable info scenes
@onready var dialogue_box = $DialogueBox
@onready var milestone_scene = $Milestone

# object scenes
@onready var passport = $PassportContent 
@onready var globe_map = $GlobeMap
@onready var projector = $Projector


# key game progress flags
var toby_fed = false
var passport_found = false
var disk_acquired = false # not happen in this node
var disk_played = false
var has_globe_key = false
var has_vault_key = false


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
	"projector_no_disk": {
		"text_data": "An old-fashion disk player. You can insert compatible memory disk and view content."
	},	
	"disk": {
		"text_data": "Hmm, there is something on the lid."
	},
	"projector_disk": {
		"text_data": "I can use it to play the disk I just found.",
		"btn_data": {"label": "Play Disk", "value": "projector"}
	},
	"inactive_globe": {
		"text_data": "A globe with world map on it. The surface seems to be a touch screen."
	},
	"globe_activation_1": {
		"text_data": "The battery seems to match a socket at the bottom of the globe.",
		"btn_data": {"label": "Use Battery", "value": "globe"}
	},
	"globe_activation_2": {
		"text_data": "The globe light up after you inserted the battery. Now the touchscreen is functional."
	},
	"activated_globe": {
		"text_data": "Our last trip together...That country...Where we first met... Where we said our goodbyes..."
	},
	"globe_unlock": {
		"text_data": "The globe starts making sound. A lock clicked sound. Is it a lockbox?"
	},
}

var milestone_dataset = {
	"passport":{
		"text": "This book feels different.\n\nIt is not a book. It is a disguised box.\n\nElysia keeps her passport in it.\n\nNow I remember it. ",
		"icon_texture": load("res://Arts/passport_milestone_icon.png"),
		"btn_label": "Open E's Passport",
		"margin": 214 # the position.x value of button
	},
	"disk":{
		"text": "There is an envelope sticked to the lid.\n\nInside is an old memory disk.\n\nCan be played on the projector.",
		"icon_texture": load("res://Arts/disk_icon.png"),
		"btn_label": "Take Disk & Continue",
		"margin": 160 # the position.x value of button
	},	
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

	park_nav.connect("navigation_clicked", Callable(self, "_on_navigation_clicked"))
	park_nav.hide()
	
	# Action block shield
	shield.color = Color("#ffffff00")
	shield.position = Vector2(0,0)
	shield.z_index = 2 # already set in node inspector
	shield.hide()
	
	# Dialogue box
	dialogue_box.connect("chosen_action", Callable(self, "_on_dialogue_action_chosen"))
	dialogue_box.connect("open_milestone", Callable(self, "_on_open_milestone"))
	dialogue_box.position = Vector2(0,0)
	dialogue_box.z_index = 2 # already set in node inspector
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
	globe_map.connect("milestone_completed", Callable(self, "_on_dialogue_action_chosen"))
	globe_map.position = Vector2(0,0)
	globe_map.z_index = 1 # already set in node inspector
	globe_map.hide()
	
	# Projector scene
	projector.connect("milestone_completed", Callable(self, "_on_dialogue_action_chosen"))
	projector.position = Vector2(0,0)
	projector.z_index = 1 # already set in node inspector
	projector.hide()


# Navigation to park scene
func _on_navigation_clicked():
	emit_signal("navigate_to_park")
	hide()
		

# Handle action signals from dialogue
func _on_dialogue_action_chosen(action_name):
		
	if action_name == "passport":
		passport_found = true
		passport_callout.show()
		passport.show()
		
	if action_name == "feed":
		toby_fed = true
		bowl_control.add_food()
		food_container_control.pour_food()
		# to do: animation & sound
		shield.show()
		await get_tree().create_timer(2).timeout
		shield.hide()
		
		# show dialogue that leads to milestone scene of disk discovery
		dialogue_box.associated_milestone = "disk"
		var info_text = dialogue_dataset["disk"]["text_data"]
		dialogue_box.display_dialogue(info_text, null)

	if action_name == "disk":
		disk_acquired = true
	
	if action_name == "projector":
		
		shield.show()
		# to do: sound effect
		await get_tree().create_timer(1).timeout
		_on_open_milestone("projector")
		shield.hide()
	
	if action_name == "park":
		emit_signal("navigate_to_park")
		hide()
	
	if action_name == "globe":
	
		shield.show()
		# to do: add sound effect
		await get_tree().create_timer(1).timeout
		globe_map.activate_globe()
		await get_tree().create_timer(1).timeout
		shield.hide()
		
		# display next dialogue to complete the activation
		var info_text = dialogue_dataset["globe_activation_2"]["text_data"]
		dialogue_box.display_dialogue(info_text, null)

	if action_name == "key":
		has_vault_key = true


# Display milestone page
func _on_open_milestone(milestone_name):
		
		# show the standard milestone scene
		if milestone_name == "passport" or milestone_name == "disk":
			# reformat milestone data
			var milestone_data = milestone_dataset[milestone_name]
			milestone_data["name"] = milestone_name
			milestone_data["btn_data"] = {"label": milestone_data["btn_label"], "value": milestone_name}
			
			# show milestone scene
			milestone_scene.update_display(milestone_data)
		
		# show the custom reaction or scene
		if milestone_name == "projector":
			projector.milestone_name = "park"
			projector.show()
			disk_played = true
			park_nav.show()
		
		if milestone_name == "globe_unlock":
			globe_map.open_globe()
			
		# reset dialogue box associated milestone
		dialogue_box.associated_milestone = null
	

func _on_computer_clicked():
	emit_signal("open_computer")
	hide()
	

func _on_calendar_clicked():
	# test only
	has_globe_key = true
	

func _on_show_book_info(info_text):
	dialogue_box.display_dialogue(info_text, null)
	
	
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


func _on_book_pile_clicked():
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


func _on_projector_clicked():
	var info_text
	var btn_data
	if disk_acquired:
		# show dialogue if this is the first time playing video
		if disk_played == false:
			info_text = dialogue_dataset["projector_disk"]["text_data"]
			btn_data = dialogue_dataset["projector_disk"]["btn_data"]
			dialogue_box.display_dialogue(info_text, btn_data)
			
		# otherwise directly show projector scene
		else:
			_on_open_milestone("projector")
			
	else:
		info_text = dialogue_dataset["projector_no_disk"]["text_data"]
		dialogue_box.display_dialogue(info_text, null)
			
	
func _on_globe_clicked():
	var info_text
	var btn_data
	if globe_map.status == 0: # inactive enum
		# show the prompt if the key is acquired but the globe is not activated yet.
		if has_globe_key:
			info_text = dialogue_dataset["globe_activation_1"]["text_data"]
			btn_data = dialogue_dataset["globe_activation_1"]["btn_data"]
			dialogue_box.display_dialogue(info_text, btn_data)
				
		# show inactive globe info
		else: 
			info_text = dialogue_dataset["inactive_globe"]["text_data"]
			dialogue_box.display_dialogue(info_text, null)
			
	# use dialogue to repeat note clue if the globe is activated but not opened yet
	if globe_map.status == 1: # active enum
		info_text = dialogue_dataset["activated_globe"]["text_data"]
		dialogue_box.display_dialogue(info_text, null)
		
	# display scene for all status
	globe_map.display_scene()


func _on_globe_unlocked():
	
	dialogue_box.associated_milestone = "globe_unlock"
	var info_text = dialogue_dataset["globe_unlock"]["text_data"]
	dialogue_box.display_dialogue(info_text, null)


func _on_vault_clicked():
	print("has vault key? ", has_vault_key)
	
	
