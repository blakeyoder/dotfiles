# dotfiles
Let's not have a panic attack in the future

# `.vimrc`
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


# `Karabiner Elements`
To export your settings files for Karabiner-Elements, follow these steps:

1. Locate the Karabiner-Elements configuration folder. It's typically found at:

   ```
   ~/.config/karabiner
   ```

2. The main configuration file you'll want to export is:

   ```
   ~/.config/karabiner/karabiner.json
   ```

   This file contains your main Karabiner-Elements settings[2].

3. You may also want to export any custom complex modifications you've created. These are stored in:

   ```
   ~/.config/karabiner/assets/complex_modifications
   ```

4. To transfer these settings to a new machine:

   - Copy the entire `~/.config/karabiner` folder to the same location on the new machine[2].
   - If Karabiner-Elements is already installed on the new machine, replace its existing configuration folder with your copied one.

5. After copying the files, restart the Karabiner-Elements process on the new machine by running this command in Terminal[3]:

   ```
   launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
   ```

6. If you prefer to sync your settings automatically, you can create a symbolic link to store the configuration in a cloud-synced folder:

   ```
   mv ~/.config/karabiner ~/Dropbox/karabiner-config
   ln -s ~/Dropbox/karabiner-config ~/.config/karabiner
   ```

   Replace "Dropbox" with your preferred cloud storage service[3].

Remember to install Karabiner-Elements on the new machine before transferring the settings. Also, you may need to grant necessary permissions on the new machine for Karabiner-Elements to function properly[6].

Citations:
[1] https://github.com/pqrs-org/Karabiner-Elements
[2] https://karabiner-elements.pqrs.org/docs/json/location/
[3] https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/
[4] https://www.youtube.com/watch?v=VIZxSum1GwA
[5] https://www.reddit.com/r/mac/comments/s0strq/any_way_to_auto_backup_karabiner_elements_macros/
[6] https://github.com/pqrs-org/KE-complex_modifications/issues/572
[7] https://stackoverflow.com/questions/22943676/how-to-export-iterm2-profiles/23356086
[8] https://iterm2.com/documentation/2.1/documentation-preferences.html
