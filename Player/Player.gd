extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 4
var speed = 2
var max_speed = 10
var nose = Vector2(0,-60)
onready var Bullet = load("res://Bullet.tscn")

func _ready():
	pass
func _physics_process(_delta):
	position = position + velocity
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)

	$Exhaust.hide()
	if Input.is_action_pressed("forward"):
		velocity = velocity + Vector2(0,-speed).rotated(rotation)
		$Exhaust.show()
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
	if Input.is_action_just_pressed("shoot"):
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.global_position = global_position + nose.rotated(rotation)
			bullet.rotation = rotation
			Effects.add_child(bullet)
