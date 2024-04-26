extends Area2D
class_name NeedArea2D
# var needs: Array[Need] = []
var needs: Array= []


# Called when the node enters the scene tree for the first time.
func _ready():
	var needs = find_children("*", "Need") as Array[Need]
	# for need in needs:
	# 	need = need as Need
	print(needs)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
