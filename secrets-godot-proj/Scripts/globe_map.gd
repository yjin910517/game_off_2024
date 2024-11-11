extends Control


signal target_clicked()

@onready var click_target = $ClickTarget
@onready var map_texture = $MapTexture


var INACTIVE_MAP = preload("res://Arts/world_map_inactive.png")
var ACTIVE_MAP = preload("res://Arts/world_map_activated.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	click_target.connect("gui_input", Callable(self, "_on_target_gui_input"))
	click_target.hide()
	
	map_texture.texture = INACTIVE_MAP
	

func _on_target_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("target_clicked")


func activate_map():
	map_texture.texture = ACTIVE_MAP
	click_target.show()
