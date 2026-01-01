extends MeshInstance3D

@onready var anim = $AnimationPlayer
var door_open = true


func _on_area_3d_body_entered(body):
	if body is CharacterBody3D :
		anim.play("Open")
		door_open = false
		


func _on_area_3d_body_exited(body):
	if body is CharacterBody3D and !door_open:
		anim.play_backwards("Open")
		door_open = true
