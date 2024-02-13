extends Node
class_name EffectStack

func ExecuteEffects(tags:Array[Effect.Tags],arg):
	var effects : Array[Effect] = []
	
	for effect in self.get_children():
		if effect.tags.has(tags):
			effects.append(effect)
	
	for effect in effects:
		arg = effect.execute(arg)
	
	return arg
