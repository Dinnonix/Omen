extends Control

var scene_path_to_load

func _ready():
	$TitleFadeIn.show()
	$TitleFadeIn/AnimationPlayer.play("TitleFadeIn")
	for button in $Menu/CentreRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	$Sound/TitleScreenMusic.play()

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	if(scene_path_to_load != ""):
		get_tree().change_scene(scene_path_to_load)
		$Sound/TitleScreenMusic.stop()
	else:
		get_tree().quit()
		$Sound/TitleScreenMusic.stop()

func _on_ContinueButton_mouse_entered():
	$Sound/HitSound.play()
func _on_NewGameButton_mouse_entered():
	$Sound/HitSound.play()
func _on_OptionsButton_mouse_entered():
	$Sound/HitSound.play()
func _on_ExitButton_mouse_entered():
	$Sound/HitSound.play()

func _on_ContinueButton_pressed():
	$Sound/Select.play()
func _on_NewGameButton_pressed():
	$Sound/Select.play()
func _on_OptionsButton_pressed():
	$Sound/Select.play()
func _on_ExitButton_pressed():
	$Sound/Select.play()

func _on_TitleFadeIn_fade_in_finished():
	$TitleFadeIn.hide()
