# Config Files

Uses `stow` (installable with `brew install stow`) to manage symlinks to dotfile locations.

# Bootstrapping System

Get the `secrets.fish` file (not stored in git), and copy to `fish/.config/fish/conf.d/`

```sh
mkdir fish/.config/fish/conf.d
cp path/to/secrets.fish fisih/.config/fish/conf.d/secrets.fish
```

Ensure that the `secrets.fish` file has the `GITHUB_TOKEN` variable defined.

Then run `sh bootstrap.sh`. This script should be idempotent, so if any step fails, you can re-run the file again, and it should continue where it left off, skipping any steps that succeeded.

# Subsequent Updates

After the system has been bootstrapped, you can update any files in the `brew/.Brewfile`, and run `brew bundle install --global` to update packages.

This is preferred vs running `brew install <package-name>` so that the installed packages can be tracked.
