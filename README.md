# geminicli.nvim

> **Floating Gemini CLI terminal for Neovim** — toggle the Gemini CLI in a centered floating terminal window with a simple keybinding.  
> Seamlessly open, hide, and resume your Gemini CLI session without leaving Neovim.

---

## Features

- Toggleable floating terminal running the Gemini CLI
- Persistent terminal session — hide and reopen without losing state
- Easy default keybinding: `Alt+g` (`<M-g>`) in normal and terminal modes
- Centered floating window with rounded borders and configurable size
- Works with your current Neovim working directory

---

## Screenshot

![geminicli.nvim screenshot](https://raw.githubusercontent.com/baldimario/geminicli/refs/heads/main/screenshot.png)

## Installation

Use your favorite plugin manager. Example with [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  "baldimario/geminicli.nvim",
  lazy = false,
  config = function()
    require("geminicli").setup({
      keymap = "<M-g>", -- default, can be changed
    })
  end,
}
```

Or with [packer.nvim](https://github.com/wbthomason/packer.nvim):
```
use {
  "baldimario/geminicli.nvim",
  config = function()
    require("geminicli").setup()
  end,
}
```

## Usage

- Press `Alt+g` (or your configured key) in **normal mode** to open or toggle the Gemini CLI floating terminal.
- Press `Alt+g` inside the terminal (terminal mode) to toggle it off or on.
- The Gemini CLI runs inside Neovim — no need to switch windows or terminals.

You can also run the command manually:
```vim
:GeminiRun
```

## Configuration

Call `require("geminicli").setup()` with optional settings:

| Option   | Default   | Description                       |
| -------- | --------- | --------------------------------- |
| `keymap` | `"<M-g>"` | Keybinding to toggle the terminal |
Example:
```lua
require("geminicli").setup({
  keymap = "<leader>gm", -- change toggle key
})
```

## Development

Contributions and feedback welcome!  
Feel free to open issues or pull requests on GitHub.

## License

MIT License © Mario Baldi
