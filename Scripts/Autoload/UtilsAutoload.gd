extends Node

func randomInt(min: int, max: int) -> int:
	var rng = RandomNumberGenerator.new()
	var randomNumber = rng.randf_range(min, max)
	return randomNumber

func FilterNulls(element):
	return element != null

func CoordinatesBetween(startPosition: Vector2i, endPosition: Vector2i) -> Array[Vector2i]:
	var x1: int = startPosition.x
	var y1: int = startPosition.y
	var x2: int = endPosition.x
	var y2: int = endPosition.y

	var coordinates: Array[Vector2i] = []

	if x1 == x2 && y1 == y2:
		return [Vector2i(x1, y1)]

	var dx: int = x2 - x1
	var dy: int = y2 - y1

	var stepX: int
	var stepY: int

	if abs(dx) >= abs(dy):
		stepX = 1 if dx > 0 else -1
		stepY = dy / abs(dx)
	else:
		stepX = dx / abs(dy)
		stepY = 1 if dy > 0 else -1

	var x: int = x1 + stepX
	var y: int = y1 + stepY

	while round(x) != x2 || round(y) != y2:
		coordinates.append(Vector2i(round(x), round(y)))
		x += stepX
		y += stepY

	return coordinates
