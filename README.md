# dotfiles
Let's not have a panic attack in the future

To use the .vimrc file you've linked, follow these steps:

1. Download the .vimrc file from the GitHub repository.

2. Place the .vimrc file in your home directory. On Unix-based systems (macOS, Linux), this is typically:

   ```
   ~/.vimrc
   ```

   On Windows, it would be:

   ```
   C:\Users\YourUsername\_vimrc
   ```

3. Ensure you have Vim installed on your system. If not, install it using your system's package manager or download it from the official Vim website.

4. This particular .vimrc file uses Vundle as a plugin manager[1]. You'll need to install Vundle first:

   ```
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   ```

5. Open Vim and run the following command to install the plugins specified in the .vimrc:

   ```
   :PluginInstall
   ```

6. Restart Vim for all changes to take effect.

## Additional Notes

- This .vimrc file sets up various plugins and configurations, including NERDTree, ctrlp, and custom key mappings[1].
- It also configures specific settings for Ruby and JavaScript development[1].
- Make sure you have the necessary dependencies installed for the plugins to work correctly (e.g., git for Vundle).

If you encounter any issues or want to customize the configuration further, you can edit the .vimrc file directly. Remember to reload Vim or run `:source ~/.vimrc` after making changes.

Citations:
[1] https://github.com/blakeyoder/dotfiles/blob/master/.vimrc
