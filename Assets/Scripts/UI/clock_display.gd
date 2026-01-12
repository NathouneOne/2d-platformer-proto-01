extends Control

var elapsed_time=0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.time_scale==1 :
		elapsed_time+=delta
	else:
		elapsed_time+=delta*0.1
	
	%RichTextLabel.text=str(elapsed_time)
