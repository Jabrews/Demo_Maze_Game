extends Node

@export var ray : RayCast3D

func _process(delta: float) -> void:
	
	# see if poking vent,
	if ray.is_colliding():
		var collider = ray.get_collider()
		
		# if poking vent 
		if collider.is_in_group("vents") :
			
			# and presses interact
			if Input.is_action_just_pressed("interact")	 :
				# activate vent_loading
				GlSignalBus.emit_signal('vent_loop_init', collider.vent_downward)
				GlSignalBus.emit_signal('vent_floor_travel', collider.vent_floor, collider.vent_downward)
