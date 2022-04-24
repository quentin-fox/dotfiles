function repo
	set -l git_url (git config --get remote.origin.url | sed 's/\.git//' | sed 's/git@github.com:/https:\/\/github.com\//')/tree/(git branch --show-current)
	if test -n "$git_url"
		open $git_url -a Safari
	else
		echo "Current directory is not a git repository."
	end
end
