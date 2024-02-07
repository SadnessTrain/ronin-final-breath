extends Marker2D
class_name Tile

var index: int
var pos: Vector2i
var entities: Array[Node2D] #TODO Change Node2D type

func createTile(index: int, pos: Vector2i):
	self.index = index
	self.pos = pos
	self.entities = []
