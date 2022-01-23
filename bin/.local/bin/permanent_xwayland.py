#!/bin/python
from Xlib import display
import sys

if __name__ == "__main__":
    print("Starting XWayland...")

    try:
        disp = display.Display()
    except Exception as e:
        print(f"Error, {e}")
        sys.exit(127)

    print("All ok...")
    sys.exit(0)
