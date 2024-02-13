extends Node
class_name Action

var action : Actions

var sourceEntity : Entity
var targetEntity : Array[Entity]
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
		Actions.ATTACK:
			arg = $EffectStack.ExecuteEffects(Effect.Tags.BEFORE_EXECUTE_ATTACK,arg)
			GlobalSignals.AttackSignal.emit(sourceEntity,targetEntity,arg)

func _init(action:Actions, sourceEntity:Entity, targetEntity:Array[Entity], arg):
	self.action = action
	self.sourceEntity = sourceEntity
	self.targetEntity = targetEntity
	self.arg = arg
