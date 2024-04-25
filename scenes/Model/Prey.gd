extends Node2D

@export var MAX_HEALTH: float = 100.
@export var MAX_ENERGY: float = 100.

var health: float 
var energy: float




# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	energy = MAX_ENERGY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
