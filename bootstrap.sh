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

if [ -z $(xcode-select -p) ]
then
  warn 'XCode not installed. Please install from Mac App store or Apple Developer Resources'
  warn 'https://developer.apple.com/xcode/resources/'
  exit 1
fi

info 'XCode installation detected'

# install homebrew

if [ -z $(which brew) ]
then
  info 'Installing brew...'
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
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
)

stow -S "${STOW_DIRS[@]}"

if [ $SHELL != $(which fish) ]
then
  info 'Changing shell to fish'
  chsh -s $(which fish)
fi

if [ -d ~/.asdf ]
then
  info 'asdf installation detected'
else
  info 'Installing asdf'
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
fi

info 'Adding asdf plugins'

# first party plugins
asdf plugin add nodejs
asdf plugin add ruby

# communnity party plugins
asdf plugin add python https://github.com/danhper/asdf-python.git
asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin add lua https://github.com/Stratus3D/asdf-lua.git

info 'Installing global versions of asdf plugins'
asdf install
