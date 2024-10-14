extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1600.0
const gravity = 6000
var jumps = 0
var max_jumps = 2
var moveSpeed = 300
var direction = 0
var checkx = 0
var checky = 0
func _physics_process(delta: float) -> void:
	#Y_VELOCITY implemented here
	#Jumps Reset
	if is_on_floor():
		jumps = max_jumps
		if velocity.y>0:
			velocity.y = 0
	elif jumps>=max_jumps:
		jumps = max_jumps-1
	#Air Roll
	if Input.is_action_just_pressed("key_up")and jumps==0:
		velocity.y = 0
	#Jumping
	if Input.is_action_just_pressed("key_up")and jumps>0:
		velocity.y = JUMP_VELOCITY
		jumps-=1
	#Gravity
	velocity.y += gravity*delta
	#X_VELOCITY implemented here
	if Input.is_action_pressed("key_left"):
		direction = 0
		velocity.x-=moveSpeed
	if Input.is_action_pressed("key_right"):
		direction = 1
		velocity.x+=moveSpeed
	velocity.x/=1.2
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)

func move(target, javelin, speed):
	var distance=abs(target.global_position - javelin.global_position)
	var distanceX=target.x-javelin.x
	var distanceY=target.y-javelin.y
	var quotient=speed/distance 
	var changeX=distanceX*quotient
	var changeY=distanceY*quotient
	var rotate=atan(changeY/changeX)
	return [changeX, changeY, rotate]
