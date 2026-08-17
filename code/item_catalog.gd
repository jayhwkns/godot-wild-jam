class_name ItemCatalog
extends Resource

@export var global_items: Array[Item] = []
@export var floormart_items: Array[Item] = []
@export var bestguy_items: Array[Item] = []
@export var homerepo_items: Array[Item] = []
@export var recipes: Array[Recipe] = []

func recipes_containing(item: Item) -> Array[Recipe]:
	return recipes.filter(func(recipe: Recipe):
		return (
			item.id == recipe.ingredient_a.id or
			item.id == recipe.ingredient_b.id
		)
	)

func recipe_for(item: Item) -> Recipe:
	var recipes_for = recipes.filter(func(r: Recipe):
		return r.product.id == item.id
	)
	if recipes_for.is_empty():
		return null
	return recipes_for[0]

func combineable_with(item: Item) -> Array[Item]:
	var recipes_con = recipes_containing(item)
	var combineable: Array[Item] = []
	for recipe in recipes_con:
		combineable.append(recipe.get_other_ingredient(item))
	return combineable

func combine(item_a: Item, item_b: Item) -> Item:
	var recipes_con = recipes_containing(item_a)
	var recipe = recipes_con.filter(func(r: Recipe):
		return r.ingredient_a.id == item_b.id or r.ingredient_b.id == item_b.id
	)
	if recipe.is_empty():
		return null
	recipe = recipe[0]
	return recipe.product
	
