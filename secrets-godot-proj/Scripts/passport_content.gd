extends Control

@onready var page_display = $PageDisplay
@onready var left_arrow = $ArrowLeft
@onready var right_arrow = $ArrowRight
@onready var exit_icon = $ExitIcon
@onready var audio = $Audio


var current_page_idx
var max_page_idx

var pages = [
	preload("res://Arts/passport_cover.png"),
	preload("res://Arts/passport_id_page.png"),
	preload("res://Arts/passport_inner_p1.png"),
	preload("res://Arts/passport_inner_p2.png"),
	preload("res://Arts/passport_inner_p3.png"),
	preload("res://Arts/passport_inner_p4.png"),
	preload("res://Arts/passport_blank_page.png"),
	preload("res://Arts/passport_back.png")
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	left_arrow.connect("page_turn", Callable(self, "_on_page_turn"))
	right_arrow.connect("page_turn", Callable(self, "_on_page_turn"))
	exit_icon.connect("exit_clicked", Callable(self, "_on_exit_clicked"))
	
	left_arrow.set_arrow_direction("left")
	right_arrow.set_arrow_direction("right")
	left_arrow.hide()
	
	current_page_idx = 0
	page_display.texture = pages[current_page_idx]
	max_page_idx = len(pages) - 1


func _on_page_turn(direction):
	
	if direction == "left":
		current_page_idx -= 1
	else:
		current_page_idx += 1
		
	# display new page texture and ui icons
	page_display.texture = pages[current_page_idx]
	_update_arrow_icons()
	
	
# hide arrow if there is no more pages on that direction
func _update_arrow_icons():
	
	# check left
	if current_page_idx == 0:
		left_arrow.hide()
	else:
		left_arrow.show()	
		
	# check right
	if current_page_idx == max_page_idx:
		right_arrow.hide()
	else:
		right_arrow.show()
		

func _on_exit_clicked():
	hide()
