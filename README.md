# My .'s live here 🏡

- [aerospace](https://github.com/nikitabobko/AeroSpace)
- [alacritty](https://github.com/alacritty/alacritty)
- `/bin`: tmux plugins
- [fish](https://github.com/fish-shell/fish-shell)
- [ghostty](http://ghostty.org)
- [jj](https://jj-vcs.github.io/jj/latest/)
- [kitty](https://github.com/kovidgoyal/kitty)
- [nvim](https://github.com/neovim/neovim)
- [shkd](https://github.com/koekeishiya/skhd)
- [starship](https://github.com/starship/starship)
- [tmux](https://github.com/tmux/tmux)
- [yabai](https://github.com/koekeishiya/yabai)
- [zed](http://zed.dev/)
- zsh

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

- [ ] fix `tmux-cht.sh` keybind
