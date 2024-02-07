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

func DeclareAttack(target:Vector2, type:Attack.AttackType):
	var attack = Attack.new(type, equippedWeapon.attacks[type])

func RecieveAttack():
	pass

func SkillCheck():
	pass
