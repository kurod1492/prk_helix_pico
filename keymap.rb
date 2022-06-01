# Initialize a Keyboard
kbd = Keyboard.new

# `split=` should happen before `init_pins`
kbd.split = true

# Caution!!!!
#   - Keyboard#mutual_uart_at_my_own_risk is experimental.
#     It may make the keyboard unstable and may break your chip
#   - Make sure to disconnect the TRS(TRRS) cable when you change
#     this configuration. Reconnect them after changing BOTH halves
#   - Keys RGB_xxx are working on partner half only using this option
kbd.mutual_uart_at_my_own_risk = true

# If your right hand the "anchor"
# kbd.set_anchor(:right)

# Initialize GPIO assign
#   Assuming you'er using a Sparkfun Pro Micro RP2040
kbd.init_pins(
  [ 4, 5, 6, 7 ],                # row0, row1,... respectively
  [ 29, 28, 27, 26, 22, 20, 23 ] # col0, col1,... respectively
)

# default layer should be added at first
kbd.add_layer :default, %i[
  KC_TAB    KC_Q      KC_W    KC_E  KC_R      KC_T     KC_NO  KC_NO   KC_Y      KC_U      KC_I      KC_O     KC_P      KC_BSPACE
  KC_LCTL   KC_A      KC_S    KC_D  KC_F      KC_G     KC_NO  KC_NO   KC_H      KC_J      KC_K      KC_L     KC_SCOLON KC_QUOTE
  KC_LSFT   KC_Z      KC_X    KC_C  KC_V      KC_B     KC_NO  KC_NO   KC_N      KC_M      KC_COMMA  KC_DOT   KC_SLASH  KC_ENTER
  KC_ESCAPE KC_ESCAPE KC_LALT KC_AT KC_LALT   lower    KC_SPC KC_SPC  raise     KC_RALT   KC_LEFT   KC_DOWN  KC_UP     KC_RIGHT
]
kbd.add_layer :raise, %i[
  KC_TAB    KC_Q      KC_W    KC_E  KC_R      KC_T     KC_NO  KC_NO   KC_Y      KC_U      KC_I      KC_O     KC_P      KC_BSPACE
  KC_LCTL   KC_A      KC_S    KC_D  KC_F      KC_G     KC_NO  KC_NO   KC_H      KC_J      KC_K      KC_L     KC_SCOLON KC_QUOTE
  KC_LSFT   KC_Z      KC_X    KC_C  KC_V      KC_B     KC_NO  KC_NO   KC_N      KC_M      KC_COMMA  KC_DOT   KC_SLASH  KC_ENTER
  KC_ESCAPE KC_ESCAPE KC_LALT KC_AT KC_LALT   lower    KC_SPC KC_SPC  raise     KC_RALT   KC_LEFT   KC_DOWN  KC_UP     KC_RIGHT
]
kbd.add_layer :lower, %i[
  KC_TAB    KC_Q      KC_W    KC_E  KC_R      KC_T     KC_NO  KC_NO   KC_Y      KC_U      KC_I      KC_O     KC_P      KC_BSPACE
  KC_LCTL   KC_A      KC_S    KC_D  KC_F      KC_G     KC_NO  KC_NO   KC_H      KC_J      KC_K      KC_L     KC_SCOLON KC_QUOTE
  KC_LSFT   KC_Z      KC_X    KC_C  KC_V      KC_B     KC_NO  KC_NO   KC_N      KC_M      KC_COMMA  KC_DOT   KC_SLASH  KC_ENTER
  KC_ESCAPE KC_ESCAPE KC_LALT KC_AT KC_LALT   lower    KC_SPC KC_SPC  raise     KC_RALT   KC_LEFT   KC_DOWN  KC_UP     KC_RIGHT
]
#
#                   Your custom     Keycode or             Keycode (only modifiers)      Release time      Re-push time
#                   key name        Array of Keycode       or Layer Symbol to be held    threshold(ms)     threshold(ms)
#                                   or Proc                or Proc which will run        to consider as    to consider as
#                                   when you click         while you keep press          `click the key`   `hold the key`
kbd.define_mode_key :ALT_AT,      [ :KC_AT,                :KC_LALT,                     150,              150 ]
kbd.define_mode_key :CTL_EQ,      [ :KC_EQUAL,             :KC_LCTL,                     150,              150 ]
kbd.define_mode_key :SPC_CTL,     [ %i(KC_SPACE KC_RCTL),  :KC_RCTL,                     150,              150 ]
kbd.define_mode_key :RAISE_ENT,   [ :KC_ENTER,             :raise,                       150,              150 ]
kbd.define_mode_key :LOWER_SPC,   [ :KC_SPACE,             :lower,                       150,              150 ]

# `before_report` will work just right before reporting what keys are pushed to USB host.
# You can use it to hack data by adding an instance method to Keyboard class by yourself.
# ex) Use Keyboard#before_report filter if you want to input `":" w/o shift` and `";" w/ shift`
#kbd.before_report do
#  kbd.invert_sft if kbd.keys_include?(:KC_SCOLON)
#  # You'll be also able to write `invert_ctl`, `invert_alt` and `invert_gui`
#end

# Initialize RGB class with pin, underglow_size, backlight_size and is_rgbw.
#rgb = RGB.new(
#  0,    # pin number
#  0,    # size of underglow pixel
#  32,   # size of backlight pixel
#  false # 32bit data will be sent to a pixel if true while 24bit if false
#)
#sleep 1
# Set an effect
#  `nil` or `:off` for turning off
#rgb.effect = :swirl
# Set an action when you input
#  `nil` or `:off` for turning off
#rgb.action = :thunder
# Append the feature. Will possibly be able to write `Keyboard#append(OLED.new)` in the future
#kbd.append rgb

# Initialize RotaryEncoder with pin_a and pin_b
#encoder_left = RotaryEncoder.new(21, 9)
#encoder_left.configure :left
# These implementations are still ad-hoc
#encoder_left.clockwise do
#  kbd.send_key :KC_PGDOWN
#end
#encoder_left.counterclockwise do
#  kbd.send_key :KC_PGUP
#end
#kbd.append encoder_left

#encoder_right = RotaryEncoder.new(21, 9)
#encoder_right.configure :right
# These implementations are still ad-hoc
#encoder_right.clockwise do
#  kbd.send_key :KC_DOWN
#end
#encoder_right.counterclockwise do
#  kbd.send_key :KC_UP
#end
#kbd.append encoder_right

kbd.start!
