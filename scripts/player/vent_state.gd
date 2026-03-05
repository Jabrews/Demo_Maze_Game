extends Node

@export var player : CharacterBody3D
@export var camera : Camera3D

const FLASHLIGHT_PATH := "CameraPivot/FlashLightPivot"


func _ready() -> void:
	GlSignalBus.connect("vent_loop_init", _handle_vent_loop_start)
	GlSignalBus.connect("vent_loop_end", _handle_vent_loop_end)


func _handle_vent_loop_start(is_downward : bool) -> void:
	camera.current = false
	player.visible = false

	if is_downward:
		player.global_position.y -= 10
	else:
		player.global_position.y += 20

	await _after_vent_teleport()


func _handle_vent_loop_end() -> void:
	camera.current = true
	player.visible = true


func _after_vent_teleport() -> void:
	player.velocity = Vector3.ZERO
	player.move_and_slide()

	await _rebuild_flashlight()


func _rebuild_flashlight() -> void:
	var old_flashlight = player.get_node_or_null(FLASHLIGHT_PATH)
	if not old_flashlight:
		return

	# duplicate BEFORE deleting
	var new_flashlight = old_flashlight.duplicate()

	old_flashlight.queue_free()

	await get_tree().process_frame

	player.get_node("CameraPivot").add_child(new_flashlight)
