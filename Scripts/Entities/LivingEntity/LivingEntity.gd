extends Entity
class_name LivingEntity

var attackScene = preload("res://Scripts/Entities/LivingEntity/Attack.gd")

enum Stat{
	DEXTERITY,
	KNOWLEDGE,
	PERCEPTION,
	CHARISMA,
	WILLPOWER
}

var stats = {
	Stat.DEXTERITY : 0,
	Stat.KNOWLEDGE : 0,
	Stat.PERCEPTION : 0,
	Stat.CHARISMA : 0,
	Stat.WILLPOWER : 0
}

var reputation : int 

var equippedWeapon : Weapon

func _ready():
	GlobalSignals.AttackSignal.connect(RecieveAttack)

func DeclareAttack(target:Array[Entity], type:Attack.AttackType):
	var attack = Attack.new(type, equippedWeapon.attacks[type])
	attack = $EffectStack.ExecuteEffects(Effect.Tags.AFTER_DECLARE_ATTACK,attack)
	
	var effects = $EffectStack.findEffects([Effect.Tags.BEFORE_DECLARE_ATTACK])
	for effect in effects:
		#(optionally)modifies basic attack and takes its value
		attack = effect.effect(attack)
	
	GlobalSignals.AttackSignal.emit(self,target,attack)
	$Combat.DeclarationQueue.append(Action.new(Action.Actions.ATTACK, self, target, attack))

func RecieveAttack():
	pass

func SkillCheck():
	pass
