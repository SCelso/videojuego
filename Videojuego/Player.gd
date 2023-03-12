extends KinematicBody2D

var speed = 500 
var bullet_speed = 2000
var bullet = preload("res://bullet.tscn")
onready var _animated_sprite = $AnimatedSprite
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()
	 
	if Input.is_action_pressed("up"):
		motion.y -= 1
		
		
	if Input.is_action_pressed("down"):
		motion.y += 1
		
		
	if Input.is_action_pressed("right"):
		motion.x += 1		
		
		
	if Input.is_action_pressed("left"):
		motion.x -= 1		
		
	
	if Input.is_action_pressed("left") ||Input.is_action_pressed("right")||Input.is_action_pressed("down")||Input.is_action_pressed("up"):
		_animated_sprite.play("move")
	else:
		_animated_sprite.play("default")	
	
	motion = motion.normalized()
	motion = move_and_slide(motion * speed)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LMB"):
		fire()
		_animated_sprite.play("shoot")
	
func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position() + Vector2(120,58).rotated(rotation)
	print(bullet_instance.position)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func kill():
	get_tree().reload_current_scene()



func _on_Area2D_body_entered(body):

	if "Enemy" in body.name:
	
		print('hola')
		kill()
