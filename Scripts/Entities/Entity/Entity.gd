extends Node
class_name Entity

#DO NOT ACCESS/CHANGE/INTERACT WITH
static var counterID : int = -1

var entityID : int

var maxReflex : int
var reflex : int

#for breaking fences/doors?
func _ready():
	GlobalSignals.AttackSignal.connect(RecieveAttack)

func RecieveAttack():
	pass

func _init():
	counterID += 1
	entityID = counterID
