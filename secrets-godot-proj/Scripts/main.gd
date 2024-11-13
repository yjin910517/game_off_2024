extends Control

@onready var computer = $Computer
@onready var study_room = $StudyRoom
@onready var mountain_park = $MountainPark

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	study_room.connect("navigate_to_park", Callable(self, "_on_navigate_to_park"))
	mountain_park.connect("navigate_to_home", Callable(self, "_on_navigate_to_home"))
	# computer.connect()
	
	# define the game start scene here
	study_room.show()
	mountain_park.hide()
	computer.hide()


func _on_navigate_to_park():
	mountain_park.show()
	

func _on_navigate_to_home(item_found):
	study_room.has_globe_key = item_found
	study_room.show()
