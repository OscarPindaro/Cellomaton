extends Node

@export var body: CharacterBody2D
# TODO this is very temporary!!
@export var energy: FloatStat 
@export var exploration: FloatStat


# how often the controller changes action
@export var control_step: float = 1
var control_step_timer: Timer

# need vision
@export var need_vision_cone: Area2D

# uses randomness to explor and follow got looking at objects
var random_movement: RandomMovement 
var target_movement: FollowMovement
var current_movement: Movement

# targets
var possible_targets: Array[NeedArea2D] = []
var target: NeedArea2D = null

# curves
@export var energy_curve: Curve
@export var exploration_curve: Curve

# using a simple boolean instead of state machine
var exploring: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(body != null, "Body can't be null")
	assert(energy != null, "Energy stat can't be null")
	assert(need_vision_cone != null, "Vision cone for needs can't be null. I need to connect it's methods to detect need areas")

	# movement
	random_movement = RandomMovement.new()
	random_movement.name = "RandomMovement"
	random_movement.control_step = 0.2
	random_movement.body = body
	random_movement.look_at = true

	target_movement = FollowMovement.new()
	target_movement.name = "TargetMovement"
	current_movement = random_movement
	
	# control step
	_create_timer()
	control_step_timer.timeout.connect(act)

	# need vision
	need_vision_cone.area_entered.connect(on_vision_cone_entered)
	need_vision_cone.area_exited.connect(on_vision_cone_exited)

func _create_timer():
	control_step_timer = Timer.new()
	add_child(control_step_timer)
	control_step_timer.wait_time = control_step
	control_step_timer.one_shot = false
	control_step_timer.autostart = true
	control_step_timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# MOVEMENT IS NOT WORKING BECAUSE IT'S NOT IN THE TREE
	current_movement.move(delta, body)
	if exploring:
		exploration.increment(0.005)
		energy.decrement(0.0002)
	else:
		exploration.decrement(0.005)
		energy.increment(0.02)
	# print(body.velocity)


func act():
	# no targets, behave randomly
	print("Energy:", self.energy.value)
	print("Exploration:", self.exploration.value)
	print("Exploring:", exploring)
	print("Speed:", body.velocity)
	if len(possible_targets) == 0:
		exploring = true
		target = null
		current_movement = random_movement
	else:
		target = possible_targets.pick_random()
		# super hardcode, maybe is better to have justa  dictionary with values?
		var energy_need_value: float = target.get_needs()[0]["value"]
		var energy_mult = energy_curve.sample(self.energy.value/self.energy.MAX_VALUE)

		var energy_utility = energy_need_value*energy_mult
		var exploration_utility = 1. * exploration_curve.sample(self.exploration.value/self.exploration.MAX_VALUE)
		# print("Energy Utiliy:", energy_utility)
		# print("Explo Utiliy:", exploration_utility)
		if energy_utility > exploration_utility:
			exploring = false
			current_movement = target_movement
			target_movement.target = target
		else:
			exploring = true
			current_movement = random_movement
	print("Current movement: ", current_movement)

func on_vision_cone_entered(area: Area2D):
	if is_instance_of(area, NeedArea2D):
		possible_targets.append(area)

func on_vision_cone_exited(area: Area2D):
	if is_instance_of(area, NeedArea2D):
		possible_targets.erase(area)
