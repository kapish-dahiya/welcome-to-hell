class_name HurtArea2d
extends Area2D
signal my_custom_signal(silly: String)

#@export var entity:node

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(hit_area: Area2D)-> void:
	if hit_area is HitArea2d:
		my_custom_signal.emit("entity %s" %hit_area.name, hit_area.dmg)
	else:
		print("failed touched area2d")
