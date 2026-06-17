# wezterm

A WSL-first WezTerm config built for Fedora on Windows.  
Tabs are banned. Panes are king. The terminal does exactly what you tell it.

---

## The Philosophy

This config was shaped by one environment (WSL2 + Fedora) and one goal: get out of the way.

That means:
- No tab bar. You do not need tabs when splits and quick windows exist.
- Every binding is a single chord. No leader key, no multi-step dances.
- The shell owns navigation. Ctrl+arrows move by words. Shift+Enter sends a real newline.
- Smart clipboard. Ctrl+C copies selected text; if nothing is selected, it sends SIGINT like normal.
- Full app compatibility. Alt+Enter is explicitly freed so broot can claim it. Fullscreen moves to F11.

---

## Features

**WSL integration**
Auto-detects your WSL Fedora domain, sets the user and default cwd, and makes it the default domain. One line of setup, zero manual switching.

**Precision windowing**
On launch, the terminal centers itself on your active monitor at 1800x970 with the title bar height subtracted so the outer window lands exactly at 970px. No guessing, no manual resize.

**MonoLisa at 11pt**
Clean, readable type at a size that fits dense work. Line height at 1.2 keeps things tight without overlap. Glyph warnings are silenced because you trust your font stack.

**Monokai (base16)**
High-contrast, warm, unapologetically 2009 in the best way. Works in any light.

**Custom cursor**
Blinking block in a distinct green (#007F47). 800ms blink rate. Easy to spot in a sea of text.

**Visual bell**
Audible bell is disabled. The visual bell fades in and out over 150ms with easing. A gentle pulse instead of a system beep.

**Scrollback buffer**
10 000 lines. Enough for long builds, verbose logs, and scrolling back through yesterday.

**Performance target**
Animation at 60fps, max framerate at 144. The terminal keeps up with your display.

---

## Keybindings

| Binding | Action |
|---|---|
| `Ctrl+Shift+W` | Close current pane (no confirm) |
| `Ctrl+Shift+}` | Focus next pane |
| `Ctrl+Shift+{` | Focus previous pane |
| `Ctrl+Shift+Enter` | Split pane right (50%) in home directory |
| `Ctrl+Shift+T` | New tab in home directory |
| `Ctrl+C` | Copy selection, or send SIGINT |
| `Ctrl+V` | Paste from clipboard |
| `Shift+Enter` | Send literal newline |
| `Ctrl+Left` | Move backward by word |
| `Ctrl+Right` | Move forward by word |
| `Ctrl+Backspace` | Delete previous word |
| `Ctrl+RightClick` | Open link under cursor |
| `F11` | Toggle fullscreen |

Note: `Alt+Enter` is unbound by default so broot can use it.

---

## Requirements

- WezTerm (any recent build with `config_builder` support)
- MonoLisa Nerd Font (install on the Windows side; the config reads from `C:\Windows\Fonts`)
- WSL2 with a Fedora distro (optional; works without WSL domains too)

---

## Installation

```bash
git clone git@github.com:Masalale/wezterm.git ~/.config/wezterm
```

On Windows, symlink or copy `.wezterm.lua` to `%USERPROFILE%\.wezterm.lua`:

```cmd
mklink %USERPROFILE%\.wezterm.lua %USERPROFILE%\source\repos\wezterm\.wezterm.lua
```

Restart WezTerm. The config reloads on every launch.

---

## Customisation

The config is a single file, heavily commented and sectioned. To change:

- **Font**: Swap the `wezterm.font("MonoLisa Nerd Font")` call and `font_dirs` path.
- **Color scheme**: Change the `color_scheme` value to any WezTerm built-in.
- **Window size**: Edit `target_width` and `target_height` in the `gui-startup` event.
- **Key bindings**: Add or remove entries in the `config.keys` table.

---

## Why no tab bar?

Tabs hide context. Panes show everything at once. If you need a new workspace, spawn a new OS window with your domain's default. The `gui-startup` handler will centre it automatically.

If you prefer tabs, set `config.enable_tab_bar = true`. Nothing else breaks.

---

## License

Public domain. Do whatever you want with it.
