extends Light2D

export (float) var state_dawn_energy = 0.5
export (float) var state_day_energy = 0
export (float) var state_dusk_energy = 0.5
export (float) var state_night_energy = 1

export (float) var state_transition_duration = 1 # In hours

var state
var new_state

var energy_start
var energy_end

var transition_duration

func _ready():
	Global.Moon = self

	energy = 0.0
	transition_duration = Global.DayNight.transition_duration if Global.DayNight else state_transition_duration


func change_state(new_state):
	if state != new_state:
		energy_start = state
		energy_end = new_state

		state = new_state

		$Tween.interpolate_property(self, "energy", energy_start, energy_end, transition_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
		$Tween.start()
