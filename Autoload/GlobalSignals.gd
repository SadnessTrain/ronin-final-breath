extends Node

signal PlayfieldTileClickSignal(index: int, pos: Vector2i)

signal AttackSignal(sourceEntity:Entity, targetEntity:Entity, attack:Attack)
#signal ApplyDebuff(sourceEntity:Entity, targetEntity:Entity, debuff:Debuff)
