extends Node
class_name Playfield

var testingMovableEntityScene = preload("res://Scenes/Entities/MovableEntity.tscn") #TODO remove
var tileScene = preload("res://Scenes/Playfield/Tile.tscn")
var treeEntityScene = preload("res://Scenes/Entities/Obstacle/TreeEntity.tscn")
var waterObstacleScene = preload("res://Scenes/Entities/Obstacle/WaterObstacleEntity.tscn")
var bridgeScene = preload("res://Scenes/Entities/Obstacle/BridgeEntity.tscn")

@export var config: PlayfieldData

var tiles = {}

var player: Entity

var noise = FastNoiseLite.new()

func _ready(): 
	noise.seed = Utils.randomInt(-2000000, 20000000)
	noise.frequency = 0.004

	var testPlayer = testingMovableEntityScene.instantiate()	#TODO remove
	
	for x in range(0, config.size.x):
		for y in range(0, config.size.y):
			var pos = Vector2i(x, y)
			var tile: Tile = tileScene.instantiate()
			
			tile.createTile(x + y, pos, self)
			
			add_child(tile)
			
			tiles[pos] = tile

	GenerateRiver()
	GenerateRandomObstacles()

	tiles[Vector2i(0,0)].appendEntity(testPlayer)
	player = testPlayer

func GetAllWaterTilesPos(startPos: Vector2i, endPos: Vector2i, width: int) -> Array:
	var positions = []

	var deltaX = abs(endPos.x - startPos.x)
	var deltaY = abs(endPos.y - startPos.y)

	var xIncrement = 1 if startPos.x < endPos.x else -1
	var yIncrement = 1 if startPos.y < endPos.y else -1

	var error = deltaX - deltaY

	var currentX = startPos.x
	var currentY = startPos.y

	while currentX != endPos.x or currentY != (endPos.y + 1):
		for i in range(-width / 2, width / 2 + 1):
			positions.append(Vector2i(currentX + i, currentY))

		var doubleError = 2 * error

		if doubleError > -deltaY:
			error -= deltaY
			currentX += xIncrement

		if doubleError < deltaX:
			error += deltaX
			currentY += yIncrement

	return positions

func GenerateRiver():
	var hasRiver = Utils.randomInt(0, 100) <= config.riverChance
	
	if !hasRiver:
		return
		
	var randomTopPosition = Vector2i(Utils.randomInt(config.riverMargin, config.size.x - (config.riverMargin + 1)), 0)	
	var randomBottomPosition = Vector2i(Utils.randomInt(config.riverMargin, config.size.x - (config.riverMargin + 1)), config.size.y - 1)
	
	for waterTilePos in GetAllWaterTilesPos(randomTopPosition, randomBottomPosition, config.riverWidth):
		tiles[waterTilePos].SetType("WATER")
		
	GenerateBridge()

func GetFirstRiverTileInRow(row: int) -> int:
	var lastType: String = ""
	for i in range(0, config.size.x):
		var tile: Tile = GetTileByPos(Vector2(i, row))
		
		if lastType != "WATER" && tile.type == "WATER":
			return i - 1
			
	return -1
	
func GetLastRiverTileInRow(firstRiverTile: int) -> int:
	return firstRiverTile + 2 + config.riverWidth

func GenerateBridge():
	var yMiddle: int = floor(config.size.y / 2)
	var xMin: int = GetFirstRiverTileInRow(yMiddle)
	var xMax: int = GetLastRiverTileInRow(xMin)
	
	for x in range(xMin, xMax):
		for y in range(yMiddle - 1, yMiddle + 2):
			var tile: Tile = GetTileByPos(Vector2(x, y))
			var bridgeElement: BridgeEntity = bridgeScene.instantiate()
			var dir = Vector2(0, 0)
			if x == xMin:
				dir.x = -1
			elif x == xMax - 1:
				dir.x = 1
				
			if y == yMiddle - 1:
				dir.y = -1
			elif  y == yMiddle + 2 - 1:
				dir.y = 1
			
			bridgeElement.SetDirection(dir)
			tile.appendEntity(bridgeElement)
			
