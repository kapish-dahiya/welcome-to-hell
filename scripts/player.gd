#note: starting bow animation has minor mistake
#have to implement health bar as a sun
extends CharacterBody2D
#signal health_updated(health)
#signal killed()
var arrow_scene = preload("res://scenes/arrow.tscn")
var big_shot_scene = preload("res://scenes/big_shot.tscn")
var small_shot_scene = preload("res://scenes/small_shot.tscn")

@onready var bow = $Bow
@onready var animation = $AnimationPlayer
#health 
@onready var invulnerability_timer = $Invulnerability
@onready var effects_animation = $EffectsAnimation

const SPEED = 120
var charged_held_time: float= 0.0

	
@export var max_health := 50
@onready var health := max_health :set = _set_health
@onready var hurt_area = $HurtArea2d

func _ready() -> void:
	if hurt_area != null:
		hurt_area.my_custom_signal.connect(_on_hurt_area_triggered)
		print("Player connected to the signal")
	else:
		print("error: Player found no hurtarea2d")
	

		
func _on_hurt_area_triggered(silly_message: String, damage_amount: int) -> void:
	print("hurtarea got signal")
	print("silly_message: ", silly_message)
	take_dmg(damage_amount)
	

func kill():
	self.queue_free()
	
func take_dmg(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		print("amount: ", amount)
		effects_animation.play("damage")
		effects_animation.queue("invulnerable")
		health -= amount
		if health <= 0:
			print("player died")
			kill()
	
		
func _on_invulnerability_timeout() -> void:
		effects_animation.play("rest")
		
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	print("value: ", value)

	if health != prev_health:
		print("health: ",health)
		#emit_signal("health_updated",health);
	if health == 0:
		kill()


@export var is_attacking:bool
@export var atk_cooldown: bool
func _physics_process(_delta):
	is_attacking = false
	
	if not $AtkCooldown.is_stopped():
		return
		
	if Input.is_action_pressed("shoot") and not is_attacking:
		is_attacking = true
		$Bow/BowAnimationPlayer.play("bow")
		charged_held_time += _delta
	
	if atk_cooldown:
		$Bow/BowAnimationPlayer.play("RESET")
		
	if is_attacking:
		velocity = Vector2.ZERO
		
	
	if Input.is_action_just_released("shoot"):
		if charged_held_time >= 2.25:
			$Bow/BowAnimationPlayer.play("RESET")
			charged_held_time = 0
			var big_shot = big_shot_scene.instantiate()
			var arrow = arrow_scene.instantiate()
			arrow.global_position = bow.global_position
			big_shot.global_position = bow.global_position
			get_tree().current_scene.add_child(arrow)
			get_tree().current_scene.add_child(big_shot)
			$AtkCooldown.start(0.5)
			is_attacking = false
		elif charged_held_time >= 1.65:
			$Bow/BowAnimationPlayer.play("RESET")
			charged_held_time = 0
			var big_shot = big_shot_scene.instantiate()
			big_shot.global_position = bow.global_position
			get_tree().current_scene.add_child(big_shot)
			$AtkCooldown.start(1)
			is_attacking = false
			
		elif charged_held_time >= 1:
			$Bow/BowAnimationPlayer.play("RESET")
			charged_held_time = 0
			var small_shot = small_shot_scene.instantiate()
			small_shot.global_position = bow.global_position
			get_tree().current_scene.add_child(small_shot)
			$AtkCooldown.start(2)
			is_attacking = false
			
		else:
			#is_attacking = false
			$Bow/BowAnimationPlayer.play("RESET")
			
	else:
		if not is_attacking:
			bow.look_at(get_global_mouse_position())
			
			var input_vector = Vector2(Input.get_vector("left", "right", "up", "down")).normalized()
			velocity = input_vector * SPEED
			
			var anim_vector := input_vector.sign()
			
			match anim_vector:
				Vector2(0, -1): animation.play("walk_up")
				Vector2(-1, -1): animation.play("walk_up_left")
				Vector2(1, -1): animation.play("walk_up_right")
				Vector2(0, 1): animation.play("walk_down")
				Vector2(-1, 1): animation.play("walk_down_left")
				Vector2(1, 1): animation.play("walk_down_right")
				Vector2(1, 0): animation.play("walk_down_right")
				Vector2(-1, 0): animation.play("walk_down_left")
				Vector2.ZERO: animation.play(animation.current_animation.replace("walk", "reset"))
			move_and_slide()
