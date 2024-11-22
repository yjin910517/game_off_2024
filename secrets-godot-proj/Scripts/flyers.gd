extends Control


@onready var page_display = $Display
@onready var left_arrow = $ArrowLeft
@onready var right_arrow = $ArrowRight
@onready var exit_icon = $ExitIcon
@onready var audio = $Audio


var current_page_idx
var max_page_idx

var pages = [
	preload("res://Arts/funeral_flyer_1.png"),
	preload("res://Arts/funeral_flyer_2.png"),
	preload("res://Arts/funeral_flyer_3.png"),
	preload("res://Arts/funeral_flyer_4.png")
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_arrow.connect("page_turn", Callable(self, "_on_page_turn"))
	right_arrow.connect("page_turn", Callable(self, "_on_page_turn"))
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	
	left_arrow.set_arrow_direction("left")
	right_arrow.set_arrow_direction("right")
	
	current_page_idx = 0
	page_display.texture = pages[current_page_idx]
	max_page_idx = len(pages) - 1


func _on_page_turn(direction):
	
	if direction == "left":
		current_page_idx -= 1
	else:
		current_page_idx += 1
		
	if current_page_idx < 0:
		current_page_idx = max_page_idx
	if current_page_idx > max_page_idx:
		current_page_idx = 0
	
	# play sound
	audio.play()	
	# display new page texture and ui icons
	page_display.texture = pages[current_page_idx]
	
	
func _on_exit_clicked():
	hide()
