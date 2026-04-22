extends CharacterBody2D

@export var bomb_scene: PackedScene
@export var fire_scene: PackedScene
@onready var hurt_area: Area2D = $HurtArea2d
var health := 20;

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
	var bombshooter2 = $BombShooter2
	var bombshooter3 = $BombShooter3
	var bombshooter4 = $BombShooter4
	
	var bomb = bomb_scene.instantiate()
	
	bomb.global_position = bombshooter.global_position
	
	get_tree().current_scene.add_child(bomb)
	
	await get_tree().create_timer(0.5).timeout
	var bomb2 = bomb_scene.instantiate()
	bomb2.global_position = bombshooter2.global_position
	get_tree().current_scene.add_child(bomb2)
	
	await get_tree().create_timer(1).timeout
	var bomb3 = bomb_scene.instantiate()
	bomb3.global_position = bombshooter3.global_position
	get_tree().current_scene.add_child(bomb3)
	
	await get_tree().create_timer(1).timeout
	var bomb4 = bomb_scene.instantiate()
	bomb4.global_position = bombshooter4.global_position
	get_tree().current_scene.add_child(bomb4)
	
func _on_fire_timer_timeout() -> void:
	var fire = fire_scene.instantiate()
	var fire2 = fire_scene.instantiate()
	var fire3 = fire_scene.instantiate()
	var fire4 = fire_scene.instantiate()
	
	var firespawner = $FireSpawner
	var firespawner2 = $FireSpawner2
	var firespawner3 = $FireSpawner3
	var firespawner4 = $FireSpawner4
	
	fire.global_position = firespawner.global_position
	fire2.global_position = firespawner2.global_position
	fire3.global_position = firespawner3.global_position
	fire4.global_position = firespawner4.global_position
	
	get_tree().current_scene.add_child(fire)
	await get_tree().create_timer(0.5).timeout
	get_tree().current_scene.add_child(fire2)
	await get_tree().create_timer(0.5).timeout
	get_tree().current_scene.add_child(fire3)
	await get_tree().create_timer(0.5).timeout
	get_tree().current_scene.add_child(fire4)
