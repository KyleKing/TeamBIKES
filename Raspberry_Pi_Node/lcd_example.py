#!/usr/bin/python
# Example using a character LCD connected to a Raspberry Pi or BeagleBone Black.
import time
import Adafruit_CharLCD as LCD

# Raspberry Pi pin configuration:
lcd_rs = 24  # 27 - yellow
lcd_en = 25  # 22 - green
lcd_d4 = 12  # 25 - blue
lcd_d5 = 13  # 24 - violet
lcd_d6 = 16  # 23 - grey
lcd_d7 = 19  # 27 - white
lcd_backlight = 4

# BeagleBone Black configuration:
# lcd_rs        = 'P8_8'
# lcd_en        = 'P8_10'
# lcd_d4        = 'P8_18'
# lcd_d5        = 'P8_16'
# lcd_d6        = 'P8_14'
# lcd_d7        = 'P8_12'
# lcd_backlight = 'P8_7'

# Define LCD column and row size for 16x2 LCD.
lcd_columns = 16
lcd_rows = 2

# Alternatively specify a 20x4 LCD.
# lcd_columns = 20
# lcd_rows = 4

# Initialize the LCD using the pins above.
lcd = LCD.Adafruit_CharLCD(lcd_rs, lcd_en, lcd_d4, lcd_d5, lcd_d6, lcd_d7,
                           lcd_columns, lcd_rows, lcd_backlight)

# # Print a two line message
# lcd.clear()
# lcd.message('Hello\nworld!')
# # Wait 5 seconds
# time.sleep(5.0)

# Demo showing the cursor.
# lcd.clear()
# lcd.show_cursor(True)
# lcd.message('Show cursor')

# time.sleep(5.0)

# Demo showing the blinking cursor.
# lcd.clear()
# lcd.blink(True)
# lcd.message('Blink cursor')

# time.sleep(5.0)

# Stop blinking and showing cursor.
# Stop blinking and showing cursor.
# lcd.show_cursor(False)
# lcd.blink(False)

# Demo scrolling message right/left.
# lcd.clear()
# message = 'Scroll'
# lcd.message(message)
# for i in range(lcd_columns-len(message)):
#         time.sleep(0.5)
#         lcd.move_right()
# for i in range(lcd_columns-len(message)):
#         time.sleep(0.5)
#         lcd.move_left()


def full_message(message):
    lcd.clear()
    # prints "some_var is smaller than 10"
    if "\n" not in message:
        if len(message) < lcd_columns:
            # Normal Method
            lcd.message(message)
            time.sleep(1.0)
            return False
        elif len(message) <= 2*lcd_columns:
            # Split into two rows
            # TODO make break at space, if possible
            first_line = message[:lcd_columns]
            second_line = message[lcd_columns:]
            lcd.message(first_line + "\n" + second_line)
            time.sleep(1.0)
            return True
        elif len(message) > 2*lcd_columns:
            # Brute force the message
            # FIXME the message seems to be split and breaks scroll
            lcd.message(message)
            for i in range(len(message)-lcd_columns):
                time.sleep(0.5)
                lcd.move_left()
            time.sleep(1.0)
            return True
        else:
            print "Something is wrong with the string length"
            return False
    else:
        lcd.message(message)
        return True

# Demo scrolling a longer message
full_message('Very long Message to Test Maximum String Allowed')
time.sleep(3.0)
full_message('Really Long Scroll Message')
time.sleep(3.0)
full_message('Short Message')

# Demo turning backlight off and on.
# lcd.clear()
# lcd.message('Flash backlight\nin 5 seconds...')
# time.sleep(5.0)
# Turn backlight off.
# lcd.set_backlight(0)
# time.sleep(2.0)
# Change message.
# lcd.clear()
# lcd.message('Goodbye!')
# Turn backlight on.
# lcd.set_backlight(1)
