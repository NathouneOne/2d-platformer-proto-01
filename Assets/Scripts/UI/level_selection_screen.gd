extends CanvasLayer

signal backbutton
signal levelSelected

func _on_back_button_pressed() -> void:
	backbutton.emit()

func _on_level_1_pressed() -> void:
	get_parent().current_level_index = 0
	levelSelected.emit()


func _on_level_2_pressed() -> void:
	get_parent().current_level_index = 1
	levelSelected.emit()


func _on_level_3_pressed() -> void:
	get_parent().current_level_index = 2
	levelSelected.emit()


func _on_level_4_pressed() -> void:
	get_parent().current_level_index = 3
	levelSelected.emit()


func _on_level_5_pressed() -> void:
	get_parent().current_level_index = 4
	levelSelected.emit()


func _on_level_6_pressed() -> void:
	get_parent().current_level_index = 5
	levelSelected.emit()


func _on_level_7_pressed() -> void:
	get_parent().current_level_index = 6
	levelSelected.emit()


func _on_level_8_pressed() -> void:
	get_parent().current_level_index = 7
	levelSelected.emit()


func _on_level_9_pressed() -> void:
	get_parent().current_level_index = 8
	levelSelected.emit()


func _on_level_10_pressed() -> void:
	get_parent().current_level_index = 9
	levelSelected.emit()


func _on_level_11_pressed() -> void:
	get_parent().current_level_index = 10
	levelSelected.emit()


func _on_level_12_pressed() -> void:
	get_parent().current_level_index = 11
	levelSelected.emit()


func _on_level_13_pressed() -> void:
	get_parent().current_level_index = 12
	levelSelected.emit()


func _on_level_14_pressed() -> void:
	get_parent().current_level_index = 13
	levelSelected.emit()


func _on_level_15_pressed() -> void:
	get_parent().current_level_index = 14
	levelSelected.emit()


func _on_level_16_pressed() -> void:
	get_parent().current_level_index = 15
	levelSelected.emit()


func _on_level_17_pressed() -> void:
	get_parent().current_level_index = 16
	levelSelected.emit()


func _on_level_18_pressed() -> void:
	get_parent().current_level_index = 17
	levelSelected.emit()


func _on_level_19_pressed() -> void:
	get_parent().current_level_index = 18
	levelSelected.emit()


func _on_level_20_pressed() -> void:
	get_parent().current_level_index = 19
	levelSelected.emit()
