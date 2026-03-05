extends Node

### NOTE ###
# try to keep this minimal
# i perfer signals in the rel. component

## player / stamina bar
signal stamina_bar_depleted_status(toggleValue : bool)
signal player_started_running
signal player_stopped_running

## vent / floor_light_area
signal vent_floor_travel(vent_floor : int , direction_down : bool) 
signal light_area_travel(floor : int)
signal vent_loop_init(vent_downward : bool)
signal vent_loop_end
