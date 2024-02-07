extends Node
class_name Attack

var type : AttackType
var priority : Priority = Priority.STANDARD
var damage : int
var effect : Callable

enum AttackType{
	HORIZONTAL,
	OVERHEAD,
	THRUST
}

enum Priority{
	LOW,
	STANDARD,
	HIGH
}

func _init(type:AttackType, damage:int, priority:Priority=Priority.STANDARD, effect:Callable=func():pass):
	pass
