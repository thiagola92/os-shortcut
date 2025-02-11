# OSShortcut
Simulates shortcuts by listen keystrokes from operating system.  

- ❌ MacOS
- Linux
	- ✔️ X11
	- ❌ Wayland
- ✔️ Windows

# Logic
When a key is pressed, we append the pressed key to an array.  
```gdscript
["A"]
```

When a key is released, we remove the pressed key from array.  
```gdscript
[]
```

Shortcuts are checked when a key is pressed.  
```gdscript
# Assume that we have `Ctrl+A` as shortcut.

[]
["Ctrl"] # Check `Ctrl+A`
["Ctrl", "A"] # Trigger `Ctrl+A`
["Ctrl"]
[]
```


Shortcuts are a combination of keys, where the order don't matter.  
```gdscript
# Assume that we have `Ctrl+A` as shortcut.

[]
["Ctrl"] # Check `Ctrl+A`
["Ctrl", "A"] # Trigger `Ctrl+A`
["Ctrl"]
[]
["A"] # Check `Ctrl+A`
["A", "Ctrl"] # Trigger `Ctrl+A`
```

The shortcut will trigger even when keys are pressed between the shortcut keys.  
```gdscript
# Assume that we have `Ctrl+A` as shortcut.

[]
["Ctrl"]
["Ctrl", "B"]
["Ctrl", "B", "Left"]
["Ctrl", "B", "Left", "A"] # Trigger `Ctrl+A`
```

Only the last key pressed can trigger shortcuts.  
```gdscript
# Assume that we have `Ctrl+A` and `Ctrl+T` as shortcuts.

[]
["Ctrl"]
["Ctrl", "T"] # Trigger `Ctrl+T`
["Ctrl", "T", "A"] # Trigger `Ctrl+A`
["Ctrl", "T"]
["Ctrl"]
```

# Why
(11-fev-2025) Godot doesn't include any way to listen for key inputs when your window is not focus ([#7713](https://github.com/godotengine/godot-proposals/issues/7713)).  
Which makes sense, games don't have reason to listen for keystrokes, but I do like to use Godot for making GUI tools.  

Right now, I am making a PNGTuber and it's very important being able to switch between states in this type of tool.  
