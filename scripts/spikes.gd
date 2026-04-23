extends Node2D

var speed := 40
var spikes_dmg := 1
var direction: Vector2
var move_timer: float = 0
var move_interval: float = 0.8
@onready var hit_area: Area2D = $HitArea2d
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var player: Node2D

func _ready() -> void:
	rotation += PI
	player = get_tree().get_first_node_in_group("player")
	look_at(player.global_position)
	direction = (player.global_position-global_position).normalized()
	hit_area.dmg = spikes_dmg
	anim_player.play("atk")
	
func _process(delta: float) -> void:
	move_timer += delta
	if move_timer >= move_interval:
		position += direction*(speed*move_interval)
		move_timer = 0

func _on_hit_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("walls"):
		queue_free()

func _on_hit_area_2d_area_entered(_area: Area2D) -> void:
	queue_free()
