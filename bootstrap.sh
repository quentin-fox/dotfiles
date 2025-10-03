# helpers

function info() { echo '\033[1;32m'"$1"'\033[0m'; }
function warn() { echo '\033[1;33m'"$1"'\033[0m'; }
function error() { echo '\033[1;31mERROR: '"$1"'\033[0m'; }

info 'Install starting, you may be prompted to enter your password for sudo privileges.'

if [ -e fish/.config/fish/conf.d/secrets.fish ]
then
  info 'fish secret file detected'
else
  error 'Ensure the secrets.fish file has been copied to fish/.config/fish/conf.d/secrets.fish'
  exit 1
fi

if xcode-select --install
then
  info 'wait for command line utilities to finish installing'
  exit 1
fi

# install homebrew

if [ -z $(which brew) ]
then
  info 'Installing brew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  error "follow instructions for adding brew to path before continuing"
  exit 1
else
  info 'Brew already installed!'
fi

# install brew dependencies (including stow) by pointing directly to .Brewfile in repo
# this may affect the lockfile, but that's okay?

if brew bundle check --file brew/.Brewfile
then
  info 'Brew packages up to date.'
else
  info 'Installing brew packages from brewfile'
  brew bundle install --file brew/.Brewfile
fi

STOW_DIRS=(
  asdf
  brew
  fish
  git
  kitty
  nvim
  npm
  aerospace
)

stow -S "${STOW_DIRS[@]}"

if [ $SHELL != $(which fish) ]
then
  info 'Changing shell to fish'
  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)
fi

if [ -d ~/.asdf ]
then
  info 'asdf installation detected'
else
  info 'Installing asdf'
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
  source ~/.asdf
fi

info 'Adding asdf plugins'

# first party plugins
asdf plugin add nodejs
asdf plugin add ruby

# communnity party plugins
asdf plugin add python https://github.com/danhper/asdf-python.git
asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf plugin add gcloud https://github.com/jthegedus/asdf-gcloud
asdf plugin-add cue https://github.com/asdf-community/asdf-cue.git
asdf plugin-add gleam https://github.com/asdf-community/asdf-gleam.git
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add haskell https://github.com/vic/asdf-haskell.git
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git

info 'Installing global versions of asdf plugins'
asdf install
