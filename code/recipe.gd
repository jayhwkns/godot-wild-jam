class_name Recipe
extends Resource

@export var ingredient_a: Item
@export var ingredient_b: Item
@export var product: Item

## Returns the other ingredient needed for this recipe.
func get_other_ingredient(main_ingredient: Item) -> Item:
	match main_ingredient.id:
		ingredient_a.id:
			return ingredient_b
		ingredient_b.id:
			return ingredient_a
	return null
