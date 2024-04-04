extends Node
class_name Movement

@export var body: CharacterBody2D = null 
@export var linear_velocity = 200
@export var look_at: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	if body == null:
		assert(typeof(get_parent()==CharacterBody2D), "If body is null, the parent should be a CharacterBody so it works")
		body = get_parent()

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
