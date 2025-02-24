# OSShortcut
Replicate Operating System key presses and release into Godot.

Currently working on:  
- Linux
	- ✔️ X11
	- ❌ Wayland
- ✔️ Windows
- ❌ MacOS

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
- Now Godot will receive key press/release when your window is not focused

Some Controls process inputs like key presses/releases, in this cases the user could accidentally trigger them when typing in another window. For example:  
- User click a `Button` in Godot window
- User click on another window
- User press ENTER while typing in another window
- `Button` will be pressed

To avoid this accident, it's highly recommended to set `OSShortcut.target_focus` to a `Control` which you want it to receive the inputs when the window lose focus.  

# Why
(11-fev-2025) Godot doesn't include any way to listen for key inputs when your window is not focus ([#7713](https://github.com/godotengine/godot-proposals/issues/7713)).  
Which makes sense, games don't have reason to listen for keystrokes, but I do like to use Godot for making GUI tools.  

Right now, I am making a PNGTuber and it's very important being able to switch between states in this type of tool.  

# References
- [OSListener](https://github.com/thiagola92/os-listener), GDExtension to listen key presses/releases
