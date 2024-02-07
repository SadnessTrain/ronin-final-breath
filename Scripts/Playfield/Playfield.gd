extends Node
class_name Playfield

var tileScene = preload("res://Scenes/Playfield/Tile.tscn")

var size: Vector2i = Vector2i(5, 5)

var tiles = {}

func _ready(): 
	for x in range(0, size.x):
		for y in range(0, size.y):
			var pos = Vector2i(x, y)
			var tile: Tile = tileScene.instantiate()
			tile.createTile(x + y, pos)
			add_child(tile)
			
			tiles[pos] = tile
