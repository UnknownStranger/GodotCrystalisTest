extends KinematicBody2D 
#list of keys as input and their value being the reflected movement direction.
const MOVEMENTS = {
  "move_up": Vector2.UP,
  "move_down": Vector2.DOWN,
  "move_left": Vector2.LEFT,
  "move_right": Vector2.RIGHT
}
#making an array of the input presses so only the most recent key press is used later
var last_direction = []

func _process(delta):
  var speed: = Vector2(100.0,100.0)
  var direction: = get_direction()
  move_and_slide(direction * speed)

func get_direction() -> Vector2:
  # return Vector2(
  #   Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
  #   Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
  # )
#checking if any key in the movement list has been recently pressed or released and adding or removing it from the last direction array
  for key in MOVEMENTS.keys():

    if Input.is_action_just_released(key):
      var i = last_direction.find(key)
      if i != -1:
        last_direction.remove(i)

    if Input.is_action_just_pressed(key):
      last_direction.append(key)
#then if there is more than one key press logged in the array using only the last one, if there are none returning a 0,0 vector
  if last_direction.size() > 0:
    var direction = last_direction[last_direction.size()-1]
    return MOVEMENTS[direction]
  else:
    return Vector2.ZERO
