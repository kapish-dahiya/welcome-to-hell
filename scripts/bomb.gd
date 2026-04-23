extends RigidBody2D
var bomb_speed: int;
var random_angle = randf_range(deg_to_rad(-135), deg_to_rad(-45))
var throw_direction: Vector2 = Vector2.from_angle(random_angle)
var bomb_dmg := 1
@onready var hit_area: Area2D = $HitArea2d
@onready var hit_area1: Area2D = $Explosion
@onready var bomb_sprite: Sprite2D = $BombSprite
@onready var explosion: Area2D = $Explosion
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hit_area.dmg =  bomb_dmg
	hit_area1.dmg =  bomb_dmg
	
	bomb_speed = randi_range(350, 500)
	linear_velocity = bomb_speed*throw_direction
	await get_tree().create_timer(1).timeout
	freeze = true
	bomb_sprite.set_visible(false)
	explosion.set_visible(true)
	anim_player.play("explode")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
