extends CharacterBody2D

@export var minion_scene: PackedScene
@export var health = 10
@onready var hurt_area = $HurtArea2d

func _ready() -> void:
	if hurt_area != null:
		hurt_area.my_custom_signal.connect(_on_hurt_area_triggered)
		print("spawner CONNECTED TO SIGNAL")
	else:
		print("error: spawner found no hurtarea2d")
	

		
func _on_hurt_area_triggered(silly_message: String, damage_amount: int) -> void:
	print("hurtarea got signal")
	print("silly_message: ", silly_message)
	take_dmg(damage_amount)
	
func take_dmg(amount: int) -> void:
	print("take damage: ", amount)
	health -= amount
	print("current health: ", health)
	if health <= 0:
		print("enemy died")
		self.queue_free()
	
func _on_timer_timeout() -> void:
	var minion_spawn1 = $MinionSpawn1
	var minion_spawn2 = $MinionSpawn2
	var minion_spawn3 = $MinionSpawn3
	var minion_spawn4 = $MinionSpawn4

	var minion1 = minion_scene.instantiate()
	minion1.global_position = minion_spawn1.global_position
	get_tree().current_scene.add_child(minion1)
	
	await get_tree().create_timer(0.5).timeout
	var minion2 = minion_scene.instantiate()
	minion2.global_position = minion_spawn2.global_position
	get_tree().current_scene.add_child(minion2)
	
	await get_tree().create_timer(0.5).timeout
	var minion3 = minion_scene.instantiate()
	minion3.global_position = minion_spawn3.global_position
	get_tree().current_scene.add_child(minion3)
	
	await get_tree().create_timer(0.5).timeout
	var minion4 = minion_scene.instantiate()
	minion4.global_position = minion_spawn4.global_position
	get_tree().current_scene.add_child(minion4)
