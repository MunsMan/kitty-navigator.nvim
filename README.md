# NeoVim Kitty Navigator

The Motivation behind the PlugIn is to drop my TMux dependency and to move to [Kitty](https://sw.kovidgoyal.net/kitty/).
The PlugIn is inspired by [nvim-tmux-navigation](https://github.com/alexghergh/nvim-tmux-navigation) for the NeoVim part and [vim-kitty-navigator](https://github.com/knubie/vim-kitty-navigator) for the Kitten section.

## Usage

The plugIn provides the following default key mappings to move between NeoVim and Kitty Splits:

- `<ctrl-h>` → Left
- `<ctrl-j>` → Down
- `<ctrl-k>` → Up
- `<ctrl-l>` → Right

But it supports a simple interface for changing the default mappings, see [custom bindings](#custom-bindings) section below.

## Installation

### NeoVim

Just use you preferred package manager or installation method to add it to you config.

I'm using Lazy, which results into:

```lua
{
    "MunsMan/kitty-navigator.nvim",
}
```

For **Lazy Loading** on Keybinding use:

```lua
{
    "MunsMan/kitty-navigator.nvim",
    keys = {
        {"<C-h>", function()require("kitty-navigator").navigateLeft()end, desc = "Move left a Split", mode = {"n"}},
        {"<C-j>", function()require("kitty-navigator").navigateDown()end, desc = "Move down a Split", mode = {"n"}},
        {"<C-k>", function()require("kitty-navigator").navigateUp()end, desc = "Move up a Split", mode = {"n"}},
        {"<C-l>", function()require("kitty-navigator").navigateRight()end, desc = "Move right a Split", mode = {"n"}},
    },
}
```

### Kitty

To install the kitten, there are two ways:
One is to simply copy the two python files directly into `~/.config/kitty/`
   - `navigate_kitty.py`
   - `pass_keys.py`
Or you can add this step into your NeoVim Package Manager.
This automaticlly updates the binaries, when there is a package update.

This is the corresponding Lazy Config:

```lua
{
    "MunsMan/kitty-navigator.nvim",
    build = {
        "cp navigate_kitty.py ~/.config/kitty",
        "cp pass_keys.py ~/.config/kitty",
    },
}
```

Finally, you need to add the bindings into your kitty config (`~/.config/kitty/kitty.conf`).
This is in both cases nessesary.

    map ctrl+j kitten pass_keys.py neighboring_window bottom ctrl+j
    map ctrl+k kitten pass_keys.py neighboring_window top    ctrl+k
    map ctrl+h kitten pass_keys.py neighboring_window left   ctrl+h
    map ctrl+l kitten pass_keys.py neighboring_window right  ctrl+l

And allow remote access, otherwise NeoVim can't call back to Kitty.

```
allow_remote_control yes

# For Linux:
listen_on unix:@mykitty

# Other unix systems:
listen_on unix:/tmp/mykitty
```

## Custom Bindings

Custom Bindings can be passed as an option in NeoVim:

```lua
{
    "MunsMan/kitty-navigator.nvim",
    opts = {
        keybindings = {
            left = "<C-h>",
            down = "<C-n>",
            up = "<C-e>",
            right = "<C-l>",
        },
    },
}
```

Finally, you need to add the bindings into your kitty config (`~/.config/kitty/kitty.conf`).

    map ctrl+h kitten pass_keys.py neighboring_window bottom ctrl+h
    map ctrl+n kitten pass_keys.py neighboring_window top    ctrl+n
    map ctrl+e kitten pass_keys.py neighboring_window left   ctrl+e
    map ctrl+l kitten pass_keys.py neighboring_window right  ctrl+l
