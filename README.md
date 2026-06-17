# wezterm

> A terminal config that knows exactly what it wants.

WSL2 · Fedora · MonoLisa · green cursor · no tab bar.

![screenshot](screenshot.png)

## What makes it different

Tabs are hidden because panes show everything at once.
No leader key — every action is a single chord, so nothing is two steps deep.
Ctrl+C is smart: it copies the selection, or sends SIGINT when nothing is highlighted.
Ctrl+V pastes from the clipboard.
Ctrl+arrows skip words in the shell.
Shift+Enter sends a literal newline.

One chord per action. No leader sequences. No guesswork.

## Keys

![bindings](bindings.png)

## How it looks

The palette is Catppuccin Mocha on a darkened base (`#0f0f1a`), with one deliberate
break: the cursor is a blinking block in a custom green (`#007F47`) — easy to find in a
busy terminal. The background carries a faint texture (6% opacity) that adds depth
without distraction. The visual bell fades in and out with easing; the audible bell is
off.

The window launches centred on your active monitor at 1800×970, with the title-bar
height subtracted from the inner size so the outer frame lands where you expect.

## How it works

Built on WSL2 with a Fedora distro. The config picks the WSL domain, sets the user and
home directory, and makes it the default — no manual switching.

MonoLisa Nerd Font at 11pt, 1.2 line height. Glyph warnings are silenced because the
font is trusted.
Alt+Enter is unbound so broot can claim it; fullscreen moves to F11.
Scrollback holds 10,000 lines. Animation runs at 60 fps, max framerate 144.

## Get it

This is a Windows-hosted WezTerm config (note the `C:\` font and background paths) that
drives a WSL domain. Clone it on Windows:

```cmd
git clone git@github.com:Masalale/wezterm.git %USERPROFILE%\source\repos\wezterm
```

Then symlink the file where WezTerm looks for it:

```cmd
mklink %USERPROFILE%\.wezterm.lua %USERPROFILE%\source\repos\wezterm\.wezterm.lua
```

Restart WezTerm. The config reloads on every launch.

## Adjust it

Everything lives in one file, clearly sectioned. Change the font, swap the palette,
resize the window, add or drop bindings. The config-builder API means no surprises.
