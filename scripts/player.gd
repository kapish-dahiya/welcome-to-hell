#note: starting bow animation has minor mistake
#have to implement health bar as a sun
extends CharacterBody2D
#signal health_updated(health)
#signal killed()
var arrow_scene = preload("res://scenes/arrow.tscn")
var big_shot_scene = preload("res://scenes/big_shot.tscn")
var small_shot_scene = preload("res://scenes/small_shot.tscn")

@onready var bow = $bow
@onready var animation = $AnimationPlayer
#health 
@onready var invulnerability_timer = $Invulnerability
@onready var effects_animation = $EffectsAnimation

const SPEED = 120
var charged_held_time = 0


@export var max_health = 100
@export	var is_attacking:bool = false
@onready var health = max_health :set = _set_health

func kill():
	get_tree().reload_current_scene()
	
func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		print("amount: ", amount)
		effects_animation.play("damage")
		effects_animation.queue("invulnerable")
		health = health - amount
		
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

func _physics_process(_delta):
	#have to implement: stop player from moving if attacking
	if !is_attacking:
		bow.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot") and not is_attacking:
		$bow/BowAnimationPlayer.play("bow")
		charged_held_time += _delta
		
	if is_attacking:
		velocity = Vector2.ZERO
	
	if Input.is_action_just_released("shoot"):
		if charged_held_time >= 2:
			$bow/BowAnimationPlayer.play("RESET")
			charged_held_time = 0
			print("charge time: ", charged_held_time)
			#bow.global_position = bow.global_position
			#await get_tree().create_timer(0.9).timeout
			#bow.look_at(get_global_mouse_position())
			
			var big_shot = big_shot_scene.instantiate()
			var arrow = arrow_scene.instantiate()
			arrow.global_position = bow.global_position
			big_shot.global_position = bow.global_position
			print("shot position: ")
			get_tree().current_scene.add_child(arrow)
			get_tree().current_scene.add_child(big_shot)
			#start atk cooldown
			
		elif charged_held_time >= 1:
			$bow/BowAnimationPlayer.play("RESET")
			charged_held_time = 0
			var big_shot = big_shot_scene.instantiate()
			big_shot.global_position = bow.global_position
			print("shot position: ")
			get_tree().current_scene.add_child(big_shot)
			#start atk cooldown
			
		elif charged_held_time >= 0.25:
			$bow/BowAnimationPlayer.play("RESET")
			charged_held_time = 0
			
			var small_shot = small_shot_scene.instantiate()
			small_shot.global_position = bow.global_position
			print("small shot position: ")
			get_tree().current_scene.add_child(small_shot)
			#start atk cooldown
			
		else:
			$bow/BowAnimationPlayer.play("RESET")
			
	else:
		if not is_attacking:
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

	for i in range (get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemies"):
			damage(20)
