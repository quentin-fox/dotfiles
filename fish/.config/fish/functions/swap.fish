function swap -a file1 file2 -d "Swap the contents of two files"
	set -l TMPFILE tmp.$fish_pid
	mv "$file1" $TMPFILE && mv "$file2" "$file1" && mv $TMPFILE "$file2"
end
