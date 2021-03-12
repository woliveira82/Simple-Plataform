extends KinematicBody2D

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 300
const ACC = 10

var motion = Vector2()
var facing_right = true

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	$Sprite.scale.x = 1 if facing_right else -1
		
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("left"):
		motion.x -= ACC
		facing_right = false
		$AnimationPlayer.play("Running")
		
	elif Input.is_action_pressed("right"):
		motion.x += ACC
		facing_right = true
		$AnimationPlayer.play("Running")
		
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jumping")
		else:
			$AnimationPlayer.play("Falling")
		
	motion = move_and_slide(motion, UP)
