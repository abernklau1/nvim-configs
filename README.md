# NeoVim Configurations

A repo containing my Neovim configurations as they are from the nvim base directory.

The old config contains the desired functionality, while the new config contains the desired organization.

The new config is extremely close to the desired functionality of the old config. The new config has an issue where, occasionally, when lsp detects an issue (warning or error) and I change from view mode to insert mode and vice versa, the line where the issue was detected changes. The actual location of the error does not change but for some reason nvim-lspconfig recognizes it elsewhere. 

This configuration is heavily inspired by LunarVim and its main goal is to include C++ support.

