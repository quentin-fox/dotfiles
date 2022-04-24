function circle
	set -l repo_url (git config --get remote.origin.url | sed 's/\.git//' | sed 's/git@github.com:/https:\/\/app.circleci.com\/pipelines\/github\//')
	if test -n "$repo_url"
		open $repo_url -a Safari
	else
		echo "Current directory is not a git repository."
	end
end
