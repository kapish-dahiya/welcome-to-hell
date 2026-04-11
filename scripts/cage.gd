extends Node2D
@onready var hurt_area = $HurtArea2d
var health: int = 5

func _ready() -> void:
	$AnimationPlayer.play("cage")
	if hurt_area != null:
		hurt_area.my_custom_signal.connect(_on_hurt_area_triggered)
		print("shooter connected to the signal")
	else:
		print("error: shooter found no hurtarea2d")
		
func _on_hurt_area_triggered(silly_message: String, damage_amount: int) -> void:
	#print("hurtarea got signal")
	print("cage silly_message: ", silly_message)
	take_dmg(damage_amount)
	
func take_dmg(amount: int) -> void:
	#print("take damage: ", amount)
	health -= amount
	#print("current health: ", health)
	if health <= 0:
		print("enemy died")
		self.queue_free()
