extends Control

@export var bkg_color : Color
@export var outer_radius : int = 50
@export var line_color : Color
@export var line_width : int = 2
@export var inner_radius = 10.0
@export var nb_options = 4
@export var option_colors : Array[Color]
@export var highlight_color: Color



var selection = 0

#const inner_radius = 15.0

func _draw() -> void:
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, 256, line_color, line_width, true)
	draw_arc(Vector2.ZERO, outer_radius, 0, TAU, 256, line_color, line_width, true)
	for i in range(nb_options):
		var rad = i*TAU/nb_options
		var point = Vector2.from_angle(rad)
		draw_arc(Vector2.ZERO, (inner_radius+outer_radius)/2, rad, (i+1)*TAU/nb_options, 256, option_colors[i], outer_radius-inner_radius-line_width, true)
		draw_line(point*inner_radius, point*outer_radius,line_color,line_width,true)
		
		if selection == 0 :
			draw_circle(Vector2.ZERO, inner_radius, bkg_color+highlight_color)
		elif selection-1 == i:
			draw_arc(Vector2.ZERO, (inner_radius+outer_radius)/2, rad, (i+1)*TAU/nb_options, 256, option_colors[i]+highlight_color, outer_radius-inner_radius-line_width, true)
		

func _process(_delta: float) -> void:
	var mouse_position = get_local_mouse_position()
	var mouse_radius = mouse_position.length()
	if mouse_radius < inner_radius:
		selection=0
	else : 
		var mouse_rad = fposmod(mouse_position.angle(), TAU)
		selection = ceil((mouse_rad/TAU)*nb_options)
		
	print(selection)
	queue_redraw()
