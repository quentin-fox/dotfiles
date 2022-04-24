function actions
	set -l git_url (git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git/\/actions/')
	if test -n "$git_url"
		open $git_url -a Safari
	else
		echo "Current directory is not a git repository."
	end
end
