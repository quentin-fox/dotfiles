#
#   __ ___ _ _  / _(_)__ _   / _(_)__| |_
#  / _/ _ \ ' \|  _| / _` |_|  _| (_-< ' \
#  \__\___/_||_|_| |_\__, (_)_| |_/__/_||_|
#                    |___/

# {{{ fundle

if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin 'barnybug-archive/docker-fish-completion'
fundle plugin 'lgathy/google-cloud-sdk-fish-completion'

fundle init

# }}}
# {{{ globals

set -x GOPATH $HOME/go
set -x JDK_HOME /opt/homebrew/opt/java11/libexec/openjdk.jdk/Contents/Home
set -x VISUAL nvim
set -x EDITOR "$VISUAL"
set -x NVIM_LISTEN_ADDRESS /tmp/nvim
set -x FZF_DEFAULT_COMMAND "fd --hidden --type f --exclude '.git/' --strip-cwd-prefix"
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x SHELL /bin/zsh
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
set -x PATH /opt/homebrew/bin $PATH

# }}}
# {{{ aliases

# -e option makes opening with enter use $EDITOR
alias nnn='nnn -e'

# }}}
# {{{ abbreviations 

abbr nf 'nvim (fzf)'
abbr gpo 'git push -u origin (git branch --show-current)'
abbr glog 'git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
abbr gmi 'go mod init github.com/quentin-fox/(basename (pwd))'
abbr wthr 'weather -c Toronto -C Canada'
abbr mins 'nvim ~/opensports/minutes/(date "+%F").md'

# }}}
# {{{ interactive mode settings
if isatty # running in interactive terminal, not just process
	# theme
	if defaults read -g AppleInterfaceStyle >/dev/null 2>/dev/null
		set -x THEME "dark"
		kitty @ --to unix:/tmp/mykitty set-colors --all --configured ~/.config/kitty/kitty-themes/themes/Dark.conf
	else
		set -x THEME "light"
		kitty @ --to unix:/tmp/mykitty set-colors --all --configured ~/.config/kitty/kitty-themes/themes/Light.conf
	end

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

	# asdf

	source ~/.asdf/asdf.fish

	# gcloud command line

	source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

end

# }}}
