extends Control

@onready var timer = $Timer
@onready var bgm = $BGM
@onready var camera = $Camera

@onready var line_1 = $Monologues/Line1
@onready var line_2 = $Monologues/Line2
@onready var line_3 = $Monologues/Line3
@onready var line_4 = $Monologues/Line4
@onready var line_5 = $Monologues/Line5

var line_list
var wait_list = [3, 7, 6, 6, 6]
var current_line_idx = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	line_list = [line_1, line_2, line_3, line_4, line_5]
	for line in line_list:
		line.hide()
	

func start_scene():
	timer.wait_time = 2
	timer.one_shot = true
	timer.start()
	
	bgm.play()
	show()
	

func _on_timer_timeout():
	
	# move camera 
	if current_line_idx == -1:
		camera.text_to_credit()
		
	else:
		var timer_time
		if current_line_idx < len(line_list):
			# show a new line
			line_list[current_line_idx].fade_in()
			timer_time = wait_list[current_line_idx]
			current_line_idx += 1
		
		# update idx to trigger camera move after next timer stop	
		if current_line_idx == len(line_list):
			current_line_idx = -1
			timer_time = 8
		
		timer.wait_time = timer_time
		timer.start()
