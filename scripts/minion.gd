extends CharacterBody2D

@onready var player: Node2D

const SPEED:int = 50;
var health:int = 5;
var minion_dmg: int = 1
@onready var hit_area = $HitArea2d
@onready var hurt_area = $HurtArea2d

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hit_area.dmg = minion_dmg
	if hurt_area != null:
		hurt_area.my_custom_signal.connect(_on_hurt_area_triggered)
		#print("minion CONNECTED TO SIGNAL")
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
func _physics_process(_delta) -> void:
	velocity = (player.global_position - global_position).normalized() * SPEED

	move_and_slide();
	look_at(player.global_position)
	
