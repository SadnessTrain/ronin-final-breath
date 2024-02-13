extends Node
class_name EffectStack

func findEffects(tags:Array[Effect.Tags]):
	var result : Array[Effect] = []
func ExecuteEffects(tags:Array[Effect.Tags],arg):
	var effects : Array[Effect] = []
	
	for effect in self.get_children():
		if effect.tags.has(tags):
			result.append(effect)
			effects.append(effect)
	
	return result
	for effect in effects:
		arg = effect.execute(arg)
	
	return arg
