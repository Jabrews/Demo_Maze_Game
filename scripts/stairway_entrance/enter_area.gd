extends Node


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('player') :
		GlSoundManager.emit_signal('player_stairway_status', true)
				
