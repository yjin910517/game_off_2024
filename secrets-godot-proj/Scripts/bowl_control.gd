extends Control


signal food_bowl_clicked()

@onready var sprite = $Sprite2D
@onready var audio = $Audio

var bowl_filled_texture = load("res://Arts/cat_bowl_filled.png")
var bowl_empty_texture = load("res://Arts/cat_bowl_empty.png")

var has_viewed = false


func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))
	sprite.texture = bowl_empty_texture


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("food_bowl_clicked")
		print("clicked food bowl")


func add_food():
	sprite.texture = bowl_filled_texture
	# To do: play sound effect 
