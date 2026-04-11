extends CharacterBody2D

var bomb_scene = preload("res://scenes/bomb.tscn")
var fire_scene = preload("res://scenes/fire.tscn")
@onready var hurt_area = $HurtArea2d
var health = 20;

func _ready() -> void:
	if hurt_area != null:
		hurt_area.my_custom_signal.connect(_on_hurt_area_triggered)
		print("shooter connected to the signal")
	else:
		print("error: shooter found no hurtarea2d")
		
func _on_hurt_area_triggered(silly_message: String, damage_amount: int) -> void:
	print("hurtarea got signal")
	print("silly_message: ", silly_message)
	take_dmg(damage_amount)
	
func take_dmg(amount: int) -> void:
	#print("take damage: ", amount)
	health -= amount
	#print("current health: ", health)
	if health <= 0:
		print("enemy died")
		self.queue_free()

func _on_bomb_timer_timeout() -> void:
	var bombshooter = $BombShooter
	var bomb = bomb_scene.instantiate()
	bomb.global_position = bombshooter.global_position
	get_tree().current_scene.add_child(bomb)
	
	var firespawner = $FireSpawner
	var fire = fire_scene.instantiate()
	fire.global_position = firespawner.global_position
	get_tree().current_scene.add_child(fire)
	
	var firespawner2 = $FireSpawner2
	var fire2 = fire_scene.instantiate()
	fire.global_position = firespawner2.global_position
	get_tree().current_scene.add_child(fire)
	
	var firespawner3 = $FireSpawner3
	var fire3 = fire_scene.instantiate()
	fire.global_position = firespawner3.global_position
	get_tree().current_scene.add_child(fire)
	
	var firespawner4 = $FireSpawner4
	var fire4 = fire_scene.instantiate()
	fire.global_position = firespawner.global_position
	get_tree().current_scene.add_child(fire)
