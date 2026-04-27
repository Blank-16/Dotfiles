This cheat sheet assumes your **Leader Key** is `Ctrl + a` as configured in your `.tmux.conf`.

## 1. Essential Management
| Action | Binding | Description |
| :--- | :--- | :--- |
| **New Session** | `tmux new -s <name>` | Start a new named session from the terminal. |
| **Detach** | `Prefix + d` | Leave the session running in the background. |
| **Attach** | `tmux attach` | Re-enter the last active session. |
| **Reload Config** | `Prefix + r` | Apply changes made to `~/.tmux.conf`. |
| **Install Plugins**| `Prefix + I` | (Capital i) Fetch and install TPM plugins. |

---

## 2. Window Management (Tabs)
| Action | Binding | Description |
| :--- | :--- | :--- |
| **Create Window** | `Prefix + c` | Create a new window. |
| **Rename Window** | `Prefix + ,` | Rename the current window. |
| **Next/Prev** | `Prefix + n` or `p` | Cycle through windows. |
| **Go to Index** | `Prefix + [1-9]` | Jump to a specific window by number. |
| **Window List** | `Prefix + w` | Open an interactive menu of all windows. |
| **Kill Window** | `Prefix + &` | Close the current window and all its panes. |

---

## 3. Pane Management (Splits)
| Action | Binding | Description |
| :--- | :--- | :--- |
| **Vertical Split** | `Prefix + %` | Split pane into Left and Right. |
| **Horizontal Split**| `Prefix + "` | Split pane into Top and Bottom. |
| **Navigate** | `Prefix + h/j/k/l` | Move focus (Vim keys: Left, Down, Up, Right). |
| **Zoom** | `Prefix + z` | Toggle current pane to full screen and back. |
| **Close Pane** | `Prefix + x` | Close the focused pane. |
| **Resize** | `Prefix + arrow keys` | Hold Prefix and tap arrows to resize. |

---

## 4. Copy Mode & Persistence
| Action | Binding | Description |
| :--- | :--- | :--- |
| **Enter Copy Mode** | `Prefix + [` | Allows scrolling and Vim-style selection. |
| **Select / Copy** | `v` then `y` | (In Copy Mode) Select text and copy to Windows. |
| **Paste** | `Prefix + ]` | Paste text from the internal `tmux` buffer. |
| **Manual Save** | `Prefix + Ctrl + s`| Save session state to disk (Resurrect). |
| **Manual Restore** | `Prefix + Ctrl + r`| Restore session state from disk (Resurrect). |

---

## 5. Helpful CLI Commands
* **List sessions:** `tmux ls`
* **Kill session:** `tmux kill-session -t <name>`
* **Kill all servers:** `tmux kill-server` (Use this if `tmux` glitches; it wipes everything).

