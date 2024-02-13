extends Node
class_name EffectStack

func findEffects(tags:Array[Effect.Tags]):
	var result : Array[Effect] = []
	
	for effect in self.get_children():
		if effect.tags.has(tags):
			result.append(effect)
	
	return result
