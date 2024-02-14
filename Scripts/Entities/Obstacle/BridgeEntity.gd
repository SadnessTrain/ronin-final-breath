extends Entity
class_name BridgeEntity

var bridgeLeftTopCorner = preload("res://Textures/Playfield/Bridge/BridgeLeftTopCorner.png")
var bridgeTopEdge = preload("res://Textures/Playfield/Bridge/BridgeTopEdge.png")
var bridgeRightTopCorner = preload("res://Textures/Playfield/Bridge/BridgeRightTopCorner.png")

var bridgeLeftMiddleEdge = preload("res://Textures/Playfield/Bridge/BridgeLeftMiddleEdge.png")
var bridgeMiddle = preload("res://Textures/Playfield/Bridge/BridgeMiddle.png")
var bridgeRightMiddleEdge = preload("res://Textures/Playfield/Bridge/BridgeRightMiddleEdge.png")

var bridgeLeftBottomCorner = preload("res://Textures/Playfield/Bridge/BridgeLeftBottomCorner.png")
var bridgeBottomEdge = preload("res://Textures/Playfield/Bridge/BridgeBottomEdge.png")
var bridgeRightBottomCorner = preload("res://Textures/Playfield/Bridge/BridgeRightBottomCorner.png")

@export var sprite: Sprite2D

var direction: Vector2i

func SetDirection(direction: Vector2i):
	self.direction = direction
	UpdateTexture()

func GetTexture() -> Texture2D:
	
	match direction:
		Vector2i(-1, -1):
			return bridgeLeftTopCorner
		Vector2i(0, -1):
			return bridgeTopEdge
		Vector2i(1, -1):
			return bridgeRightTopCorner
			
		Vector2i(-1, 0):
			return bridgeLeftMiddleEdge
		Vector2i(1, 0):
			return bridgeRightMiddleEdge
			
		Vector2i(-1, 1):
			return bridgeLeftBottomCorner
		Vector2i(0, 1):
			return bridgeBottomEdge
		Vector2i(1, 1):
			return bridgeRightBottomCorner
	
	return bridgeMiddle

func UpdateTexture():
	sprite.texture = GetTexture()
	
	
