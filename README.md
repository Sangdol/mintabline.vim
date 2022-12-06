Mintabline
===

Minimalist Tabline

![mintabline screenshot](/screenshots/mintablinev2.png)

This project is inspired by [tabline](https://github.com/Sangdol/tabline.vim).

Features
---

* Shows minimal characters with tab numbers.
* Shows the directory name of Neovim terminal buffers.
* Shows icons using [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) or [vim-devicons](https://github.com/ryanoasis/vim-devicons).

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
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
```

Please follow the installation guide of the plugins if icons don't show up.

Configuration 
---

### `g:mintabline_tab_max_chars`

You can set the tab name maximum length with `g:mintabline_tab_max_chars`, for example,

```vim
let g:mintabline_tab_max_chars = 15
```

This will cut the long tab names appending ellipsis.

![mintabline_tab_max_chars screenshot](/screenshots/mintabline_tab_max_chars.png)

The full name will be shown when the tab is active.

License
---

MIT

