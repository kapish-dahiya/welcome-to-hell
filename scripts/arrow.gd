extends CharacterBody2D

@export var arrow_dmg: int = 5
const SPEED: int = 400
var arrow_direction: Vector2 
@onready var hit_area:Node2D = $HitArea2d
func _ready() -> void:
	hit_area.dmg = arrow_dmg
	arrow_direction = (get_global_mouse_position()-global_position).normalized()
	rotation = arrow_direction.angle()

func _physics_process(delta: float) -> void:
	velocity = SPEED*arrow_direction
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		arrow_direction = reflect.normalized()
		rotation = arrow_direction.angle()
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)

func _on_timer_timeout() -> void:
	queue_free()
