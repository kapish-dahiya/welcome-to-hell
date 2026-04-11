extends CharacterBody2D
#@export var cage_scene: PackedScene
@onready var hurt_area = $HurtArea2d
@export var cage_scene: PackedScene
var health = 20;
var player: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if hurt_area != null:
		hurt_area.my_custom_signal.connect(_on_hurt_area_triggered)
		#print("Trap CONNECTED TO SIGNAL")
	else:
		print("error: enemy found no hurtarea2d")
	

func _on_hurt_area_triggered(silly_message: String, damage_amount: int) -> void:
	#print("hurtarea got signal")
	print("silly_message: ", silly_message)
	take_dmg(damage_amount)
	
func take_dmg(amount: int) -> void:
	#print("take damage: ", amount)
	health -= amount
	#print("current health: ", health)
	if health <= 0:
		print("enemy died")
		self.queue_free()

func _on_timer_timeout() -> void:	
	print("time for cage")
	var cage = cage_scene.instantiate()
	get_tree().current_scene.add_child(cage)
	cage.global_position = player.global_position
