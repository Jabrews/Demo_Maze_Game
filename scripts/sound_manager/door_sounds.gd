extends Node

# sounds 
@onready var s_door_open : AudioStreamPlayer3D = $DoorOpen
@onready var s_door_close : AudioStreamPlayer3D = $DoorClose


func _ready() -> void:
	GlSoundManager.connect("door_opened", _on_door_opened)
	GlSoundManager.connect("door_closed", _on_door_closed)
	
func _on_door_opened() :
	print('open')
	s_door_open.play()

func _on_door_closed() :
	s_door_close.play()
