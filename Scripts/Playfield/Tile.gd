extends Area2D
class_name Tile

@export var sprite: Sprite2D

var groundTexture: Texture2D = preload("res://Textures/Playfield/GroundTexture.png")
var obstacleTexture: Texture2D = preload("res://Textures/Playfield/ObstacleTexture.png")

var playfield: Playfield
var index: int
var pos: Vector2i
var entities: Array[Node2D] #TODO Change Node2D type
var isObstacle: bool
var isHovered: bool

func createTile(index: int, pos: Vector2i, playfield: Playfield, isObstacle = false):
	self.index = index
	self.pos = pos
	self.entities = []
	self.isObstacle = isObstacle
	self.playfield = playfield
	isHovered = false
	setPosition()
	setTexture()
	subscribeSignals()

func setPosition():
	global_position = Vector2(pos.x * playfield.cellSize.x, pos.y * playfield.cellSize.y)

func setTexture():
	if isObstacle:
		sprite.texture = obstacleTexture
		return
		
	sprite.texture = groundTexture

func subscribeSignals():
	mouse_entered.connect(handleMouseEntered)
	mouse_exited.connect(handleMouseExited)
	
func handleMouseEntered():
	modulate = Color("#424242")
	isHovered = true
	
func handleMouseExited():
	modulate = Color("#ffffff")
	isHovered = false

func _physics_process(_delta: float):
	if isHovered && Input.is_action_just_pressed("LeftMouse"):
		GlobalSignals.PlayfieldTileClickSignal.emit(index, pos)
