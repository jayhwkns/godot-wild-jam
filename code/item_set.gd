## Set of items, enforcing no duplicate item IDs.
class_name ItemSet

var items: Array[Item]

## Tracked sum of all item counts
var count: int

func add(item: Item) -> Item:
	count += 1
	var from_set = get_item(item)
	if from_set == null:
		items.append(item)
	return item

func remove(item: Item) -> bool:
	var index = items.find_custom(func(i: Item): i.id == item.id)
	if index == -1:
		return false
	items.remove_at(index)
	count -= 1
	return true

func get_item(item: Item) -> Item:
	var from_set = items.filter(func(i: Item): i.id == item.id)
	if from_set.is_empty():
		return null
	return from_set[0]
