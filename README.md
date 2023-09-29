# Nvim-config

This is my neovim config based of what [The Primagen's](http://youtube.com/@ThePrimeagen) has.

The complete config is in LUA because neovim supports it as its scripting language.
You can also port the above to vim script if you please to.
The above is used and tested on macOS, although should not present any problems on linux based distros too.

### Prerequisite

1. Please know how to quit vim
2. Nvim v0.8+ 

### Setup

1. Install neovim using brew on macOS

```bash
brew install neovim
```

2. Neovim recognises your `~/.config/nvim` folder to look for configs.
3. `after` subfolder also is included in the run time paths.
4. Create the nvim config folder if you dont have it already.

```bash
mkdir ~/.config/nvim
```

1. clone the config and move it to your `.config/nvim`

```bash
cp -v ./nvim-config/* ~/.config/nvim
```

1. start neovim and let it setup it up itself.

```bash
nvim --version
nvim 
```
