extends CharacterBody2D

var bomb_scene = preload("res://scenes/bomb.tscn")
var fire_scene = preload("res://scenes/fire.tscn")

func _on_bomb_timer_timeout() -> void:
	var bombshooter = $BombShooter
	var bomb = bomb_scene.instantiate()
	bomb.global_position = bombshooter.global_position
	get_tree().current_scene.add_child(bomb)
	
	var firespawner = $FireSpawner
	var fire = fire_scene.instantiate()
	fire.global_position = firespawner.global_position
	get_tree().current_scene.add_child(fire)
