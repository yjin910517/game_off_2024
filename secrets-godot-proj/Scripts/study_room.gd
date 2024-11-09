extends Node2D

@onready var computer_control = $ComputerControl
@onready var calendar_control = $CalendarContrl
@onready var vault_control = $VaultControl
@onready var top_book_control = $TopBookControl
@onready var globe_control = $GlobeControl
@onready var book_pile_control = $BookPileControl
@onready var projector_control = $ProjectorControl
@onready var food_container_control = $FoodContainerControl
@onready var bowl_control = $BowlControl


# key game progress status
var toby_fed = false
var passport_found
var disk_acquired
var disk_played
var globe_activated
var globe_opened
var has_vault_key
var vault_opened

# Called when the node enters the scene tree for the first time.
func _ready():
	computer_control.connect("computer_clicked", Callable(self, "_on_computer_clicked"))
	calendar_control.connect("calendar_clicked", Callable(self, "_on_calendar_clicked"))
	vault_control.connect("vault_clicked", Callable(self, "_on_vault_clicked"))
	top_book_control.connect("passport_acquired", Callable(self, "_on_passport_acquired"))
	globe_control.connect("globe_clicked", Callable(self, "_on_globe_clicked"))
	book_pile_control.connect("book_pile_clicked", Callable(self, "_on_book_pile_clicked"))
	projector_control.connect("projector_clicked", Callable(self, "_on_projector_clicked"))
	food_container_control.connect("food_container_clicked", Callable(self, "_on_food_container_clicked"))
	bowl_control.connect("food_bowl_clicked", Callable(self, "_on_food_bowl_clicked"))


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
	# if fed:
	# info box
	# if not feed yet:
	# add method to update container status and display
	# check bowl status
	# display ui button if status is ready
	pass
	
func _on_food_bowl_clicked():
	pass
