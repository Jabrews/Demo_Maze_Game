extends Node

## this component is responsible for only visuals

@onready var cam_pivot : Node3D = $CameraPivot
@onready var audio_vent_crawl : AudioStreamPlayer3D = $CameraPivot/Camera3D/VentCrawl
@onready var camera : Camera3D = $CameraPivot/Camera3D


var vent_loop_active = false
var starting_cam_pos : Vector3
var vent_tween : Tween

# bobble settings
var bobble_speed := 8.0
var bobble_amount := 0.5
var bobble_time := 0.0

func _ready() -> void:
	GlSignalBus.connect('vent_loop_init', _vent_loop_start)
	starting_cam_pos = cam_pivot.position
	
func _process(delta: float) -> void:
	if vent_loop_active:
		## bobble
		cam_pivot_bobble(delta)

func cam_pivot_bobble(delta: float) -> void:
	bobble_time += delta * bobble_speed
	var offset = sin(bobble_time) * bobble_amount
	# apply bobble relative to current upward motion
	cam_pivot.position.x += offset * delta

func _vent_loop_start(_is_downward : bool) :
	vent_loop_active = true
	camera.current = true
	audio_vent_crawl.play()
	
	## movement upward
	vent_tween = create_tween()
	vent_tween.tween_property(cam_pivot, "position:y", starting_cam_pos.y + 15, 3.2)
	vent_tween.tween_callback(_vent_loop_end)


func _vent_loop_end() :
	vent_loop_active = false
	camera.current = false 
	audio_vent_crawl.stop()
	# reset cam pos to start
	cam_pivot.position = starting_cam_pos
	GlSignalBus.emit_signal('vent_loop_end')
