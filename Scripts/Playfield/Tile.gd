extends Area2D
class_name Tile

@export var sprite: Sprite2D

var playfield: Playfield
var index: int
var pos: Vector2i
var entities: Array[Entity] 
var isHovered: bool
var lastColor: Color
var isActive: bool

func createTile(index: int, pos: Vector2i, playfield: Playfield, isObstacle = false):
	self.index = index
	self.pos = pos
	self.entities = []
	self.playfield = playfield
	isHovered = false
	lastColor = Color("#ffffff")
	setPosition()
	subscribeSignals()

func setPosition():
	global_position = Vector2(pos.x * playfield.cellSize.x, pos.y * playfield.cellSize.y)

func subscribeSignals():
	mouse_entered.connect(handleMouseEntered)
	mouse_exited.connect(handleMouseExited)
	
func handleMouseEntered():
	changeColor(Color("#424242"))
	isHovered = true
	
func handleMouseExited():
	changeColor(lastColor)
	isHovered = false

func changeColor(color: Color):
	lastColor = modulate
	modulate = color 

func _physics_process(_delta: float):
	if isHovered && Input.is_action_just_pressed("LeftMouse"):
		GlobalSignals.PlayfieldTileClickSignal.emit(self, isActive)

func appendEntity(entity: Entity):
	entity.position = Vector2.ZERO
	add_child(entity)
	entities.push_back(entity)
	
func enableTileHighlighting():
	changeColor(Color("#2c9e32"))
	isActive = true
	
func disableTileHighlighting():
	changeColor(Color("#ffffff"))
	lastColor = Color("#ffffff")
	isActive = false
	
func CheckIfHasWall():
	for entity in entities:
		if entity is WallEntity:
			return true

	return false
