extends Movement
class_name MouseFollowMovement


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

func _process(_delta):
	var mouse_position = body.get_global_mouse_position()
	var direction : Vector2 = (mouse_position - body.position).normalized()
	body.velocity = direction*linear_velocity
	body.move_and_slide()
	if look_at:
		body.look_at(mouse_position)
