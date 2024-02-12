extends Node2D

@export_enum("D-Pad", "JoyStick") var leftPadStyle: String
@export var mapAnalogToDpad = true
@export var visibleOnlyTouchscreen = true
@export var AnalogTapToShow = false

func _ready():
  $"leftPad/JoyStickLeft".mapAnalogToDpad = mapAnalogToDpad
  $"leftPad/JoyStickLeft".AnalogTapToShowContainer = get_parent()
  $"leftPad/JoyStickLeft".AnalogTapToShow = AnalogTapToShow

  var toEnable = "leftPad/DPad" if leftPadStyle=="D-Pad" else "leftPad/JoyStickLeft"
  var toDisable = "leftPad/JoyStickLeft" if leftPadStyle=="D-Pad" else "leftPad/DPad"
  enable_gamepad(toEnable)
  disable_gamepad(toDisable)

  if visibleOnlyTouchscreen and not DisplayServer.is_touchscreen_available():
    disable_gamepad("leftPad/DPad")
    disable_gamepad("leftPad/JoyStickLeft")

func enable_gamepad(node):
  get_node(node).visible = true
  get_node(node).position = Vector2(0, 0)

func disable_gamepad(node):
  get_node(node).visible = false
  get_node(node).position = Vector2(-1000, -1000)
