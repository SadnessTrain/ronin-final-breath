extends Node

signal PlayfieldTileClickSignal(tile: Tile, isActive: bool)

signal AttackSignal(sourceEntity:Entity, targetEntity:Entity, attack:Attack)
