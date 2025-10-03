#
#   __ ___ _ _  / _(_)__ _   / _(_)__| |_
#  / _/ _ \ ' \|  _| / _` |_|  _| (_-< ' \
#  \__\___/_||_|_| |_\__, (_)_| |_/__/_||_|
#                    |___/

# {{{ globals

set -x GOPATH $HOME/go
set -x JDK_HOME /opt/homebrew/opt/java11/libexec/openjdk.jdk/Contents/Home
set -x VISUAL nvim
set -x EDITOR "$VISUAL"
set -x FZF_DEFAULT_COMMAND "fd --hidden --type f --exclude '.git/' --strip-cwd-prefix"
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x __DEV__ "true"
set -x CLOUDSDK_PYTHON python
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1

# required for fastlane
# see: https://docs.fastlane.tools/getting-started/ios/setup/

set -x LC_ALL "en_US.UTF-8"
set -x LANG "en_US.UTF-8"

# secrets are loaded in from conf.d/secrets.fish

# }}}
# {{{ path

# asdf

# note, brew path is installed done in /etc/conf.d/homebrew

set -x PATH $HOME/.asdf/shims $PATH # has to go first
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $ANDROID_HOME/emulator $PATH
set -x PATH $ANDROID_HOME/tools $PATH
set -x PATH $ANDROID_HOME/tools/bin $PATH
set -x PATH $ANDROID_HOME/platform-tools $PATH
set -x PATH /opt/homebrew/opt/libpq/bin $PATH
set -x PATH /usr/local/opt/zip/bin/ $PATH
set -x PATH /Applications/kitty.app/Contents/MacOS/ $PATH
set -x PATH ~/bin/ $PATH
set -x PATH /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin $PATH
set -x PATH ~/.rd/bin $PATH

# }}}
# {{{ dynamic env vars

set -x GITHUB_PACKAGE_TOKEN (gh auth token)

# }}}
# {{{ abbreviations 

abbr gpo 'git push -u origin (git branch --show-current)'
abbr glog 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# gcloud command line

source ~/.asdf/installs/gcloud/471.0.0/path.fish.inc

# }}}

# vi mode
fish_vi_key_bindings
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold green
      echo 'N'
    case insert
      set_color --bold blue
      echo 'I'
    case replace_one
      set_color --bold green
      echo 'R'
    case visual
      set_color --bold magenta
      echo 'V'
    case '*'
      set_color --bold red
      echo 'R'
  end
  echo ' '
  set_color normal
end
set fish_cursor_default block blink
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual underscore

# }}}
