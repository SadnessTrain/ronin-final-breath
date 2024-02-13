extends Entity
class_name BridgeEntity

var bridgeMiddle = preload("res://Textures/Playfield/Bridge/BridgeMiddle.png")

@export var sprite: Sprite2D

var direction: Vector2i

func SetDirection(direction: Vector2i):
	self.direction = direction
	UpdateTexture()

func GetTexture() -> Texture2D:
	
	return bridgeMiddle

func UpdateTexture():
	sprite.texture = GetTexture()
	
	
