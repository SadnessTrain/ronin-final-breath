extends Node
class_name Effect

var effectName : String
var target : LivingEntity
var triggerSetting : TriggerSetting
var tags : Array[Tags] = []

func effect(arg):
	pass

enum TriggerSetting{
	COMBAT,
	WORLD,
	EVERYWHERE
}

enum Tags{
	START_OF_COMBAT,
	START_OF_ROUND,
	BEFORE_DECLARE_ATTACK,
	BEFORE_RECIEVE_ATTACK,
	BEFORE_DECLARE_DEFENCE,
	BEFORE_FAIL_DEFENCE,
	BEFORE_SUCCEED_DEFENCE,
	END_OF_ROUND,
	END_OF_COMBAT
}
