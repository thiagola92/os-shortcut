# OSShortcut
Replicate Operating System key presses and release into Godot.

- ❌ MacOS
- Linux
	- ✔️ X11
	- ❌ Wayland
- ✔️ Windows

# Installation
- Download latest release
- Extract `addons` directory from ZIP
- Move `addons` directory to your project directory
  - If your project already have an `addons` directory, copy `addons/os_shortcut` to your project `addons`
- Open Godot project
- Go to `Project > Project Settings... > Plugins`
  - You should be seeing OSShortcut plugin there, otherwise something was done wrong
- Check `Enable` in OSShortcut plugin
- Restart Godot

# Usage
- Go to `Project > Project Settings... > Globals`
- Check `Enable` in OSShortcut Global
- Add a `Button` to your scene
- Add a `Shortcut` to your button
- Start scene
- Focus a window that is not from Godot
- Press the shortcut keys
- Check if the button was pressed

# Why
(11-fev-2025) Godot doesn't include any way to listen for key inputs when your window is not focus ([#7713](https://github.com/godotengine/godot-proposals/issues/7713)).  
Which makes sense, games don't have reason to listen for keystrokes, but I do like to use Godot for making GUI tools.  

Right now, I am making a PNGTuber and it's very important being able to switch between states in this type of tool.  
