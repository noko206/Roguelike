extends CharacterBody3D

@onready var _animation_tree : AnimationTree = $AnimationTree
@onready var _main_state_machine : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/StateMachine/playback")
@onready var _secondary_action_timer : Timer = $SecondaryActionTimer


func _on_secondary_action_timer_timeout():
	if _main_state_machine.get_current_node() != "Idle": return
	_main_state_machine.travel("HeadMovement")
	_secondary_action_timer.start(randf_range(3.0, 8.0))
	
## Sets the model to a neutral, action-free state.
func idle():
	_main_state_machine.travel("Idle")
	_secondary_action_timer.start()

## Plays a one-shot attack animation.
## This animation does not play in parallel with other states.
func attack():
	_main_state_machine.travel("Attack")

## Plays a one-shot power-off animation.
## This animation does not play in parallel with other states.
func power_off():
	_main_state_machine.travel("PowerOff")
	_secondary_action_timer.stop()
	
const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
