extends CanvasLayer

signal backbutton
signal reset_button

func _on_h_slider_value_changed(value: float) -> void:
	$VBoxContainer/CenterContainer2/Label2.text=str(value)+'%'
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))




func _on_backbutton_pressed() -> void:
	backbutton.emit()



func _on_reset_button_pressed() -> void:
	reset_button.emit()


func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	$AudioStreamPlayer.play()
	$audiotimer.start()


func _on_audiotimer_timeout() -> void:
	$AudioStreamPlayer.stop()
