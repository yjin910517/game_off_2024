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
@onready var vault = $VaultContent


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
	"book_stack": {
		"text_data": "Stacks of books she never finished. Even in her final days, she couldn't stop reading."
	},	
	"bowl": {
		"text_data": "Toby is still with the catsitter. The food bowl is empty. I should refill it.",
		"btn_data": {"label": "Add Food", "value": "feed"}
	},
	"container": {
		"text_data": "A box of cat food for Toby.",
		"btn_data": {"label": "Add Food", "value": "feed"}
	},
	"projector_no_disk": {
		"text_data": "An old-fashioned disk player. Nostalgic yet functional."
	},	
	"disk": {
		"text_data": "Hmm, there’s something stuck to the lid."
	},
	"projector_disk": {
		"text_data": "I think I can use this to play the disk I just found.",
		"btn_data": {"label": "Play Disk", "value": "projector"}
	},
	"inactive_globe": {
		"text_data": "An interactive world map. Its surface appears to be a touch screen. But it's powered off."
	},
	"globe_activation_1": {
		"text_data": "Could this battery bring the touchscreen globe to life?",
		"btn_data": {"label": "Use Battery", "value": "globe"}
	},
	"globe_activation_2": {
		"text_data": "The globe lights up as the battery clicks into place, its touchscreen now fully functional."
	},
	"activated_globe": {
		"text_data": "Our final journey together... That country... The place where it all began... and where it all ended."
	},
	"globe_unlock": {
		"text_data": "Something clicked. A hidden compartment inside the globe has revealed itself."
	},
	"vault_locked": {
		"text_data": "The vault is locked. I should look for the key."
	},
	"vault_open": {
		"text_data": "Unlock the vault?",
		"btn_data": {"label": "Unlock", "value": "vault"}
	},
}

var milestone_dataset = {
	"passport":{
		"text": "This book feels... off.\n\nIt’s not a book at all. It’s a disguised box.\n\nInside, Elysia kept her passport. ",
		"icon_texture": load("res://Arts/passport_milestone_icon.png"),
		"btn_label": "Open E's Passport",
		"margin": 214 # the position.x value of button
	},
	"disk":{
		"text": "You found a small envelope.\n\nInside, an old video disk is revealed.\n\nIt might be worth checking out.",
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
	
	# Vault content scene
	vault.position = Vector2(0,0)
	vault.z_index = 1 # already set in node inspector
	vault.hide()


# Navigation to park scene
func _on_navigation_clicked():
	emit_signal("navigate_to_park")
	hide()
		
		
# update room configs once the battery is found
func end_park_quest():
	
	# acquire battery
	has_globe_key = true
	
	# hide park entries
	park_nav.hide()
	projector.hide_actions()
	
	# highlight globe for next step
	globe_control.show_highlight()


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
		projector_control.show_highlight()
	
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
		
	if action_name == "vault":
		vault.show()
		vault_opened = true


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
			if has_globe_key == false:
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
	var text_data = dialogue_dataset["book_stack"]["text_data"]
	dialogue_box.display_dialogue(text_data, null)
	

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
	var info_text
	var btn_data
	if has_vault_key:
		if vault_opened == false:
			info_text = dialogue_dataset["vault_open"]["text_data"]
			btn_data = dialogue_dataset["vault_open"]["btn_data"]
			dialogue_box.display_dialogue(info_text, btn_data)
	else:
		info_text = dialogue_dataset["vault_locked"]["text_data"]
		dialogue_box.display_dialogue(info_text, null)
	
	
