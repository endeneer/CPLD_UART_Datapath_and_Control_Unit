import pyautogui
import serial
ser = serial.Serial(port='COM3',baudrate=115200,timeout=0.2)

last_key = b''
last_key_combination = []
current_key = b''
current_key_combination = []

def unpack(current_key):
    if current_key ==  b'#':
        current_key_combination = [b'w', b'a']
    elif current_key == b'$':
        current_key_combination = [b'w', b'd']
    elif current_key == b'%':
        current_key_combination = [b's', b'a']
    elif current_key == b'&':
        current_key_combination = [b's', b'd']
    else:
        current_key_combination = [current_key]
    return current_key_combination

while True:
    try:
        current_key = ser.read()
        print(current_key)
        if current_key != last_key:
            current_key_combination = unpack(current_key)
            # First comparison:
            # compare last key combination with current key combination
            # if last key is null then nothing to keyUp
            if last_key != b'':
                for key in last_key_combination:
                    if key not in current_key_combination:
                        pyautogui.keyUp(key.decode("utf-8"))
                        last_key_combination.remove(key)
                    else:
                        # remove equal because redundant in second comparison
                        current_key_combination.remove(key)
            # second comparison:
            # compare current key combination with last key combination
            # if current key is null then nothing to keyDown
            if current_key != b'':
                for key in current_key_combination:
                    if key not in last_key_combination:
                        pyautogui.keyDown(key.decode("utf-8"))
                        last_key_combination.append(key)
            # finally save current key as last key for future comparison
            last_key = current_key
    except:
        ser.close()
        break
