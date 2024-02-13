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

func handlePlayfieldTileClick(tile: Tile, isActive: bool):
	if !isActive:
		return
	
	if currentAction == Actions.NONE || tile == null: 
		return
		
	if currentAction == Actions.SPAWN_TRAP:
		var trap = trapScene.instantiate()
		tile.appendEntity(trap)
		tile.disableTileHighlighting()
		
	if currentAction == Actions.MOVE:
		currentAction = Actions.NONE
		label.text = "NONE"
		playfield.MoveEntity(playfield.player, tile)
		playfield.DisableAllTilesHighlighting()


func handleMoveButtonClick():
	playfield.DisableAllTilesHighlighting()
	if currentAction == Actions.MOVE:
		currentAction = Actions.NONE
		label.text = "NONE"
		return
		
	currentAction = Actions.MOVE
	label.text = "Move"
	var possibleTiles = playfield.GetAllPossibleTilesToMove(playfield.GetTileWithPlayer().pos, 2)
	playfield.SetPossibleTilesHighlightingByTilesObj(possibleTiles, true)
