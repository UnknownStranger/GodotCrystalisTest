extends AnimationPlayer
#mostly copy paste from the player movement to mirror with animation
#see hero.gd for more information
const MOVEMENTS = {
  "move_up": "Up",
  "move_down": "Down",
  "move_left": "Left",
  "move_right": "Right"
}

var last_direction = []

func _ready():
  play("Down")

func _process(delta):
  var last_input = direction()
  if last_input != "none":
    play(last_input)
  elif last_input == "none":
    stop()


func direction():
  for key in MOVEMENTS.keys():
    if Input.is_action_just_released(key):
      var i = last_direction.find(key)
      if i != -1:
        last_direction.remove(i)
    
    if Input.is_action_just_pressed(key):
      last_direction.append(key)
  if last_direction.size() > 0:
    var direction = last_direction[last_direction.size()-1]
    return MOVEMENTS[direction]
  else:
    return "none"