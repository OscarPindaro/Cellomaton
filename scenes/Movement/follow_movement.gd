extends Movement
class_name FollowMovement

@export var target: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

func _process(_delta):
	if target != null:
		var direction : Vector2 = (target.global_position - body.position).normalized()
		body.velocity = direction*linear_velocity
		body.move_and_slide()
		if look_at:
			body.look_at(target.position)
