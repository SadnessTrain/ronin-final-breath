extends Node
class_name Entity

var maxReflex : int
var reflex : int

var dexterity : int
var knowledge : int
var perception : int
var charisma : int
var willpower : int

#progress increases by like 5% when succeeded skill check, then roll it to see if stat up
var dexterityProgress : float = 0
var knowledgeProgress : float = 0
var perceptionProgress : float = 0
var charismaProgress : float = 0
var willpowerProgress : float = 0

func _ready():
	GlobalSignals.AttackSignal.connect(RecieveAttack)

func Attack(target:Vector2, attack:Attack):
	pass

func RecieveAttack():
	pass
