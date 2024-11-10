extends Control


signal food_container_clicked()

@onready var sprite = $Sprite2D

var before_texture = load("res://Arts/cat_food_refill_before.png")
var after_texture = load("res://Arts/cat_food_refill_after.png")

var has_viewed = false

func _ready():
	connect("gui_input", Callable(self, "_on_gui_input"))
	sprite.texture = before_texture


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("food_container_clicked")
		print("clicked container")


func pour_food():
	sprite.texture = after_texture
