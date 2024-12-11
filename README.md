# config.nvim/

<a href="https://dotfyle.com/rywng/confignvim"><img src="https://dotfyle.com/rywng/confignvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/rywng/confignvim"><img src="https://dotfyle.com/rywng/confignvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/rywng/confignvim"><img src="https://dotfyle.com/rywng/confignvim/badges/plugin-manager?style=flat" /></a>

Minimalistic but fully functional neovim config, with full LSP and TS support and completion

Use lua plugins when possible, lazy load and byte-compile when possible, use neovim builtin features when possible.

Never override default keymap with different functionality.

## Install Instructions

 > Install requires latest neovim release. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:rywng/config.nvim ~/.config/rywng/config.nvim
NVIM_APPNAME=rywng/config.nvim/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=rywng/config.nvim/ nvim
```
