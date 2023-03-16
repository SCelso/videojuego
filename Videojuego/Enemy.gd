extends KinematicBody2D

var motion = Vector2()
onready var _animated_sprite = $AnimatedSprite
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var player = get_parent().get_node("Player")

	position += (player.position - position)/50
	look_at(player.position)
	if position < player.position +Vector2(150,150):
		_animated_sprite.play("attack")
	else:
		_animated_sprite.play("move")
		
	move_and_collide(motion)



func _on_Area2D_body_entered(body):
	if "bullet" in body.name:
		queue_free()



		
