kbd = Keyboard.new
kbd.split = true
#kbd.uart_pin = 1
#kbd.mutual_uart_at_my_own_risk = true
#kbd.set_anchor(:right)
kbd.init_pins(
  [ 4, 5, 6, 7 ],                # row0, row1,... respectively
  [ 29, 28, 27, 26, 22, 20, 23 ] # col0, col1,... respectively
)

# default layer should be added at first
kbd.add_layer :default, %i[
  KC_TAB    KC_Q    KC_W    KC_E  KC_R   KC_T  KC_NO  KC_NO    KC_Y  KC_U    KC_I     KC_O    KC_P      KC_BSPACE
  KC_LCTL   KC_A    KC_S    KC_D  KC_F   KC_G  KC_NO  KC_NO    KC_H  KC_J    KC_K     KC_L    KC_SCOLON KC_QUOTE
  KC_LSFT   KC_Z    KC_X    KC_C  KC_V   KC_B  KC_NO  KC_NO    KC_N  KC_M    KC_COMMA KC_DOT  KC_SLASH  KC_RSFT
  KC_ESCAPE KC_LGUI KC_LALT KC_AT STATS  LOWER KC_SPC KC_ENTER RAISE KC_RALT KC_LEFT  KC_DOWN KC_UP     KC_RIGHT
]
kbd.add_layer :raise, %i[
  KC_TAB    KC_EXLM KC_AT   KC_HASH KC_DLR KC_PERC KC_NO  KC_NO    KC_AMPR KC_ASTR KC_LPRN  KC_RPRN  KC_LCBR   KC_RCBR
  KC_LCTL   KC_A    KC_S    KC_D    KC_F   KC_G    KC_NO  KC_NO    KC_LEFT KC_DOWN KC_UP    KC_RIGHT KC_SCOLON KC_QUOTE
  KC_LSFT   KC_Z    KC_X    KC_C    KC_V   KC_B    KC_NO  KC_NO    KC_N    KC_M    KC_COMMA KC_DOT   KC_SLASH  KC_RSFT
  KC_ESCAPE KC_LGUI KC_LALT KC_AT   STATS  KC_NO   KC_SPC KC_ENTER KC_NO   KC_RALT KC_LEFT  KC_DOWN  KC_UP     KC_RIGHT
]
kbd.add_layer :lower, %i[
  KC_TAB    KC_1    KC_2    KC_3  KC_4   KC_5  KC_NO  KC_NO    KC_6  KC_7    KC_8     KC_9    KC_0      KC_BSPACE
  KC_LCTL   KC_A    KC_S    KC_D  KC_F   KC_G  KC_NO  KC_NO    KC_H  KC_J    KC_K     KC_L    KC_SCOLON KC_QUOTE
  KC_LSFT   KC_Z    KC_X    KC_C  KC_V   KC_B  KC_NO  KC_NO    KC_N  KC_M    KC_COMMA KC_DOT  KC_SLASH  KC_RSFT
  KC_ESCAPE KC_LGUI KC_LALT KC_AT STATS  KC_NO KC_SPC KC_ENTER KC_NO KC_RALT KC_LEFT  KC_DOWN KC_UP     KC_RIGHT
]

kbd.define_mode_key :RAISE, [ nil, :raise, nil, nil ]
kbd.define_mode_key :LOWER, [ nil, :lower, nil, nil ]
kbd.define_mode_key :STATS, [ Proc.new { PicoRubyVM.print_alloc_stats }, nil, 300, nil ]
kbd.start!
