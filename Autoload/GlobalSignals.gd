extends Node

signal PlayfieldTileClickSignal(index: int, pos: Vector2i)

signal AttackSignal(sourceEntity:Entity, targetEntity:Entity, attack:Attack)
