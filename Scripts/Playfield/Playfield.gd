extends Node
class_name Playfield

var tileScene = preload("res://Scenes/Playfield/Tile.tscn")
var wallEntityScene = preload("res://Scenes/Entities/Obstacle/WallEntity.tscn")

var cellSize: Vector2i = Vector2i(18, 18)
var size: Vector2i = Vector2i(10, 6)

var tiles = {}

func _ready(): 
	for x in range(0, size.x):
		for y in range(0, size.y):
			var pos = Vector2i(x, y)
			var tile: Tile = tileScene.instantiate()
			tile.createTile(x + y, pos, self)
			
			if Utils.randomInt(0, 10) >= 9:
				CreateWall(tile)
			
			add_child(tile)
			
			tiles[pos] = tile

func CreateWall(tile: Tile):
	var wall: Entity = wallEntityScene.instantiate()
	tile.appendEntity(wall)
	
func GetTileByPos(pos: Vector2) -> Tile:
	if !tiles.has(pos):
		printerr("Cannot find tile on provided position")
		return null
		
	return tiles[pos]

func GetAllEmptyTiles() -> Array[Tile]:
	var toReturn: Array[Tile] = []
	for key in tiles:
		var tile: Tile = tiles[key]

		if tile.entities.size() <= 0:
			toReturn.append(tile)
		
	return toReturn

func SetPossibleTilesHighlightingByTilesPos(tilesPos: Array[Vector2i], isActive: bool):
	for tilePos in tilesPos:
		var tile = GetTileByPos(tilePos)
		if !tile:
			return
			
		tile.enableTileHighlighting() if isActive else tile.disableTileHighlighting()

func SetPossibleTilesHighlightingByTilesObj(tiles: Array[Tile], isActive: bool):
	for tile in tiles:
		tile.enableTileHighlighting() if isActive else tile.disableTileHighlighting()
		
func DisableAllTilesHighlighting():
	for key in tiles:
		var tile: Tile = tiles[key]
		tile.disableTileHighlighting()
