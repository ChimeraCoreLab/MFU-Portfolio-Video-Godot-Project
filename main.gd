extends Node3D

@onready var video_player_1: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer
@onready var video_player_2: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer2
@onready var video_player_3: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer3
@onready var video_player_4: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer4
@onready var video_player_5: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer5
@onready var video_player_6: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer6
@onready var video_player_7: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer7
# Add references to the new video players you want to play in sequence
@onready var video_player_8: VideoStreamPlayer = $SubViewport/SubViewportContainer/VideoStreamPlayer8 # Assuming you have this node for video 3 again? Or use video_player_3 if you want to replay it. Let's assume you want to replay video 3, 4, 6, 7.
# If you want to *instantiate* new players or reuse existing ones, the logic changes slightly.
# Assuming you want to REPLAY the existing players (3, 4, 6, 7), we need to make sure they aren't freed.
# However, your previous code calls `queue_free()` on them.
# So, we MUST NOT queue_free them if we want to use them again.
# OR we need new nodes for the repeated sequence.

# Let's modify the approach: instead of queue_free(), we'll just stop() and hide() them.
# Or, cleaner: Reset the 'current_step' logic to loop back or continue to new steps that reuse the players.

@onready var audio1 = $AudioStreamPlayer2D
@onready var audio2 = $AudioStreamPlayer2D3
@onready var audio3 = $AudioStreamPlayer2D4
@onready var audio4 = $AudioStreamPlayer2D5
@onready var audio5 = $AudioStreamPlayer2D6

@onready var timer: Timer = $Timer

var current_step = 0

func _ready() -> void:
	timer.one_shot = true
	$AnimationPlayer2.play("new_animation (2)")
	$CRTTV2/AudioStreamPlayer3D.play()
	$AnimationPlayer.play("new_animation_2")
	$AnimationPlayer3.stop()
	play_step_1()

func play_sequence():
	audio1.play()
	await audio1.finished
	$Skeleton3D/Node3D/AudioStreamPlayer3D.play()
	$AnimationPlayer3.play("g/new_animation_6")
	await $Skeleton3D/Node3D/AudioStreamPlayer3D.finished
	$AnimationPlayer3.stop()
	$AnimationPlayer3.play("g/new_animation_5")
	await get_tree().create_timer(1.0).timeout
	audio2.play()
	await audio2.finished
	$Skeleton3D/Node3D/AudioStreamPlayer3D2.play()
	$AnimationPlayer3.play("g/new_animation_6")	
	await $Skeleton3D/Node3D/AudioStreamPlayer3D2.finished
	$AnimationPlayer3.stop()
	$AnimationPlayer3.play("g/new_animation_5")	
	await get_tree().create_timer(1.0).timeout
	audio3.play()
	await audio3.finished
	await get_tree().create_timer(1.0).timeout
	audio4.play()
	await audio4.finished
	$Skeleton3D/Node3D/AudioStreamPlayer3D3.play()
	$AnimationPlayer3.play("g/new_animation_6")
	await $Skeleton3D/Node3D/AudioStreamPlayer3D3.finished
	$AnimationPlayer3.stop()
	$AnimationPlayer3.play("g/new_animation_5")		
	await get_tree().create_timer(1.0).timeout
	audio5.play()
	await audio5.finished
	$Skeleton3D/Node3D/AudioStreamPlayer3D4.play()
	$AnimationPlayer3.play("g/new_animation_6")	
	await $Skeleton3D/Node3D/AudioStreamPlayer3D4.finished
	$AnimationPlayer3.stop()
	$AnimationPlayer3.play("g/new_animation_5")

func on_animation_player_2_finished(anim_name: String) -> void:
	if anim_name == "new_animation (2)":
		# We remove the quit here to let the video sequence continue?
		# Or keep it if this animation is unrelated to the video player logic.
		# If you want the whole app to quit after EVERYTHING, move this quit logic to the very end of the new sequence.
		pass 

func play_step_1() -> void:
	current_step = 1
	video_player_1.play()
	timer.wait_time = 8.0
	timer.start()

func play_step_2() -> void:
	current_step = 2
	video_player_1.stop()
	video_player_1.visible = false # Hide instead of free to be safe, or free if you are sure you won't use it again
	# video_player_1.queue_free() # Removed queue_free for safety in reuse, though video 1 isn't reused in your request.
	play_sequence()
	video_player_2.play()
	timer.wait_time = 18.0
	timer.start()

func play_step_3() -> void:
	current_step = 3
	video_player_2.stop()
	video_player_2.visible = false
	video_player_3.visible = true
	video_player_3.play()
	timer.wait_time = 6.0
	timer.start()

func play_step_4() -> void:
	current_step = 4
	video_player_3.stop()
	video_player_3.visible = false
	video_player_4.visible = true
	video_player_4.play()
	timer.wait_time = 7.0
	timer.start()

func play_step_5() -> void:
	current_step = 5
	video_player_4.stop()
	video_player_4.visible = false
	video_player_5.volume_db = -15.0
	video_player_5.visible = true
	video_player_5.play()
	timer.wait_time = 26.0
	timer.start()

func play_step_6() -> void:
	current_step = 6
	video_player_5.stop()
	video_player_5.visible = false
	video_player_6.visible = true
	video_player_6.play()
	timer.wait_time = 31.0
	timer.start()

func play_step_7() -> void:
	current_step = 7
	video_player_6.stop()
	video_player_6.visible = false
	video_player_7.visible = true
	video_player_7.play()
	# Add timer to wait for video 7 to finish (assuming you know its length or want to wait a specific time)
	# Let's assume video 7 length is X, or we just use a timer again.
	# You didn't specify length for 7, I'll add a timer for it to trigger the next steps.
	# Let's guess 10 seconds for now, CHANGE THIS to video 7 duration.
	timer.wait_time = 26.0
	timer.start()

# --- NEW STEPS FOR REPLAYING 3, 4, 6, 7 ---

func play_step_8() -> void: # Replay Video 3
	current_step = 8
	video_player_7.stop()
	video_player_7.visible = false
	video_player_3.visible = true
	video_player_3.play()
	timer.wait_time = 6.0 # Same duration as step 3
	timer.start()

func play_step_9() -> void: # Replay Video 4
	current_step = 9
	video_player_3.stop()
	video_player_3.visible = false
	video_player_4.visible = true
	video_player_4.play()
	timer.wait_time = 7.0 # Same duration as step 4
	timer.start()

func play_step_10() -> void: # Replay Video 6
	current_step = 10
	video_player_4.stop()
	video_player_4.visible = false
	video_player_6.visible = true
	video_player_6.play()
	timer.wait_time = 31.0 # Same duration as step 6
	timer.start()

func play_step_11() -> void: # Replay Video 7
	current_step = 11
	video_player_6.stop()
	video_player_6.visible = false
	video_player_7.visible = true
	video_player_7.play()
	# No timer needed if this is the very last one, unless you want to quit after it.
	# If you want to quit after this:
	await video_player_7.finished
	get_tree().quit()


func _on_timer_timeout() -> void:
	if current_step == 1:
		play_step_2()
	elif current_step == 2:
		play_step_3()
	elif current_step == 3:
		play_step_4()
	elif current_step == 4:
		play_step_5()
	elif current_step == 5:
		play_step_6()
	elif current_step == 6:
		play_step_7()
	elif current_step == 7:
		play_step_8()
	elif current_step == 8:
		play_step_9()
	elif current_step == 9:
		play_step_10()
	elif current_step == 10:
		play_step_11()
