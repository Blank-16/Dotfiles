In `tmux`, the **Leader Key** (formally called the **Prefix**) is the key combination you must press *before* any other command. It tells `tmux` to listen for a shortcut instead of passing the input to the terminal.

### The Leader Key
In the configuration provided, the leader key is **`Ctrl + a`** (written as `C-a`). 

* **Default:** The `tmux` default is `Ctrl + b`.
* **Reason for Change:** `Ctrl + a` is more ergonomic (easier to reach on the home row) and is the standard for the older `screen` utility.

---

### Key Binding Breakdown

To use these, press `Ctrl + a`, release them, and then immediately press the next key.

| Binding | Action | Description |
| :--- | :--- | :--- |
| **`Prefix + h/j/k/l`** | **Pane Navigation** | Uses Vim direction keys to move focus between split panes (Left, Down, Up, Right). |
| **`Prefix + r`** | **Reload Config** | Re-reads the `.tmux.conf` file so changes take effect without restarting the session. |
| **`Prefix + c`** | **New Window** | Creates a new tab/window in the current session. |
| **`Prefix + 1, 2, 3...`**| **Switch Window** | Jumps directly to the window assigned to that number. |
| **`Prefix + %`** | **Vertical Split** | Splits the current pane into two side-by-side. |
| **`Prefix + "`** | **Horizontal Split**| Splits the current pane into top and bottom. |
| **`Prefix + z`** | **Zoom** | Toggles the current pane to full screen and back. |
| **`Prefix + [`** | **Copy Mode** | Enters "Vim mode" where you can scroll up and copy text using `v` and `y`. |
| **`Prefix + Ctrl + s`**| **Manual Save** | (Via `resurrect`) Saves your current session state to disk. |
| **`Prefix + Ctrl + r`**| **Manual Restore** | (Via `resurrect`) Restores your last saved session after a WSL reboot. |
| **`Prefix + Shift + i`**| **Install Plugins**| (Via `tpm`) Downloads and activates the plugins listed in your config. |

### Copy Mode (Vim Style)
Once you are in Copy Mode (`Prefix + [`):
* Use **`v`** to start selecting text.
* Use **`y`** to yank (copy) the text. 
* Because of the `clip.exe` binding, the text is automatically sent to your **Windows Clipboard**, so you can paste it into a browser or Windows app with `Ctrl + v`.
