## Swap CAPS & ESC

There's handy AUR packages for this:

* `interception-caps2esc`
* `caps2esc`

I used to use this, which only applies to X and not in VTs. Resume from suspend also reverts it for me.

`setxkbmap -option "caps:swapescape"`

Now I use udev to swap keys in the kernel, to make it permanent and consistent. For my keyboard I put the following in `/usr/lib/udev/hwdb.d/70-keyboard.hwdb`:

```
# Microsoft Natural Ergonomic Keyboard 4000
evdev:input:b0003v045Ep00DB*
 KEYBOARD_KEY_c022d=up                                  # zoomin
 KEYBOARD_KEY_c022e=down                                # zoomout
 KEYBOARD_KEY_70039=esc                                 # caps > esc
 KEYBOARD_KEY_70029=capslock                            # esc > caps
```

Then run:

* `sudo systemd-hwdb update`
* `sudo udevadm trigger`

For more info on remapping keys on Linux, see:

* https://wiki.archlinux.org/index.php/Keyboard_input
* https://wiki.archlinux.org/index.php/Map_scancodes_to_keycodes
