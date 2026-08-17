# Template for an item and its required methods.
class_name Item
extends Resource

@export var id: String = "PLACEHOLDER_ITEM"

@export var display_name: String = "Placeholder Item"

@export_multiline var description: String = (
	"This item doesn't do anything. It was never meant to."
)

@export var icon: Texture2D = preload("res://art/placeholder/PLACEHOLDER_ITEM.bmp")

@export var price: int = 1

var count: int = 0

func on_pickup() -> void:
	count += 1

func on_drop() -> void:
	count -= 1

## Returns the product of the recipe containing `self` and `item_b`
func get_product(item_b: Item, recipes: Array[Recipe]) -> Item:
	var product = recipes.filter(func(recipe: Recipe):
		return recipe.get_other_ingredient(self) == item_b
	)
	if product.is_empty():
		return null
	product = product[0]
	return product.product
	

## Called every frame when in inventory.
func process(_delta: float) -> void:
	pass
