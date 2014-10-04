ch-walls
========

A simple shell script to switch between wallpapers from a specified directory on Gnome

###Getting it to work###
Edit the configuration section in wall.sh to set the path to the directory where the pictures for the wallpaper are present() and also the interval between switches. Also, ensure line 3 in wall.sh is left blank.

**Note**: Do not use environment variables such as $HOME and $USER in the directory path

Run the script with

```$sh wall.sh```

To stop the switching, run

```$sh wall.sh stop```


