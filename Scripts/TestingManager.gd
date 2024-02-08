extends Node

var trapScene = preload("res://Scenes/Entities/Obstacle/TrapEntity.tscn")

@export var label: RichTextLabel
@export var playfield: Playfield

enum Actions {
	NONE,
	SPAWN_TRAP,
	MOVE
}

var currentAction: Actions = Actions.NONE

func _ready():
	GlobalSignals.PlayfieldTileClickSignal.connect(handlePlayfieldTileClick)
	label.text = "NONE"

func handleSpawnTrapButtonClick():
	playfield.DisableAllTilesHighlighting()
	if currentAction == Actions.SPAWN_TRAP:
		currentAction = Actions.NONE
		label.text = "NONE"
		return
		
	currentAction = Actions.SPAWN_TRAP
	label.text = "Spawn Trap"
	var possibleTiles = playfield.GetAllEmptyTiles()
	playfield.SetPossibleTilesHighlightingByTilesObj(possibleTiles, true)

func handlePlayfieldTileClick(tile: Tile):
	if currentAction == Actions.NONE || tile == null || tile.CheckIfHasWall(): 
		return
		
	if currentAction == Actions.MOVE:
		pass
		
	var trap = trapScene.instantiate()
	tile.appendEntity(trap)
	tile.disableTileHighlighting()


func handleMoveButtonClick():
	playfield.DisableAllTilesHighlighting()
	if currentAction == Actions.MOVE:
		currentAction = Actions.NONE
		label.text = "NONE"
		return
		
	currentAction = Actions.MOVE
	label.text = "Move"
	var possibleTiles = playfield.GetAllPossibleTilesToMove(Vector2i(3, 3), 2)
	playfield.SetPossibleTilesHighlightingByTilesObj(possibleTiles, true)
