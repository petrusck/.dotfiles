# Zellij Keybindings

Vim-philosophy keybindings for [Zellij](https://zellij.dev/) on macOS, designed to coexist with the EurKEY keyboard layout and Amethyst window manager.

## Design Principles

1. **No Alt/Opt shortcuts** -- the entire Alt layer is reserved by EurKEY for European characters
2. **Ctrl+key for mode switches** -- the only modifier available in a terminal context
3. **Bare keys within modes** -- once in a sub-mode, single keypresses perform actions
4. **Vim HJKL everywhere** -- consistent directional navigation across all modes
5. **Mnemonic action keys** -- n=new, x=close, s=split, v=vsplit, f=fullscreen, etc.
6. **Locked by default** -- all keystrokes pass through to the terminal until you explicitly enter Normal mode

## Modal Workflow

Zellij is modal, similar to Vim. The default mode is **Locked** (all keys go to your shell/editor). You explicitly enter **Normal** mode to access Zellij commands, then enter sub-modes for specific operations.

```
Locked ──Ctrl+g──> Normal ──Ctrl+key──> Sub-mode ──action keys──> ...
   ^                  |                     |
   └────Ctrl+g────────┘                     |
                      ^                     |
                      └───Esc/Enter─────────┘
```

### Why Locked by Default?

When running Vim, Neovim, or other TUI applications inside Zellij, you want zero interference from the multiplexer. Locked mode ensures every keystroke reaches your application. You only activate Zellij when you need it.

## Mode-Switch Keys

These are available in all modes except Locked (and the target mode itself):

| Key | Mode | Mnemonic |
|-----|------|----------|
| `Ctrl+g` | Toggle Locked <-> Normal | **g**o (gateway) |
| `Ctrl+p` | Pane | **p**ane |
| `Ctrl+t` | Tab | **t**ab |
| `Ctrl+r` | Resize | **r**esize |
| `Ctrl+s` | Scroll | **s**croll |
| `Ctrl+w` | Move | **w**indow (vim `Ctrl+w`) |
| `Ctrl+o` | Session | **o**perations |
| `Ctrl+q` | Quit | **q**uit |

### Why These Ctrl Keys?

| Key | Why | Conflict? |
|-----|-----|-----------|
| `Ctrl+g` | No macOS binding, no shell binding, rarely used by any program | None |
| `Ctrl+p` | Standard Zellij. Shell `Ctrl+p` = previous history, but irrelevant in Normal mode | Acceptable |
| `Ctrl+t` | Standard Zellij. Shell `Ctrl+t` = transpose chars, but irrelevant in Normal mode | Acceptable |
| `Ctrl+r` | Mnemonic for **r**esize (replaces default `Ctrl+n`). Shell `Ctrl+r` = reverse search | Acceptable |
| `Ctrl+s` | Standard Zellij. Requires `stty -ixon` in shell config to disable XOFF | Requires shell config |
| `Ctrl+w` | Vim `Ctrl+w` = window operations. Replaces default `Ctrl+h` which sends backspace | Better than default |
| `Ctrl+o` | Standard Zellij. Shell `Ctrl+o` = execute-and-get-next, rarely used | Acceptable |
| `Ctrl+q` | Standard Zellij quit. Safe because Locked mode prevents accidental presses | Safe |

### Changes from Zellij Defaults

| Default | This Config | Why |
|---------|-------------|-----|
| `Ctrl+n` -> Resize | `Ctrl+r` -> Resize | **r**esize is mnemonic; `n` is not |
| `Ctrl+h` -> Move | `Ctrl+w` -> Move | `Ctrl+h` sends backspace (ASCII 0x08); `Ctrl+w` matches vim window prefix |
| `Ctrl+b` -> Tmux | Removed | Tmux compatibility mode removed to simplify |
| `Alt+*` shared bindings | Removed | ALL conflict with EurKEY European character input |

## Keybinding Reference

### Locked Mode

| Key | Action |
|-----|--------|
| `Ctrl+g` | Switch to Normal mode |

All other keystrokes pass through to the terminal application.

### Shared (All Modes Except Locked)

| Key | Action |
|-----|--------|
| `Ctrl+g` | Switch to Locked mode |
| `Ctrl+q` | Quit Zellij |
| `Esc` / `Enter` | Return to Normal mode (from any sub-mode) |

### Pane Mode (`Ctrl+p`)

#### Navigation

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `h` / `Left` | Focus pane left | `h` |
| `j` / `Down` | Focus pane down | `j` |
| `k` / `Up` | Focus pane up | `k` |
| `l` / `Right` | Focus pane right | `l` |
| `H` (Shift) | Focus left (crosses tab boundary) | Smart nav |
| `L` (Shift) | Focus right (crosses tab boundary) | Smart nav |
| `p` | Cycle focus between panes | `Ctrl+w p` |

#### Creation

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `n` | New pane (auto direction) -> Normal | `:new` |
| `s` | Split below (horizontal) -> Normal | `:split` |
| `v` | Split right (vertical) -> Normal | `:vsplit` |
| `S` (Shift) | New stacked pane -> Normal | -- |

#### Management

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `x` | Close focused pane -> Normal | `:close` |
| `f` | Toggle fullscreen -> Normal | `Ctrl+w o` |
| `w` | Toggle floating panes -> Normal | -- |
| `e` | Toggle embed/floating -> Normal | -- |
| `z` | Toggle pane frames -> Normal | -- |
| `i` | Toggle pane pinned -> Normal | -- |
| `c` | Rename pane (enter text) | -- |

#### Groups

| Key | Action |
|-----|--------|
| `g` | Toggle pane in group |
| `G` (Shift) | Toggle group marking mode |

#### Layout

| Key | Action |
|-----|--------|
| `Space` | Cycle to next swap layout |

### Tab Mode (`Ctrl+t`)

#### Navigation

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `h` / `Left` / `k` / `Up` | Previous tab | `gT` |
| `l` / `Right` / `j` / `Down` | Next tab | `gt` |
| `1`-`9` | Go to tab N -> Normal | `Ngt` |
| `Tab` | Toggle last tab | `Ctrl+^` |

#### Management

| Key | Action |
|-----|--------|
| `n` | New tab -> Normal |
| `x` | Close tab -> Normal |
| `r` | Rename tab (enter text) |
| `s` | Toggle sync input to all panes -> Normal |

#### Reorder

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `<` (Shift+,) | Move tab left | -- |
| `>` (Shift+.) | Move tab right | -- |

#### Break Pane

| Key | Action |
|-----|--------|
| `b` | Break pane to new tab -> Normal |
| `]` | Break pane to new tab (right) -> Normal |
| `[` | Break pane to new tab (left) -> Normal |

### Resize Mode (`Ctrl+r`)

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `h` / `Left` | Increase left | `Ctrl+w <` |
| `j` / `Down` | Increase down | `Ctrl+w +` |
| `k` / `Up` | Increase up | `Ctrl+w -` |
| `l` / `Right` | Increase right | `Ctrl+w >` |
| `H` (Shift) | Decrease left | opposite |
| `J` (Shift) | Decrease down | opposite |
| `K` (Shift) | Decrease up | opposite |
| `L` (Shift) | Decrease right | opposite |
| `=` / `+` | Increase all | `Ctrl+w =` |
| `-` | Decrease all | -- |

Resize mode stays active (does not return to Normal) so you can press `h/l` repeatedly to fine-tune.

### Move Mode (`Ctrl+w`)

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `h` / `Left` | Move pane left | `Ctrl+w H` |
| `j` / `Down` | Move pane down | `Ctrl+w J` |
| `k` / `Up` | Move pane up | `Ctrl+w K` |
| `l` / `Right` | Move pane right | `Ctrl+w L` |
| `n` / `Tab` | Move pane forward (cycle) | -- |
| `p` | Move pane backward | -- |

### Scroll Mode (`Ctrl+s`)

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `j` / `Down` | Scroll down 1 line | `Ctrl+e` |
| `k` / `Up` | Scroll up 1 line | `Ctrl+y` |
| `d` | Half page down | `Ctrl+d` |
| `u` | Half page up | `Ctrl+u` |
| `f` / `PageDown` | Full page down | `Ctrl+f` |
| `b` / `PageUp` | Full page up | `Ctrl+b` |
| `g` | Scroll to top | `gg` |
| `G` (Shift) | Scroll to bottom | `G` |
| `e` | Edit scrollback in $EDITOR -> Normal | -- |
| `s` / `/` | Enter search mode | `/` |

### Search Mode (from Scroll via `s` or `/`)

#### Query Input

Type your search query, then:

| Key | Action |
|-----|--------|
| `Enter` | Confirm query, enter search navigation |
| `Ctrl+c` / `Esc` | Cancel search, return to Scroll |

#### Search Navigation (after confirming query)

| Key | Action | Vim Parallel |
|-----|--------|--------------|
| `n` | Next match (downward) | `n` |
| `N` (Shift) | Previous match (upward) | `N` |
| `j` / `Down` | Scroll down | `j` |
| `k` / `Up` | Scroll up | `k` |
| `d` | Half page down | `Ctrl+d` |
| `u` | Half page up | `Ctrl+u` |
| `f` / `PageDown` | Full page down | `Ctrl+f` |
| `b` / `PageUp` | Full page up | `Ctrl+b` |
| `c` | Toggle case sensitivity | `\c` / `\C` |
| `w` | Toggle wrap | -- |
| `o` | Toggle whole word | -- |
| `Esc` | Return to Scroll mode | -- |
| `Ctrl+s` | Return to Normal mode | -- |

### Session Mode (`Ctrl+o`)

| Key | Action |
|-----|--------|
| `d` | Detach (leave session running) |
| `m` | Toggle mouse mode |
| `w` | Session manager (floating plugin) -> Normal |
| `c` | Configuration viewer (floating plugin) -> Normal |
| `p` | Plugin manager (floating plugin) -> Normal |
| `l` | Layout manager (floating plugin) -> Normal |

### Rename Modes

#### Rename Tab (from Tab mode via `r`)

Type the new name, then:

| Key | Action |
|-----|--------|
| `Esc` | Cancel rename, return to Tab mode |
| `Ctrl+c` | Cancel, return to Normal mode |

#### Rename Pane (from Pane mode via `c`)

Type the new name, then:

| Key | Action |
|-----|--------|
| `Esc` | Cancel rename, return to Pane mode |
| `Ctrl+c` | Cancel, return to Normal mode |

## Why No Alt Shortcuts?

Zellij's defaults include many `Alt+key` shared shortcuts for quick actions from Normal mode:

| Default Binding | What It Would Type with EurKEY |
|-----------------|-------------------------------|
| `Alt+h` (focus left) | `u` (French u-grave) |
| `Alt+j` (focus down) | `u` (Spanish u-acute) |
| `Alt+k` (focus up) | `ij` (Dutch ij ligature) |
| `Alt+l` (focus right) | `o` (Danish o-stroke) |
| `Alt+n` (new pane) | `n` (Spanish n-tilde) |
| `Alt+f` (float toggle) | `e` (French e-grave) |
| `Alt+i` (move tab left) | `i` (French i-diaeresis) |
| `Alt+o` (move tab right) | `o` (German o-umlaut) |

Every single Alt combination produces a European character instead of the intended Zellij action. This is why **all** Alt bindings are removed and replaced with the modal Ctrl+key -> bare key workflow.

## EurKEY Compatibility

With `clear-defaults=true`, no Alt bindings exist. The full EurKEY character set is available at all times:

- **In Locked mode** (default): all keys go to the terminal, including all Alt+key European characters
- **In Normal/sub-modes**: only Ctrl+key and bare letter keys are used, never Alt

## Amethyst Compatibility

Amethyst uses `Opt+Cmd` (mod1) and `Opt+Cmd+Shift` (mod2). These modifiers are intercepted by macOS at the system level before reaching the terminal, so there is zero overlap with Zellij's Ctrl+key bindings.

| Layer | Modifier | Application |
|-------|----------|-------------|
| macOS system | `Opt+Cmd` / `Opt+Cmd+Shift` | Amethyst window manager |
| Terminal (Zellij) | `Ctrl+key` | Zellij mode switches |
| Terminal (Zellij sub-modes) | Bare keys | Zellij actions |
| Terminal (Locked mode) | All keys | Shell / Vim / TUI apps |
| Keyboard layout | `Alt/Opt+key` | EurKEY European characters |

## Required Shell Configuration

Add this to your shell config (`.zshrc` or `.bashrc`) to free `Ctrl+s` from flow control:

```sh
# Disable XON/XOFF flow control so Ctrl+s works for Zellij scroll mode
stty -ixon
```

Without this, pressing `Ctrl+s` freezes the terminal (XOFF) instead of entering Scroll mode.

## Cheat Sheet

```
Ctrl+g          toggle Locked <-> Normal

From Normal:
  Ctrl+p        Pane mode          Ctrl+t        Tab mode
  Ctrl+r        Resize mode        Ctrl+s        Scroll mode
  Ctrl+w        Move mode          Ctrl+o        Session mode
  Ctrl+q        Quit

Pane (Ctrl+p):
  h/j/k/l       focus              H/L           focus (cross tab)
  n              new pane           s/v           split / vsplit
  S              stacked pane       x             close
  f              fullscreen         w             float toggle
  e              embed/float        z             frames toggle
  i              pin toggle         p             cycle focus
  c              rename             g/G           group / mark
  Space          next layout

Tab (Ctrl+t):
  h/l            prev/next          n             new
  x              close              r             rename
  s              sync input         b             break pane
  [/]            break left/right   </> (Shift)   reorder
  1-9            go to tab N        Tab           toggle last

Resize (Ctrl+r):
  h/j/k/l        increase           H/J/K/L       decrease
  =/+            increase all       -             decrease all

Move (Ctrl+w):
  h/j/k/l        move pane          n/Tab         cycle
  p              move backward

Scroll (Ctrl+s):
  j/k            line               d/u           half page
  f/b            full page          g/G           top/bottom
  e              edit in $EDITOR    s or /        search

Search (from Scroll):
  n/N            next/prev match    c             case toggle
  w              wrap toggle        o             whole word
  Esc            back to scroll

Session (Ctrl+o):
  d              detach             m             mouse toggle
  w              session manager    c             config
  p              plugin manager     l             layout manager
```

## Configuration File

The config file is located at `zellij/config.kdl` in this dotfiles repo and is symlinked to `~/.config/zellij/config.kdl` by the setup script.