func GenerateRandomObstacles():
	var obstacleCount: int = Utils.randomInt(config.minObstacles, config.maxObstacles)

	for i in range(0, obstacleCount):
		var possibleTiles: Array[Tile] = GetAllTilesWithEmptyNeighbors()
		print(possibleTiles.size())
	
		if possibleTiles.size() == 0:
			return
		
		var randomIndex: int = Utils.randomInt(0, possibleTiles.size())
		var tile: Tile = possibleTiles[randomIndex]
		
		if tile.type == "WATER":
			CreateEntity(tile, waterObstacleScene)
		else:
			CreateEntity(tile, treeEntityScene)

func GetAllTilesWithEmptyNeighbors() -> Array[Tile]:
	var toReturn: Array[Tile] = []
	
	for x in range(0, config.size.x):
		for y in range(0, config.size.y):
			var tile: Tile = GetTileByPos(Vector2(x, y))
			if !CheckIfTileHasNeighborThatIsNotEmpty(tile):
				toReturn.push_back(tile)

	return toReturn

func CheckIfTileHasNeighborThatIsNotEmpty(tile: Tile) -> bool:
	for x in range(tile.pos.x - 1, tile.pos.x + 2):
		for y in range(tile.pos.y - 1, tile.pos.y + 2):
			var tileToCheck: Tile = GetTileByPos(Vector2i(x, y))
			if tileToCheck && tileToCheck.entities.size() > 0:
				return true
			
	return false

func CreateEntity(tile: Tile, entity: PackedScene):
	var newEntity: Entity = entity.instantiate()
	tile.appendEntity(newEntity)
	
func GetTileByPos(pos: Vector2i) -> Tile:
	if !tiles.has(pos):
		printerr("Cannot find tile on provided position")
		return null
		
	return tiles[pos]

func GetArrayOfTilesByPos(tilesPos: Array[Vector2i]) -> Array[Tile]:
	var toReturn: Array[Tile] = []
	for tilePos in tilesPos:
		var tile = GetTileByPos(tilePos)
		if !tile:
			break
		toReturn.append(tile)
		
	return toReturn

func GetTileWithPlayer() -> Tile:
	for key in tiles:
		var tile: Tile = tiles[key]

		if CheckIfTileHasPlayer(tile):
			return tile
			
	printerr("Cannot find player")
	return null

func CheckIfTileHasPlayer(tile: Tile) -> bool:
	for entity in tile.entities:
		if entity is MovableEntity: #TODO change to player entity
			return true
	
	return false

func GetAllEmptyTiles() -> Array[Tile]:
	var toReturn: Array[Tile] = []
	for key in tiles:
		var tile: Tile = tiles[key]

		if tile.entities.size() <= 0:
			toReturn.append(tile)
		
	return toReturn
	
func GetAllPossibleTilesToMove(currentPos: Vector2i, maxDistance: int) -> Array[Tile]:
	var toReturn: Array[Tile] = []
	for i in range(1, maxDistance + 1):
		for tilePos in [Vector2i(i, 0), Vector2i(-i, 0), Vector2i(0, i), Vector2i(0, -i)]:
			var tile: Tile = GetTileByPos(currentPos + tilePos)
			if tile != null && CheckIfTileIsPossibleToMoveOn(currentPos, tile):
				toReturn.append(tile)
		
	return toReturn

func CheckIfTileHasWall(tile: Tile) -> bool:
	for entity in tile.entities:
		if entity is WallEntity:
			return true
	
	return false

func CheckIfTileIsPossibleToMoveOn(currentPos: Vector2i, tile: Tile) -> bool:
	var allTilesBetween2Tiles = GetArrayOfTilesByPos(Utils.CoordinatesBetween(currentPos, tile.pos))

	if CheckIfTileHasWall(tile) || allTilesBetween2Tiles.filter(CheckIfTileHasWall).size() > 0:
		return false
	
	return true

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

func MoveEntity(entityToMove: Entity, newTile: Tile):
	for tileKey in tiles:
		var tile: Tile = tiles[tileKey]
		var findEntity = tile.entities.find(entityToMove)
		if findEntity != -1:
			tile.entities.remove_at(findEntity)
			newTile.entities.push_back(entityToMove)
			entityToMove.reparent(newTile)
			entityToMove.position = Vector2.ZERO
			return
