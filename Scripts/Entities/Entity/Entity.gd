extends Node
class_name Entity

var maxReflex : int
var reflex : int

#for breaking fences/doors?
func _ready():
	GlobalSignals.AttackSignal.connect(RecieveAttack)

func RecieveAttack():
	pass
