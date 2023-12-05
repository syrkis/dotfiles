function todo
    # Navigate to the repository
    set -l repo_path ~/text/todo
    cd $repo_path

    set -l remote_latest (git ls-remote origin HEAD | awk '{print $1}')
    set -l local_latest (git rev-parse HEAD)

    if test "$remote_latest" != "$local_latest"
        if not git pull
            echo "Failed to pull latest changes. Exiting."
            return 1
        end
    end

    # Open noah.txt in vim
    vim noah.txt

    # Check for changes in noah.txt specifically
    if test -n (git status noah.txt --porcelain)
        # Add only noah.txt to avoid committing unintended changes
        git add noah.txt

        # Commit and push the changes
        if git commit -m "Update noah.txt"
            echo "Changes committed. Pushing to remote."
            if not git push
                echo "Failed to push changes. Exiting."
                return 1
            end
        else
            echo "No changes to commit."
        end
    else
        echo "No changes in noah.txt."
    end

    # Return to the original directory
    cd -
end

