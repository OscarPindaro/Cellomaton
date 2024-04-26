extends Node
class_name NeedManager


# @export var need_path: NodePath
@export_node_path("Need") var need_path
@onready var need_node: Need = get_node(need_path)

@export_node_path("Statistic") var stat_path
@onready var stat_node: Statistic = get_node(stat_path)

# @export var stat_path: NodePath
# var stat_node: Statistic = get_node(need_path)



# Called when the node enters the scene tree for the first time.
func _ready():
	stat_node.statistic_changed.connect(_on_statistic_change)
	# need_node = get_node(need_path)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_statistic_change(old_value, new_value):
	need_node.value = new_value
