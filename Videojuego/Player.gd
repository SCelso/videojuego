extends KinematicBody2D

var speed = 500 
var bullet_speed = 2000
var bullet = preload("res://bullet.tscn")
onready var _animated_sprite = $AnimatedSprite
var charger = 0
var can_shoot=true
var cooldown_reload=3.1
var cooldown_shoot=0.2
var timer_reload
var timer_shoot
var animation="default"

func _ready():
	
	timer_reload=Timer.new()
	add_child(timer_reload)
	timer_reload.set_one_shot(true)
	timer_reload.set_wait_time(cooldown_reload)
	timer_reload.connect("timeout",self,"_cooldown_end_reload")
	
	timer_shoot=Timer.new()
	add_child(timer_shoot)
	timer_shoot.set_one_shot(true)
	timer_shoot.set_wait_time(cooldown_shoot)
	timer_shoot.connect("timeout",self,"_cooldown_end_shoot")

func _physics_process(delta):
	

	var motion = Vector2()
	_animated_sprite.play(animation)
	if Input.is_action_pressed("up"):
		motion.y -= 1
		
		
	if Input.is_action_pressed("down"):
		motion.y += 1
		
		
	if Input.is_action_pressed("right"):
		motion.x += 1		
		
		
	if Input.is_action_pressed("left"):
		motion.x -= 1		
		

		
#	if (Input.is_action_pressed("left") ||Input.is_action_pressed("right")||Input.is_action_pressed("down")||Input.is_action_pressed("up") && charger<6):
#		animation="move"
	
			
	
	motion = motion.normalized()
	motion = move_and_slide(motion * speed)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("LMB"):
		if  charger >= 6:
			timer_reload.start()
			can_shoot=false
			animation="reload"
		else:
			fire()
			
		
func fire():
	timer_shoot.start()
	charger += 1
	animation="shoot"
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position() + Vector2(120,58).rotated(rotation)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	

func kill():
	get_tree().reload_current_scene()



func _on_Area2D_body_entered(body):

	if "Enemy" in body.name:
		kill()


func _cooldown_end_reload():
	can_shoot=true
	charger=0
	animation="default"


func _cooldown_end_shoot():
	animation="default"
