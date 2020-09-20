extends Node2D

const NumberOfPoints = 30
const LineRange = 150
const lineWidth = 2
const antiAliasLine = true

var rng = RandomNumberGenerator.new()
var points: Array = []
var screenSize : Vector2
var lineColor = Color(1,1,1)
onready var Dot = preload("res://DotSprite.tscn")

func _ready():
	screenSize = get_viewport().size
	rng.randomize()
	for i in range(NumberOfPoints):
		var dot = Dot.instance()
		dot.position.x = rng.randf_range(0,screenSize.x)
		dot.position.y = rng.randf_range(0,screenSize.y)
		dot.direction = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
		dot.speed = rng.randf_range(0.2,1)
		points.append(dot)
		add_child(dot)

func _draw():
	for i in range(NumberOfPoints):
		points[i].position += points[i].direction * points[i].speed
		if points[i].position.x > screenSize.x:	points[i].position.x = 0
		if points[i].position.y > screenSize.y:	points[i].position.y = 0
		if points[i].position.x < 0:						points[i].position.x = screenSize.x
		if points[i].position.y < 0:						points[i].position.y = screenSize.y
		for j in range(NumberOfPoints):
			if points[i].position.distance_to(points[j].position) <= LineRange:
				draw_line( points[i].position, points[j].position, lineColor, lineWidth , antiAliasLine )

func _process(delta):
	update()
