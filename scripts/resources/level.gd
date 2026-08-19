class_name Level
extends Resource

const LEVEL_GROUP = "level"

## Items which are allowed to spawn in this level.
@export var items: Array[Item] = []
## Modules which can be spawned in this level.
@export var modules: Array[PackedScene] = []

const MODULE_WIDTH = 16 * 16

func generate(rng: RandomNumberGenerator, num_modules: int) -> Array[Node]:
	var nodes: Array[Node] = []
	for i in range(num_modules):
		var node = modules[rng.randi() % modules.size()].instantiate() as Node2D
		node.transform.origin.x = MODULE_WIDTH * i
		node.add_to_group(LEVEL_GROUP)
		nodes.append(node)
	return nodes
