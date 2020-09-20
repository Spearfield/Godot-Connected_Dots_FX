extends Node2D

const NumberOfPoints = 20
const LineRange = 150
var rng = RandomNumberGenerator.new()
var points = []
var directions = []
var speed = []
var screenSizeX
var screenSizeY
var lineColor = Color(1,1,1)
onready var Dot = preload("res://DotSprite.tscn")

func _ready():
	screenSizeX = get_viewport().size.x
	screenSizeY = get_viewport().size.y
	rng.randomize()
	for i in range(NumberOfPoints):
		var dot = Dot.instance()
		dot.position.x = rng.randf_range(0,screenSizeX)
		dot.position.y = rng.randf_range(0,screenSizeY)
		points.append(dot)
		add_child(dot)
		directions.append(Vector2(rng.randf_range(-1,1),
															rng.randf_range(-1,1)))
		speed.append(rng.randf_range(0.2,1)) # I do know that I could have direction * speed in one array...

func _draw():
	for i in range(NumberOfPoints):
		points[i].position += directions[i] * speed[i]
		if points[i].position.x > screenSizeX:	points[i].position.x = 0
		if points[i].position.y > screenSizeY:	points[i].position.y = 0
		if points[i].position.x < 0:						points[i].position.x = screenSizeX
		if points[i].position.y < 0:						points[i].position.y = screenSizeY
		for j in range(NumberOfPoints):
			if points[i].position.distance_to(points[j].position) <= LineRange:
				draw_line( points[i].position, points[j].position, lineColor, 2 , true )

func _process(delta):
	update()
