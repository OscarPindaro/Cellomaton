@tool
extends Area2D
class_name NeedArea2D
# var needs: Array[Need] = []
var needs: Array= []


# Called when the node enters the scene tree for the first time.
func _ready():
	self.child_entered_tree.connect(_on_children_entered)
	self.child_exiting_tree.connect(_on_children_exited)
	if Engine.is_editor_hint():
		pass
	elif not Engine.is_editor_hint():
		pass
	set_needs()
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_configuration_warnings():
	var warnings = []
	# print(len(needs))
	if len(needs) == 0:
		warnings.append("Please add a 'Need' node under this need area, otherwise this node will not be able to broadcast the need that it solves.")

	# Returning an empty array means "no warning".
	return warnings

func set_needs():
	print("Before", needs)
	var found_needs = find_children("*", "Need") as Array[Need]
	for need in found_needs:
		if need not in needs:
			needs.append(need)
	print(needs)

func _on_children_entered(node: Node):
	if node is Need:
		needs.append(node)
	set_needs()
	update_configuration_warnings()

func _on_children_exited(node: Node):
	if node in needs:
		needs.erase(node)
	# set_needs()
	update_configuration_warnings()