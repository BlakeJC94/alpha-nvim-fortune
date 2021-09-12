# alpha-nvim-fortune
This is a very simple add-on for `alpha-nvim` by `@goolord`. It simple adds a
`fortune()` function for use in the plugin that generates a formatted quote at
the footer of the landing page when using the `dashboard` theme.

Only the `dashboard` theme is supported for now.

## Quick start
First follow the instructions at `https://github.com/goolord/alpha-nvim/`. To
add `alpha-nvim-fortune` with `Packer`, install the packages with the folloing
lines in your `init.lua`:

```lua
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'goolord/alpha-nvim',
        requires = {'BlakeJC94/alpha-nvim-fortune'},
        config = function() require("config.alpha") end,
    }
end)
```

Then in `.config/nvim/lua/config/alpha.lua`, use the following lines:
```lua

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Set header
dashboard.section.header.val = {
    -- "                                                     ",
    -- "                                                     ",
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
    -- "                                                     ",
    -- "                                                     ",
    -- "                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

-- Set footer
dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)
```
