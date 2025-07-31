## philosophy (what sylvee is about)

sylvee is a neovim configuration garden — quiet, native-first, and gentle on the user.  
it doesn’t aim to reinvent workflows or wrap everything in custom abstractions.  
instead, it helps neovim bloom on its own terms.

this distro is for people who like:
- reading `:h` and discovering what neovim already offers
- lightweight setups that feel like extensions of the editor, not replacements
- clean logic written in plain lua, without deep plugin dependency chains
- configurations that don't sprawl — sylvee tries to stay compact and legible

sylvee treats neovim as something already powerful and elegant.  
it adds what’s needed, where it’s missing, and leaves the rest alone.  
like a mossy stone path: built with care, but letting nature take the lead.

## install

to use sylvee, you can clone the repository into your `~/.config/nvim` directory:

```sh
git clone https://github.com/comfysage/sylvee ~/.config/sylvee
```

(neovim will load it on launch, just like any other config)

for usage see [usage](#usage)

## requirements

- neovim 0.12 or newer (for vim.pack)
- a terminal with truecolor support (for nice themes)
- a nerd font (for icons, if enabled)
- git (for plugin management)
- fzf (for fuzzy searching)

###### optional tools

- ripgrep (for faster grep)

## usage

```sh
NVIM_APPNAME=sylvee nvim
```
