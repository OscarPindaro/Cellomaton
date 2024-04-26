extends Statistic
class_name IntegerStat

@export var value: int 
@export var MIN_VALUE: int = 0
@export var MAX_VALUE: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func increment(increment_value: int):
	# if there is  a max value, clamp it
	var old_value = value
	value += increment_value
	if MAX_VALUE != null and value > MAX_VALUE:
		value= MAX_VALUE
	signal_change(old_value, value)

func decrement(decrement_value: int):
	var old_value = value
	value -= decrement_value
	if MIN_VALUE != null and value < MIN_VALUE:
		value = MIN_VALUE
	signal_change(old_value, value)

func signal_change(old_value: int, new_value: int):
	if old_value == new_value:
		statistic_changed.emit(old_value, new_value)

