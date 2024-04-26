@tool
extends Area2D
class_name NeedArea2D
# var needs: Array[Need] = []
var needs: Array= []


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		pass
	elif not Engine.is_editor_hint():
		pass

	var needs = find_children("*", "Need") as Array[Need]
	print(needs)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_configuration_warnings():
	var warnings = []

	if len(needs) == 0:
		warnings.append("Please add a 'Need' node under this need area, otherwise this node will not be able to broadcast the need that it solves.")

	# Returning an empty array means "no warning".
	return warnings