extends Node

@onready var s_footsteps_carpet := $FootstepsCarpet
@onready var s_footsteps_stairwell := $FootstepsStairwell
@onready var s_running_carpet := $RunCarpet
@onready var s_running_stairwell := $RunStairwell

@onready var stop_footstep_delay_timer := $StopFootstepDelayTimer

enum MoveState { IDLE, WALK, RUN }

var player_in_stairway : bool = false
var current_state := MoveState.IDLE


func _ready() -> void:
	GlSoundManager.connect("player_walked", _on_player_walked)
	GlSoundManager.connect("player_stopped_walking", _on_player_stopped_walking)
	GlSoundManager.connect("player_running", _on_player_running)
	GlSoundManager.connect("player_stopped_running", _on_player_stopped_running)
	GlSoundManager.connect("player_stairway_status", _handle_stairway_status_change)


func _play_movement(is_running: bool) -> void:
	stop_all_sounds()
	
	if is_running:
		if player_in_stairway:
			s_running_stairwell.play()
		else:
			s_running_carpet.play()
	else:
		if player_in_stairway:
			s_footsteps_stairwell.play()
		else:
			s_footsteps_carpet.play()


func _on_player_walked():
	current_state = MoveState.WALK
	_play_movement(false)


func _on_player_running():
	current_state = MoveState.RUN
	_play_movement(true)


func _on_player_stopped_walking():
	current_state = MoveState.IDLE
	stop_all_sounds()


func _on_player_stopped_running():
	current_state = MoveState.IDLE
	stop_all_sounds()


func _handle_stairway_status_change(toggleValue : bool):
	player_in_stairway = toggleValue
	
	match current_state:
		MoveState.WALK:
			_play_movement(false)
		MoveState.RUN:
			_play_movement(true)


func stop_all_sounds() -> void:
	s_footsteps_carpet.stop()
	s_footsteps_stairwell.stop()
	s_running_carpet.stop()
	s_running_stairwell.stop()
