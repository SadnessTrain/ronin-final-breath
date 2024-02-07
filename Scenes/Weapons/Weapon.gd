extends Node
class_name Weapon

var weaponName : String

#[type:Attack.AttackType, baseDamage:int]
var attacks = {}

#[type:Attack.AttackType]
var defences = []

var weight : int

var range : int
