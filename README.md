Mintabline
===

Minimalist Tabline

![mintabline screenshot](/screenshots/mintablinev3.png)

This project is inspired by [tabline](https://github.com/Sangdol/tabline.vim).

Features
---

* Shows minimal characters with tab numbers.
* Shows the directory name of Neovim terminal buffers.
* Shows icons using [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) or [vim-devicons](https://github.com/ryanoasis/vim-devicons).
* Enables you to configure maximum tab name length

Installation
---

Use your favorite vim plugin management tool, e.g., [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'sangdol/mintabline.vim'
```

### devicons

You can add icons with [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) or [vim-devicons](https://github.com/ryanoasis/vim-devicons).

If both plugins exist `nvim-web-devicons` takes precedence.

```vim
" Optionally add one of these
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
```

Please follow the installation guide of the plugins if icons don't show up.

Configuration
---

### `g:mintabline_tab_max_chars`

You can set the maximum length of tab names with `g:mintabline_tab_max_chars`.

For example,

```vim
let g:mintabline_tab_max_chars = 15
```

The full name will be shown when a tab is active.

### Tip: accessing tabs with keymaps

A simple vimscript can be used to configure keymaps to select tabs.

For example, the script below enables `Number + ,` to select a tab, i.e. you can type `1,` to select the first tab.

```vim
for i in range(1, 9)
  exec 'nnoremap ' .. i .. ', ' .. i .. 'gt'
endfor
```

License
---

MIT

