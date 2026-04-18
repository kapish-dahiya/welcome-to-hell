extends RigidBody2D
var bomb_speed: int;
var random_angle = randf_range(deg_to_rad(-135), deg_to_rad(-45))
var throw_direction: Vector2 = Vector2.from_angle(random_angle)
var bomb_dmg := 5
@onready var hit_area = $HitArea2d
@onready var hit_area1 = $Explosion

func _ready() -> void:
	hit_area.dmg =  bomb_dmg
	hit_area1.dmg =  bomb_dmg
	
	bomb_speed = randi_range(350, 500)
	linear_velocity = bomb_speed*throw_direction
	await get_tree().create_timer(1).timeout
	freeze = true
	$BombSprite.set_visible(false)
	$Explosion.set_visible(true)
	$AnimationPlayer.play("explode")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
