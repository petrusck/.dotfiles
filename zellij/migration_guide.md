# Migration Guide: Zellij Vim-Philosophy Keybindings

## What Changed

This configuration replaces Zellij's default keybindings with a scheme designed for EurKEY + Amethyst + macOS compatibility, following Vim conventions.

### Summary of Changes

| Category | Default Zellij | This Config |
|----------|---------------|-------------|
| Default mode | Normal | **Locked** (all keys pass through) |
| Quick actions | `Alt+key` shortcuts in Normal | **Removed** (all conflict with EurKEY) |
| Resize mode | `Ctrl+n` | `Ctrl+r` (**r**esize) |
| Move mode | `Ctrl+h` | `Ctrl+w` (vim **w**indow prefix) |
| Tmux mode | `Ctrl+b` | **Removed** (simplify) |
| Pane split down | `d` in Pane mode | `s` (vim `:split`) |
| Pane split right | `r` in Pane mode | `v` (vim `:vsplit`) |
| Search previous | `p` in Search mode | `N` (vim `N`) |
| Scroll to top | Not bound | `g` (vim `gg`) |
| Scroll to bottom | `Ctrl+c` in Scroll mode | `G` (vim `G`) |
| Smart focus | `Alt+h` / `Alt+l` | `H` / `L` in Pane mode |
| Tab reorder | `Alt+i` / `Alt+o` | `<` / `>` in Tab mode |
| Layout cycling | `Alt+[` / `Alt+]` | `Space` in Pane mode |
| Pane groups | `Alt+p` / `Alt+Shift+p` | `g` / `G` in Pane mode |
| Mouse toggle | Not bound | `m` in Session mode |

## Step-by-Step Migration

### 1. Prerequisites

**Add to your `.zshrc` or `.bashrc`:**

```sh
# Disable XON/XOFF flow control so Ctrl+s works for Zellij scroll mode
stty -ixon
```

This is required because `Ctrl+s` is used for Scroll mode, but by default the terminal interprets it as XOFF (freeze output). The `stty -ixon` command disables this.

After adding it, either restart your shell or run `stty -ixon` in your current session.

### 2. Apply the Configuration

If the setup script has already been run (`zellij/setup.sh`), the config is symlinked and takes effect on the next Zellij session. For an existing session, restart Zellij.

### 3. Learn in Layers

Don't try to learn everything at once. Focus on these groups in order:

**Day 1 -- The Gateway (Ctrl+g)**

The single most important thing to learn: `Ctrl+g` toggles between Locked and Normal mode.

