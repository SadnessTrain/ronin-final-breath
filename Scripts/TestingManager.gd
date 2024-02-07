extends Node

@export var label: RichTextLabel

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
		return
		
	currentAction = Actions.SPAWN_TRAP
	label.text = "Spawn Trap"

func handlePlayfieldTileClick(_index: int, pos: Vector2i):
	if currentAction == Actions.NONE:
		return
		
	print("Spawn trap")
