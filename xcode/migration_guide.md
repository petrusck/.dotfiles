# Migration Guide: Xcode Default to Vimious Keybindings

## What Changed

The Vimious keybinding set makes two categories of changes on top of Xcode's Default keybinding set:

**Disabled** -- 4 Emacs-derived text bindings that interfere with Vim mode:

| Binding | Was | Now |
|---------|-----|-----|
| `Ctrl-J` | Join paragraphs | Disabled (Vim `J` handles this in Normal mode) |
| `Ctrl-W` | Delete to Emacs mark | Disabled (Vim `Ctrl-W` deletes word in Insert mode) |
| `Ctrl-X` | Emacs mark prefix (`Ctrl-X Ctrl-X`, `Ctrl-X Ctrl-M`) | Disabled (Vim `Ctrl-X` decrements number) |
| `Ctrl-Space` | Set Emacs mark | Disabled (not used in Vim) |

**Added** -- 2 single-chord editor split shortcuts:

| Binding | Action |
|---------|--------|
| `Ctrl-S` | New editor pane below (horizontal split) |
| `Ctrl-V` | New editor pane on right (vertical split) |

If you were already using the Default keybinding set with Copilot and these split shortcuts (as configured in `Default.idekeybindings`), the Copilot entries and split bindings are preserved in Vimious. The only new behavior is the 4 disabled text bindings.

## Step-by-Step Migration

### 1. Run the setup script

The setup script symlinks `Vimious.idekeybindings` into Xcode's keybindings directory:

```sh
cd /path/to/dotfiles
./xcode/setup.sh
```

This creates:

```
~/Library/Developer/Xcode/UserData/KeyBindings/Vimious.idekeybindings
  -> /path/to/dotfiles/xcode/Vimious.idekeybindings
```

### 2. Activate the Vimious keybinding set

1. Open Xcode
2. Go to **Xcode > Settings > Key Bindings** (or `Cmd-,` then "Key Bindings" tab)
3. In the keybinding set dropdown (top of the panel), select **Vimious**

### 3. Enable Vim Mode

If not already enabled:

> **Editor > Vim Mode** (toggle the checkmark)

This can also be toggled from the Xcode Settings > Text Editing > Editing tab.

### 4. Unbind Ctrl-6 (manual step)

This is the one binding that cannot be set via the `.idekeybindings` file:

1. In **Xcode > Settings > Key Bindings**, search for **Document Items**
2. Click the shortcut field next to "Document Items" (it shows `Ctrl-6`)
3. Press **Delete** to clear it

This frees `Ctrl-6` (`Ctrl-^`), the standard Vim binding for switching to the alternate file.

### 5. Remove customizations from the Default keybinding set (optional)

If your `Default.idekeybindings` has the `Ctrl-S` / `Ctrl-V` split shortcuts and Copilot entries, those customizations are now redundant since Vimious includes them. You can reset the Default set to a clean state:

1. In **Xcode > Settings > Key Bindings**, select **Default** from the dropdown
2. Click the gear icon (bottom-left) > **Delete Customizations**

This only affects the Default set. Vimious is unaffected.

## Verifying It Works

After completing the steps above, test the following:

### Vim mode basics (should already work)

- Press `Esc` in the editor -- cursor should change to block (Normal mode)
- `h/j/k/l` -- moves cursor left/down/up/right
- `Ctrl-D` / `Ctrl-U` -- scrolls half-page down/up
- `Ctrl-W s` -- opens a horizontal split
- `Ctrl-W l` / `Ctrl-W h` -- moves focus between splits

### Disabled bindings (should do nothing)

- In Insert mode, press `Ctrl-J` -- should produce a newline or do nothing (not join paragraphs)
- In Normal mode, press `Ctrl-X` on a number -- should decrement it (not trigger an Emacs mark command)

### Added bindings

- `Ctrl-S` -- should open a horizontal editor split
- `Ctrl-V` -- should open a vertical editor split

## Troubleshooting

- **Keybindings not appearing in Xcode**: verify the symlink exists and points to the right file:
  ```sh
  ls -la ~/Library/Developer/Xcode/UserData/KeyBindings/Vimious.idekeybindings
  ```
- **Vimious not in the dropdown**: Xcode only scans the KeyBindings directory on launch. Quit and reopen Xcode.
- **Ctrl-J still joins paragraphs**: make sure Vimious (not Default) is selected as the active keybinding set. Check the dropdown in Xcode > Settings > Key Bindings.
- **Ctrl-6 still opens Document Items popup**: this requires the manual unbind step (step 4 above). It persists across keybinding sets because it is bound at the application level.
- **Copilot menu items missing**: if you installed the Copilot extension after creating Vimious, the extension entries may not be present. Re-run `setup.sh` or manually add them in Xcode > Settings > Key Bindings by searching for "GitHub Copilot".
