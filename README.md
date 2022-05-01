# Config Files

Uses `stow` (installable with `brew install stow`) to manage symlinks to dotfile locations.

To bootstrap, will need to brew bundle install, pointing to the Brewfile in `brew/Brewfile`, which will then install stow.

After the first run of `brew bundle install`, can run `stow` on the `brew`, so any changes are synced to the Brewfile.
