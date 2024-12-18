extends Control


signal target_clicked()

@onready var click_target = $ClickTarget
@onready var map_texture = $MapTexture
@onready var audio = $Audio
@onready var highlight = $Highlight

var ACTIVATION_SOUND = preload("res://Audios/globe_activation.wav")
var UNLOCK_SOUND = preload("res://Audios/globe_unlock.wav")

var INACTIVE_MAP = preload("res://Arts/world_map_inactive.png")
var ACTIVE_MAP = preload("res://Arts/world_map_activated.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	click_target.connect("gui_input", Callable(self, "_on_target_gui_input"))
	click_target.hide()
	
	highlight.connect("animation_finished", Callable(self, "_on_highlight_finished"))
	highlight.hide()
	
	map_texture.texture = INACTIVE_MAP
	

func _on_target_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# play unlock sound
		audio.stream = UNLOCK_SOUND 
		audio.play()
		highlight.show()
		highlight.play("default") # animation finish will trigger next action


func _on_highlight_finished():
	emit_signal("target_clicked")
	

func activate_map():
	# play activation sound
	audio.stream = ACTIVATION_SOUND 
	audio.play()
	# show active map
	map_texture.texture = ACTIVE_MAP
	click_target.show()
