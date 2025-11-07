# Set the wallpaper
#feh --bg-scale /path/to/wallpaper.jpg &

# Start status bar
slstatus &

# Start dwm with dbus session
exec dbus-run-session dwm
