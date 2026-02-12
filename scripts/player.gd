extends CharacterBody3D

## export vars
@export var mouse_sensitivity_x := 0.007
@export var mouse_sensitivity_y := 0.002

## components
@onready var camera_pivot := $CameraPivot

const SPEED := 5.0

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		# yaw (player)
		rotation.y -= event.relative.x * mouse_sensitivity_x

		# pitch (camera pivot)
		camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity_y
		camera_pivot.rotation.x = clamp(
			camera_pivot.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)
