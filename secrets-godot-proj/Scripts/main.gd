extends Control

@onready var computer = $Computer
@onready var study_room = $StudyRoom
@onready var mountain_park = $MountainPark

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	study_room.connect("navigate_to_park", Callable(self, "_on_navigate_to_park"))
	study_room.connect("open_computer", Callable(self, "_on_open_computer"))
	mountain_park.connect("navigate_to_home", Callable(self, "_on_navigate_to_home"))
	computer.connect("back_to_room", Callable(self, "_on_leave_computer"))
	
	# define the game start scene here
	computer.show()
	study_room.hide()
	mountain_park.hide()


# home to park
func _on_navigate_to_park():
	mountain_park.show()
	
	
# park to home
func _on_navigate_to_home(item_found):
	if item_found:
		study_room.end_park_quest()
	study_room.show()


# computer to room
func _on_leave_computer():
	study_room.show()


# room to computer 
func _on_open_computer():
	computer.show()
