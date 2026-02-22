extends Node3D

## components
@onready var open_col_shape := $DoorStaticBody/Open
@onready var closed_col_shape := $DoorStaticBody/Closed
@onready var animation_player := $DoorStaticBody/AnimationPlayer
@onready var door_delay_timer := $DoorOpenDelay

var playerInRadius : bool = false
var doorDelay : bool = false
var doorSpriteOpen : bool = false

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if doorDelay :
		return
	
	if playerInRadius and Input.is_action_just_pressed("interact"):
	
		if doorSpriteOpen :
			GlSoundManager.emit_signal('door_closed')
			animation_player.play("CloseFoward")
			close_door_col_shape()
		if not doorSpriteOpen :
			GlSoundManager.emit_signal('door_opened')
			animation_player.play("OpenFoward")
			open_door_col_shape()
		
		doorSpriteOpen = !doorSpriteOpen
		doorDelay = true
		door_delay_timer.start()
	
		
func open_door_col_shape():
	await animation_player.animation_finished
	closed_col_shape.disabled = true
	open_col_shape.disabled = false

func close_door_col_shape():
	await animation_player.animation_finished
	closed_col_shape.disabled = false
	open_col_shape.disabled = true


func _on_open_door_body_entered(body: Node3D) -> void:
	if body.is_in_group('player') :
		playerInRadius = true


func _on_open_door_body_exited(body: Node3D) -> void:
	if body.is_in_group('player') :
		playerInRadius = false 
	


func _on_door_open_delay_timeout() -> void:
	doorDelay = false
