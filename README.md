# My .'s live here 🏡

- [alacritty](https://github.com/alacritty/alacritty)
- `/bin`: tmux plugins
- [fish](https://github.com/fish-shell/fish-shell)
- [kitty](https://github.com/kovidgoyal/kitty)
- [nvim](https://github.com/neovim/neovim)
    * current
    * `nvim.bak` - old packer config
- [shkd](https://github.com/koekeishiya/skhd)
- [starship](https://github.com/starship/starship)
- [tmux](https://github.com/tmux/tmux)
- [yabai](https://github.com/koekeishiya/yabai)
- zsh
- [aerospace](https://github.com/nikitabobko/AeroSpace)

## GNU Stow

I am using `stow`to "apply" my configurations using symlinks.

Here are some of the most important commands:
- `stow <package>`: create a symlink for the `<package>` according to the directory structure of the repo
- `stow --target=<dir> <package>`: set the target to `<dir>` instead of using the parent of the stow directory (the `.dotfiles` dir)
- `stow --delete <package>`: remove the symlink of the `<package>`

Check out the [documentation](https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow), if you have a more advanced use-case.

## Convenience

You can also apply or delete all configurations using the makefile

- `make all`
- `make delete`

## Todo

- [ ] create a minimal nvim config
- [ ] fix `tmux-cht.sh` keybind
