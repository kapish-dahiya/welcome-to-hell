extends Node2D

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("restart_game"):
		get_tree().reload_current_scene()
