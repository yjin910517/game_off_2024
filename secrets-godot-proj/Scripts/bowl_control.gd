extends Control


signal food_bowl_clicked()

@onready var sprite = $Sprite2D
@onready var audio = $Audio
@onready var hover = $HoverRect

var bowl_filled_texture = load("res://Arts/cat_bowl_filled.png")
var bowl_empty_texture = load("res://Arts/cat_bowl_empty.png")

var has_viewed = false


func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))
	sprite.texture = bowl_empty_texture


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("food_bowl_clicked")
		

func add_food():
	hover.hide()
	# play sound before show full bowl
	audio.play()
	await get_tree().create_timer(0.5).timeout
	sprite.texture = bowl_filled_texture
