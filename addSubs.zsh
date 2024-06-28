#!/opt/homebrew/bin/zsh

dryRun=false

# Function to add submodule (dry run version)
add_submodule() {
	local dir="$1"
	local url=$(git -C "$dir" config --get remote.origin.url)
	local modulepath=$(readlink -f "$dir" | sed "s|$PWD/||")

	if [ -z "$url" ]; then
		echo "No remote URL found for $dir. Skipping."
		return
	fi

	echo "Checking if submodule $modulepath is already registered."

	# Check if the submodule is already registered
	if git config --file .gitmodules --get-regexp path | grep -q "$modulepath"; then
		echo "Submodule $modulepath is already registered. Skipping."
		return
	fi

	# Check if the directory already exists in the index
	if git ls-files --error-unmatch "$modulepath" >/dev/null 2>&1; then
		if [ "$dryRun" = true ]; then
			echo "Removing $modulepath from the index." >>testrun.txt
		else
			echo "Removing $modulepath from the index."
			git rm -r --cached "$modulepath"
		fi
	fi

	# Dry run: print the command instead of executing it
	if [ "$dryRun" = true ]; then
		echo "Would add submodule: git submodule add \"$url\" \"$modulepath\"" >>testrun.txt
		return
	fi
	# Uncomment the next line for actual run
	git submodule add "$url" "$modulepath"
}

# Main script
main() {
	local base_dir="$PWD"

	# Clear the test run file
	echo -n "" >testrun.txt

	# Find all .git directories (excluding the main project's .git directory)
	find "$base_dir" -type d -name .git | while read git_dir; do
		repo_dir=$(dirname "$git_dir")

		# Skip if this is the main project's .git directory
		if [ "$repo_dir" = "$base_dir" ]; then
			continue
		fi

		echo "Checking submodule for $repo_dir"
		add_submodule "$repo_dir"
	done

	if [ "$dryRun" = true ]; then
		echo "Dry run complete. Review the commands in testrun.txt."
	else
		echo "Run complete."
	fi
}

main
