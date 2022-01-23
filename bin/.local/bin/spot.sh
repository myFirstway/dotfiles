#!/bin/bash

# application="spotify.Spotify"

# if wmctrl -xl | grep "${application}" > /dev/null ; then
  # # Already running, raising to front
  # wmctrl -x -a "$application"
# fi

# GJS="
# const Main = imports.ui.main;
# var mw =
  # global.get_window_actors()
    # .map(w=>w.meta_window)
    # .find(mw=>mw.get_wm_class()==='Spotify');
# Main.activateWindow(mw)"

/usr/bin/gdbus call \
  --session \
  --dest org.gnome.Shell \
  --object-path /dev/ramottamado/DBusToFocus \
  --method dev.ramottamado.DBusToFocus.FocusWMClass "Spotify"
