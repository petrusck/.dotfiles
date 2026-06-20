# Xcode Vimious Keybindings

Vim-aligned keybinding set for Xcode, designed to complement Xcode's built-in Vim Mode (Editor > Vim Mode).

## How It Works

Xcode's keybinding system has two layers:

1. **Menu Key Bindings** -- IDE-level actions (build, navigate, split editors, etc.) triggered by global keyboard shortcuts.
2. **Text Key Bindings** -- editor-level text manipulation actions (move cursor, delete, scroll, etc.) inherited from macOS's Cocoa text system and Xcode's own `IDEDefaultKeyBindings`.

Xcode's Vim Mode intercepts keystrokes in Normal, Visual, and (partially) Insert mode, handling standard Vim motions and operators. However, it does not override the Text Key Bindings layer for keys it doesn't claim, nor does it touch Menu Key Bindings at all. This keybinding set fills those gaps.

## What Xcode Vim Mode Already Handles

These standard Vim bindings work out of the box with Vim Mode enabled and require no customization:

### Normal Mode -- Motions and Operators

All standard motions (`h/j/k/l`, `w/b/e/W/B/E`, `0/$`, `^`, `gg/G`, `f/F/t/T`, `{/}`, `%`), operators (`d/c/y/p/P`), visual modes (`v/V/Ctrl-V`), text objects (`iw/aw`, `i"/a"`, `i(/a(`, etc.), `.` repeat, registers (`"a`-`"z`), macros (`q`), search (`/`, `?`, `n/N`, `*/#`), marks (`m`, `'`, `` ` ``), and `:` commands (limited subset).

### Normal Mode -- Ctrl-Key Bindings

| Binding | Action |
|---------|--------|
| `Ctrl-D` / `Ctrl-U` | Scroll half-page down / up |
| `Ctrl-F` / `Ctrl-B` | Scroll full page down / up |
| `Ctrl-E` / `Ctrl-Y` | Scroll one line down / up (cursor stays) |
| `Ctrl-O` / `Ctrl-I` | Jump list backward / forward |
| `Ctrl-A` / `Ctrl-X` | Increment / decrement number under cursor |
| `Ctrl-R` | Redo |
| `Ctrl-]` | Jump to definition |

### Normal Mode -- Window Management (Ctrl-W Prefix)

| Binding | Action |
|---------|--------|
| `Ctrl-W h/j/k/l` | Move focus to split left / down / up / right |
| `Ctrl-W s` | Split editor horizontally |
| `Ctrl-W v` | Split editor vertically |
| `Ctrl-W c` | Close current editor split |
| `Ctrl-W n` | Move to next editor |
| `Ctrl-W p` | Move to previous editor |
| `Ctrl-W =` | Equalize editor split sizes |

### Insert Mode (Handled by Vim Mode)

| Binding | Action |
|---------|--------|
| `Ctrl-W` | Delete word backward |
| `Ctrl-H` | Delete character backward |
| `Ctrl-R` | Insert from register |

## What Vimious Changes

### Text Key Bindings -- Disabled Overrides

Xcode's `IDEDefaultKeyBindings` defines several Emacs-derived bindings that shadow Vim Mode or conflict with standard Vim behavior. Vimious disables them by mapping to `noop:`:

| Binding | Xcode Default Action | Why Disabled |
|---------|---------------------|--------------|
| `Ctrl-J` | `joinParagraphs:` | Vim mode handles `J` (join lines) in Normal mode. In Insert mode, `Ctrl-J` should produce a newline, not join paragraphs. |
| `Ctrl-W` | `deleteToMark:` | Part of the Emacs mark-and-point system. Shadows Vim mode's `Ctrl-W` (delete word backward) in Insert mode. |
| `Ctrl-X` | Prefix for `Ctrl-X Ctrl-X` (`swapWithMark:`) and `Ctrl-X Ctrl-M` (`selectToMark:`) | Emacs mark-and-point system. Blocks Vim mode's `Ctrl-X` (decrement number) from firing immediately in Normal mode. |
| `Ctrl-Space` | `setMark:` | Emacs mark-and-point system. Not used in Vim. |

### Menu Key Bindings -- Editor Splits

Single-chord shortcuts for editor splits, complementing Vim mode's `Ctrl-W s` / `Ctrl-W v`:

| Binding | Action | Vim Equivalent |
|---------|--------|----------------|
| `Ctrl-S` | New editor pane below | `Ctrl-W s` (horizontal split) |
| `Ctrl-V` | New editor pane on right | `Ctrl-W v` (vertical split) |

### Menu Key Bindings -- GitHub Copilot Extension

The keybinding set carries over 11 GitHub Copilot for Xcode extension entries. These have no keyboard shortcuts assigned -- they exist so that the Copilot menu items remain functional under the Vimious keybinding set.

## Required Manual Steps

One Xcode default cannot be overridden via the `.idekeybindings` file and must be changed manually:

### Unbind Ctrl-6 from "Document Items"

Xcode binds `Ctrl-6` to the "Document Items" popup at the application level. In Vim, `Ctrl-^` (which is `Ctrl-6` on most keyboards) switches to the alternate (previous) file. While Xcode's Vim mode does not implement `Ctrl-^`, unbinding the popup frees the key for potential future use and avoids accidental triggers.

> Xcode > Settings > Key Bindings > search "Document Items" > click the shortcut field > press Delete to clear it.

## What Vimious Does NOT Change

Standard macOS Cocoa text bindings (`Ctrl-A`, `Ctrl-E`, `Ctrl-K`, `Ctrl-N`, `Ctrl-P`, `Ctrl-F`, `Ctrl-B`, `Ctrl-D`, `Ctrl-T`, `Ctrl-L`, `Ctrl-O`) are left untouched. In Normal mode, Vim mode intercepts most Ctrl-key combos before these fire. In Insert mode, these Emacs/Cocoa bindings remain available -- they are part of macOS's system-wide text editing and are not worth disabling since they do not conflict with any Vim Insert mode binding.

## Design Decisions

### Why `noop:` instead of remapping?

The four disabled bindings (`Ctrl-J`, `Ctrl-W`, `Ctrl-X`, `Ctrl-Space`) are Emacs holdovers with no Vim equivalent at the text-system level. Remapping them to a Vim action is not possible because Xcode's text binding selectors are Cocoa methods (`pageDown:`, `scrollLineUp:`, etc.), not Vim commands. Setting them to `noop:` cleanly neutralizes them and lets Vim mode's own handling take precedence.

### Why keep Ctrl-S and Ctrl-V as menu bindings?

Vim mode already handles `Ctrl-W s` and `Ctrl-W v` for splits. The single-chord `Ctrl-S` / `Ctrl-V` shortcuts are faster alternatives. `Ctrl-S` does not conflict with Vim (Vim has no default `Ctrl-S` binding -- it is commonly used for "save" outside of Vim). `Ctrl-V` does conflict with Vim's visual-block mode in Normal mode, but Xcode's menu bindings are lower priority than Vim mode's key interception, so `Ctrl-V` still enters visual-block mode in Normal mode. The menu binding only fires when Vim mode is not consuming the key (e.g., outside the editor or in Insert mode).

### Why not remap more IDE shortcuts?

Xcode is not a modal editor -- its IDE chrome (navigators, inspectors, debug area) is driven by `Cmd`-based shortcuts that don't conflict with Vim. The philosophy is: change only what actively interferes with Vim mode, and leave everything else at Xcode's defaults to avoid a maintenance burden when Xcode updates add new features or change command IDs.

## Configuration File

The keybinding set is located at `xcode/Vimious.idekeybindings` in this dotfiles repo and is symlinked to `~/Library/Developer/Xcode/UserData/KeyBindings/Vimious.idekeybindings` by the setup script.
