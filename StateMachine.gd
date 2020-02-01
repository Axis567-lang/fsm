extends Node
class_name StateMachine

#keep track of the state
var state = null setget set_state #we need to call the method set_state directly
#setget is for callinng automatically var state outsd of our script 
var previous_state = null
#empty dictionary of states
var states = {}

#sm only checks conditions nd tell us what to do
onready var parent = get_parent()    #reference

#physics process
func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)  #storing return value to check if its null
		if transition != null:
			set_state(transition)

#logical part
func _state_logic(delta):   #virtual method
	pass

func _get_transition(delta):  #handle the transitions
	return null

#entering and exiting states
func _enter_state(new_state, old_state):  #what we are transitioing to
	pass

func _exit_state(old_state, new_state):  #what we are transitioning from
	pass

#mechanism for changing our states; properly call the states
func set_state(new_state):
	previous_state = state
	state = new_state
	
	#calling exit_state method
	if previous_state != null:
		_exit_state(previous_state, new_state)
	#now we call the new state
	if new_state != null:
		_enter_state(new_state, previous_state)
	
func add_state(state_name):
	states[state_name] = states.size()

