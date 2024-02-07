extends Node

var trapScene = preload("res://Scenes/Entities/Obstacle/TrapEntity.tscn")

@export var label: RichTextLabel
@export var playfield: Playfield

enum Actions {
	NONE,
	SPAWN_TRAP,
}

var currentAction: Actions = Actions.NONE

func _ready():
	GlobalSignals.PlayfieldTileClickSignal.connect(handlePlayfieldTileClick)
	label.text = "NONE"

func handleSpawnTrapButtonClick():
	if currentAction == Actions.SPAWN_TRAP:
		currentAction = Actions.NONE
		label.text = "NONE"
		playfield.DisableAllTilesHighlighting()
		return
		
	currentAction = Actions.SPAWN_TRAP
	label.text = "Spawn Trap"
	var possibleTiles = playfield.GetAllEmptyTiles()
	playfield.SetPossibleTilesHighlightingByTilesObj(possibleTiles, true)

func handlePlayfieldTileClick(tile: Tile):
	if currentAction == Actions.NONE || tile == null || tile.CheckIfHasWall(): 
		return
		
	var trap = trapScene.instantiate()
	tile.appendEntity(trap)
	tile.disableTileHighlighting()
