extends Area3D 

@export var enter_floor_num = 0

## this manages floor and vent travel turning on correct lights


func _ready() -> void:
	body_entered.connect(_on_floor_area_body_entered)
	
func _on_floor_area_body_entered(body : Node3D) :
	if body.is_in_group('player') :
		GlSignalBus.emit_signal("light_area_travel", enter_floor_num)
