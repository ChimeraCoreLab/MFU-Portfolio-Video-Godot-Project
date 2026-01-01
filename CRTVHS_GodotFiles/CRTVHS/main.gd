extends Node3D

func _ready() -> void:
	$AnimationPlayer.play("new_animation")
	$Timer.start()
	$Timer2.start()
	$Timer3.start()
	$SubViewport/SubViewportContainer/VideoStreamPlayer.play()
	$Timer4.start()
	$Timer5.start()
	$Timer7.start()


func _on_timer_timeout() -> void:
	$SubViewport2/SubViewportContainer/VideoStreamPlayer.play()


func _on_timer_2_timeout() -> void:
	$SubViewport3/SubViewportContainer/VideoStreamPlayer.play()


func _on_timer_4_timeout() -> void:
	$SubViewport5/SubViewportContainer/VideoStreamPlayer.play()


func _on_timer_5_timeout() -> void:
	$SubViewport6/SubViewportContainer/VideoStreamPlayer.play()


func _on_timer_7_timeout() -> void:
	get_tree().quit()
