extends Node
class_name Attack

var type : AttackType
var priority : Priority = Priority.STANDARD
var damage : int
var effect : Callable

enum AttackType{
	HORIZONTAL,
	VERTICAL,
	THRUST
}

enum Priority{
	LOW,
	STANDARD,
	HIGH
}
