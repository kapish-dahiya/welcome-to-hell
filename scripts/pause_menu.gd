extends Control

@onready var pause_menu = '$/root/World/Pause_menu'
func pause():
	get_tree().paused = true
	self.set_visible(true)
	print("pause")
	
func resume():
	get_tree().paused = false
	self.set_visible(false)
	print("resume")
	
func test_esc():
	if Input.is_action_pressed("pause"):
		if get_tree().paused == false:
			pause()
		else:
			resume()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
	
func _process(_delta):
	test_esc()
