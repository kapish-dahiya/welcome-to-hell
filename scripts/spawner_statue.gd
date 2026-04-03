extends CharacterBody2D

@export var minion_scene: PackedScene


func _on_timer_timeout() -> void:
	var minion_spawn1 = $MinionSpawn1
	var minion_spawn2 = $MinionSpawn2
	var minion_spawn3 = $MinionSpawn3
	var minion_spawn4 = $MinionSpawn4

	#var minion1 = minion_scene.instantiate()
	#var minion2 = minion_scene.instantiate()
	#var minion3 = minion_scene.instantiate()
	#var minion4 = minion_scene.instantiate()
	#
	#minion1.global_position = minion_spawn1.global_position
	#minion2.global_position = minion_spawn2.global_position
	#minion3.global_position = minion_spawn3.global_position
	#minion4.global_position = minion_spawn4.global_position
	#
	#get_tree().current_scene.add_child(minion1)
	#get_tree().current_scene.add_child(minion2)
	#get_tree().current_scene.add_child(minion3)
	#get_tree().current_scene.add_child(minion4)
