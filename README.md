please-dont is a vim plugin that "indents" code in a way that you please shouldn't indent it.

# Usage
Please don't. 

Here's what the plugin can do though:
* By default, the plugin is disabled. Typing `:PleaseDont` in normal mode enables it.
* To disable it, type `:PleaseDo`
* By default, your brackets and semicolons will land on column 80. If you want to change that to some other value, you can add `let g:pleasedont_indent_col = <NUMBER>` to your `.vimrc`.

# Installation
* On Arch Linux: `pacaur -S vim-please-dont`
* On vanilla vim: 
```

git clone https://github.com/PawkyPenguin/vim-please-dont.git
cp vim-please-dont/please-dont/please-dont.vim ~/.vim/plugins
```
* On a system with some kind of vim plugin management installed (such as ![https://github.com/VundleVim/Vundle.vim](Vundle) or ![https://github.com/tpope/vim-pathogen](pathogen)), you hopefully already know what to do ;)

# TODO
* The indentation settings are not restored correctly when working with multiple buffers.
