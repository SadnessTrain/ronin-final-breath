extends Node
class_name Action

var action : Actions
#can be any object (like an attack, or item)
var arg

enum Actions{
	ATTACK,
	DEFENCE,
	ABILITY,
	ITEM,
	SWITCH_WEAPON,
	SWITCH_STYLE,
	MOVE,
	RUN,
	WAIT
}

func Execute():
	match(action):
		ATTACK:
			GlobalSignals.AttackSignal.emit()
	pass
