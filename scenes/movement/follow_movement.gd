extends Movement
class_name FollowMovement

@export var target: Marker2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	assert(target != null, "Target of the Follow Movement should not be Null")

func _process(_delta):
	var direction : Vector2 = (target.global_position - body.position).normalized()
	body.velocity = direction*linear_velocity
	body.move_and_slide()
	if look_at:
		body.look_at(target.position)
