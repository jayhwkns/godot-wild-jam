extends Node

@export var item: Item
@export var temp_item: TempItem

@export var inventory: Node

func _ready() -> void:
	$Add.pressed.connect(func(): inventory.pickup(item))
	$AddTemp.pressed.connect(func(): inventory.pickup(temp_item))
	$Remove.pressed.connect(func(): inventory.drop(item))
	$Buy.pressed.connect(func(): inventory.keep(item))
