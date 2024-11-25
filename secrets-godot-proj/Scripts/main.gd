extends Control

@onready var computer = $Computer
@onready var study_room = $StudyRoom
@onready var mountain_park = $MountainPark
@onready var commute = $Commute
@onready var audio = $Audio


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	study_room.connect("navigate_to_park", Callable(self, "_on_navigate_to_park"))
	study_room.connect("open_computer", Callable(self, "_on_open_computer"))
	mountain_park.connect("navigate_to_home", Callable(self, "_on_navigate_to_home"))
	computer.connect("back_to_room", Callable(self, "_on_leave_computer"))
	computer.connect("end_scene_started", Callable(self, "_on_end_scene_started"))
	commute.connect("arrive_at", Callable(self, "_on_arrive_at"))
	
	# define the game start scene here
	computer.hide()
	study_room.hide()
	mountain_park.hide()
	commute.hide()
	
	audio.play()
	_on_open_computer()


# home to park
func _on_navigate_to_park():
	commute.home_to_park()


# park to home
func _on_navigate_to_home(item_found):
	if item_found:
		study_room.end_park_quest()
	commute.park_to_home()


func _on_arrive_at(destination):
	if destination == "park":
		mountain_park.show()
		
	if destination == "home":
		study_room.show()	


# computer to room
func _on_leave_computer():
	study_room.show()
	audio.volume_db = -4
	


# room to computer 
func _on_open_computer():
	computer.show()
	audio.volume_db = -6


# end scene
func _on_end_scene_started():
	audio.stop()
