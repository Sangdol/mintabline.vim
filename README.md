Mintabline: Minimal Tabline
===

![mintabline screenshot](/screenshots/mintabline.png)

### Features

* Shows minimal characters with tab numbers.
* Shows the directory name of Neovim terminal buffers.
* Shows icons using [vim-devicons](https://github.com/ryanoasis/vim-devicons).

This project is inspired by [tabline](https://github.com/Sangdol/tabline.vim)

Installation
===

Use your favorite vim plugin management tool, e.g., [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'sangdol/mintabline'

" Optional to add icons
Plug 'ryanoasis/vim-devicons'
```

Please follow the installation guide of [vim-devicons](https://github.com/ryanoasis/vim-devicons#installation) if icons don't show up.

Configuration tip
===

A simple vimscript can be used to configure mappings to select tabs.

For example, the script below enables `Number + ,` to select a tab, i.e. type `1,` to select the first tab.

```vim
for i in range(1, 9)
  exec 'nnoremap ' .. i .. ', ' .. i .. 'gt'
endfor
```

License
===

MIT

