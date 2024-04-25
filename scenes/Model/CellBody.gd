@tool
extends CharacterBody2D

@export var starting_stats: BaseStats

var health: float
var energy: float

@onready
var random_movement: RandomMovement = RandomMovement.new()
@onready
var target_movement: FollowMovement = FollowMovement.new()

@onready
var current_movement: Movement = random_movement

@onready var vision_cone: Area2D = $Vision

var possible_targets: Array[NeedArea2D] = []
var target: NeedArea2D = null

@export var control_step: float = 1.
var control_step_timer: Timer

func _ready():
	if Engine.is_editor_hint():
		pass
	else:
		random_movement.name = "RandomMovement"
		target_movement.name = "FollowMovement"
		health = starting_stats.health
		energy = starting_stats.energy
		_create_timer()
		# connect the timer
		control_step_timer.timeout.connect(on_control_step_timeout)

		vision_cone.area_entered.connect(on_vision_cone_entered)
		vision_cone.area_exited.connect(on_vision_cone_exited)

		# let's start with a random movement
		add_child(current_movement)
	# nb, if changed right now you need to reload

	self.collision_layer = starting_stats.collision_layer
	self.collision_mask = starting_stats.collision_mask





func _create_timer():
	control_step_timer = Timer.new()
	add_child(control_step_timer)
	control_step_timer.wait_time = control_step
	control_step_timer.one_shot = false
	control_step_timer.autostart = true
	control_step_timer.start()



func _process(delta):
	pass


func on_vision_cone_entered(area: Area2D):
	if Engine.is_editor_hint():
		pass
	else:
		if is_instance_of(area, NeedArea2D):
			possible_targets.append(area)

func on_vision_cone_exited(area: Area2D):
	if Engine.is_editor_hint():
		pass
	else:
		if is_instance_of(area, NeedArea2D):
			possible_targets.erase(area)

func on_control_step_timeout():
	if Engine.is_editor_hint():
		pass
	else:
		# no targets, behave randomly
		if len(possible_targets) == 0:
			target = null
			remove_child(current_movement)
			current_movement = random_movement
			add_child(current_movement)
			
		else:
			target = possible_targets.pick_random()
			remove_child(current_movement)
			current_movement = target_movement
			target_movement.target = target

			add_child(current_movement)
		print("Current movement: ", current_movement)

