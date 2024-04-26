@tool
extends Node
class_name NeedManager


# @export var need_path: NodePath
# @export_node_path("Need") var need_path
# @onready var need_node: Need = get_node(need_path)
@export var need_node: Need = null:
	set(new_need):
		if new_need != need_node:
			need_node = new_need
			update_configuration_warnings()

@export var stat_node: Statistic = null:
	set(new_stat):
		if new_stat != stat_node:
			stat_node = new_stat
			update_configuration_warnings()

# @export var stat_path: NodePath
# var stat_node: Statistic = get_node(need_path)



# Called when the node enters the scene tree for the first time.
func _ready():
	assert(stat_node != null)
	# connect only while playing
	if not Engine.is_editor_hint():
		stat_node.statistic_changed.connect(_on_statistic_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_statistic_change(old_value, new_value):
	need_node.value = new_value

func _get_configuration_warnings():
	var warnings = []
	if need_node == null:
		warnings.append("No 'Need' selected for this manager")
	if stat_node == null:
		warnings.append("No 'Statistic' selected for this manager")

	# Returning an empty array means "no warning".
	return warnings