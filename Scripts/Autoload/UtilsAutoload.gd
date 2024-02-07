extends Node

func randomInt(min: int, max: int) -> int:
	var rng = RandomNumberGenerator.new()
	var randomNumber = rng.randf_range(min, max)
	return randomNumber
