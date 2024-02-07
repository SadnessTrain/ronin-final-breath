extends Sprite2D
class_name Tile

var groundTexture: Texture2D = preload("res://Textures/Playfield/GroundTexture.png")
var obstacleTexture: Texture2D = preload("res://Textures/Playfield/ObstacleTexture.png")

var playfield: Playfield
var index: int
var pos: Vector2i
var entities: Array[Node2D] #TODO Change Node2D type
var isObstacle: bool

func createTile(index: int, pos: Vector2i, playfield: Playfield, isObstacle = false):
	self.index = index
	self.pos = pos
	self.entities = []
	self.isObstacle = isObstacle
	self.playfield = playfield
	setPosition()
	setTexture()

func setPosition():
	global_position = Vector2(pos.x * playfield.cellSize.x, pos.y * playfield.cellSize.y)

func setTexture():
	if isObstacle:
		texture = obstacleTexture
		return
		
	texture = groundTexture
