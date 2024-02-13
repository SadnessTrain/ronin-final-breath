extends Node

#progress increases by like 5% when succeeded skill check, then roll it to see if stat up
var baseIncrease : float = 5
var rng = RandomNumberGenerator.new()

#1% always possible
var statProgress = {
	LivingEntity.Stat.DEXTERITY : 1,
	LivingEntity.Stat.KNOWLEDGE : 1,
	LivingEntity.Stat.PERCEPTION : 1,
	LivingEntity.Stat.CHARISMA : 1,
	LivingEntity.Stat.WILLPOWER : 1
}

func SuccessfulCheck(entity:LivingEntity, stat:LivingEntity.Stat):
	#check passive effects here
	statProgress[stat] += baseIncrease

	if rng.randi_range(1,100) < statProgress[stat]:
		print("[DEBUG]: You got more proficient in " + LivingEntity.Stat.keys()[stat])
		entity.stats[stat] += 1
		statProgress[stat] = 1
