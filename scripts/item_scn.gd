# world_item.gd
extends Area2D

var item_data: Item

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	update_visuals()

func initialize(data: Item) -> void:
	item_data = data
	update_visuals()

func update_visuals() -> void:
	if not is_inside_tree() or not item_data:
		return
		
	if sprite and "icon" in item_data: 
		sprite.texture = item_data.icon
		
	if collision_shape and collision_shape.shape and sprite.texture:
		var shape = collision_shape.shape as RectangleShape2D
		if shape:
			shape.size = sprite.texture.get_size()