| What You're Doing | Press |
|--------------------|-------|
| Using shell/vim normally | Nothing (you're in Locked mode) |
| Need to do something in Zellij | `Ctrl+g` to enter Normal mode |
| Done with Zellij commands | `Ctrl+g` to return to Locked mode |

Practice this until it's automatic. Everything else builds on this.

**Day 2 -- Pane Navigation (Ctrl+p)**

| Action | Keys | What You Already Know |
|--------|------|----------------------|
| Enter Pane mode | `Ctrl+g` then `Ctrl+p` | -- |
| Focus left/down/up/right | `h` / `j` / `k` / `l` | Same as Vim |
| New pane (auto) | `n` | -- |
| Split below | `s` | Like Vim `:split` |
| Split right | `v` | Like Vim `:vsplit` |
| Close pane | `x` | Like Vim `:close` |
| Fullscreen toggle | `f` | -- |
| Return to Normal | `Esc` or `Enter` | Like Vim |
| Return to Locked | `Ctrl+g` | Your gateway |

Typical flow: `Ctrl+g` -> `Ctrl+p` -> `v` (creates vertical split, auto-returns to Normal) -> `Ctrl+g` (back to Locked).

**Day 3 -- Tab Management (Ctrl+t)**

| Action | Keys | What You Already Know |
|--------|------|----------------------|
| Enter Tab mode | `Ctrl+g` then `Ctrl+t` | -- |
| Previous/next tab | `h` / `l` | Same as Vim |
| Go to tab 3 | `3` | Like Vim `3gt` |
| New tab | `n` | Same as Pane mode |
| Close tab | `x` | Same as Pane mode |
| Toggle last tab | `Tab` | Like Vim `Ctrl+^` |
| Rename tab | `r` | -- |
| Return to Normal | `Esc` or `Enter` | -- |

**Day 4 -- Scrollback & Search (Ctrl+s)**

| Action | Keys | What You Already Know |
|--------|------|----------------------|
| Enter Scroll mode | `Ctrl+g` then `Ctrl+s` | -- |
| Scroll up/down | `k` / `j` | Same as Vim |
| Half page up/down | `u` / `d` | Like Vim `Ctrl+u` / `Ctrl+d` |
| Full page up/down | `b` / `f` | Like Vim `Ctrl+b` / `Ctrl+f` |
| Top of scrollback | `g` | Like Vim `gg` |
| Bottom of scrollback | `G` | Like Vim `G` |
| Search | `/` or `s` | Like Vim `/` |
| Next/prev match | `n` / `N` | Same as Vim |
| Edit in $EDITOR | `e` | -- |
| Return to Normal | `Esc` or `Enter` | -- |

**Day 5 -- Resize & Move**

| Action | Keys | What You Already Know |
|--------|------|----------------------|
| Enter Resize mode | `Ctrl+g` then `Ctrl+r` | -- |
| Increase left/down/up/right | `h` / `j` / `k` / `l` | Same as Vim |
| Decrease (opposite) | `H` / `J` / `K` / `L` | Uppercase = reverse |
| Enter Move mode | `Ctrl+g` then `Ctrl+w` | Like Vim `Ctrl+w` |
| Move pane left/down/up/right | `h` / `j` / `k` / `l` | Like Vim `Ctrl+w H/J/K/L` |

**Day 6 -- Session & Advanced**

| Action | Keys |
|--------|------|
| Enter Session mode | `Ctrl+g` then `Ctrl+o` |
| Detach | `d` |
| Toggle mouse | `m` |
| Session manager | `w` |
| Layout manager | `l` |
| Plugin manager | `p` |
| Config viewer | `c` |

## Key Differences from Default Zellij

### No More Alt Shortcuts

The biggest change: there are **no** `Alt+key` quick shortcuts. In default Zellij, you could press `Alt+h` from Normal mode to move focus left without entering Pane mode. With EurKEY, `Alt+h` types `u` instead.

**Old workflow** (default Zellij):
```
Alt+h          -> move focus left (one step)
```

**New workflow** (this config):
```
Ctrl+g         -> enter Normal mode
Ctrl+p         -> enter Pane mode
h              -> move focus left
Esc            -> return to Normal
Ctrl+g         -> return to Locked
```

This is more keystrokes, but it is the only approach that works with EurKEY. The modal design compensates: once in Pane mode, you can press `h/j/k/l` repeatedly to navigate, then exit once.

### Resize Changed from Ctrl+n to Ctrl+r

| | Default | This Config |
|---|---|---|
| Key | `Ctrl+n` | `Ctrl+r` |
| Mnemonic | None (`n` doesn't relate to resize) | **r**esize |

If you have muscle memory for `Ctrl+n`, retrain to `Ctrl+r`. The mnemonic helps.

### Move Changed from Ctrl+h to Ctrl+w

| | Default | This Config |
|---|---|---|
| Key | `Ctrl+h` | `Ctrl+w` |
| Problem | `Ctrl+h` sends ASCII backspace (0x08) | None |
| Mnemonic | None | Vim **w**indow prefix (`Ctrl+w`) |

The default `Ctrl+h` binding is problematic because `Ctrl+h` is the ASCII backspace character. Many terminals and programs interpret it as backspace, causing unexpected behavior. `Ctrl+w` is the standard Vim prefix for window operations, making it a natural fit.

### Pane Splits: s/v Instead of d/r

| | Default | This Config | Vim Equivalent |
|---|---|---|---|
| Split below | `d` (down) | `s` (split) | `:split` |
| Split right | `r` (right) | `v` (vsplit) | `:vsplit` |

The Vim mnemonics are stronger: `s` for split and `v` for vertical split are deeply ingrained in Vim users.

### Search: N Instead of p for Previous Match

| | Default | This Config | Vim Equivalent |
|---|---|---|---|
| Next match | `n` | `n` | `n` |
| Previous match | `p` | `N` (Shift+n) | `N` |

Vim uses `n`/`N` for search direction. The default Zellij `p` for "previous" is intuitive in isolation but breaks Vim muscle memory.

## Removed Bindings

| Default Binding | What It Did | Replacement |
|-----------------|-------------|-------------|
| `Alt+h` / `Alt+l` | Move focus or tab left/right | `Ctrl+p` then `h`/`l` (pane) or `H`/`L` (cross-tab) |
| `Alt+j` / `Alt+k` | Move focus down/up | `Ctrl+p` then `j`/`k` |
| `Alt+n` | New pane | `Ctrl+p` then `n` |
| `Alt+f` | Toggle floating panes | `Ctrl+p` then `w` |
| `Alt+i` / `Alt+o` | Move tab left/right | `Ctrl+t` then `<`/`>` |
| `Alt+=` / `Alt+-` | Resize increase/decrease | `Ctrl+r` then `=`/`-` |
| `Alt+[` / `Alt+]` | Previous/next swap layout | `Ctrl+p` then `Space` (next only) |
| `Alt+p` | Toggle pane in group | `Ctrl+p` then `g` |
| `Alt+Shift+p` | Toggle group marking | `Ctrl+p` then `G` |
| `Ctrl+b` (Tmux mode) | All tmux-compatible bindings | Removed entirely |

## Cheat Sheet

Print or keep this nearby for the first week:

```
GATEWAY
  Ctrl+g        toggle Locked <-> Normal

MODE SWITCHES (from Normal)
  Ctrl+p        Pane             Ctrl+t        Tab
  Ctrl+r        Resize           Ctrl+s        Scroll
  Ctrl+w        Move             Ctrl+o        Session
  Ctrl+q        Quit

PANE (Ctrl+p)
  h/j/k/l       focus            H/L           focus (cross tab)
  n              new pane         s/v           split / vsplit
  S              stacked          x             close
  f              fullscreen       w             float toggle
  i              pin              g/G           group / mark
  Space          next layout      c             rename

TAB (Ctrl+t)
  h/l            prev/next        1-9           go to tab N
  n              new              x             close
  r              rename           Tab           toggle last
  </> (Shift)    reorder          b             break pane

RESIZE (Ctrl+r)
  h/j/k/l        increase         H/J/K/L       decrease
  =/+            increase all     -             decrease all

MOVE (Ctrl+w)
  h/j/k/l        move pane        n/Tab         cycle fwd
  p              cycle backward

SCROLL (Ctrl+s)
  j/k            line             d/u           half page
  f/b            full page        g/G           top/bottom
  e              edit in $EDITOR  s or /        search
  n/N            next/prev match

SESSION (Ctrl+o)
  d              detach           m             mouse toggle
  w              sessions         l             layouts
  p              plugins          c             config

RETURN
  Esc / Enter    back to Normal
  Ctrl+g         back to Locked
```
