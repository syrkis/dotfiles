function todo
    cd ~/code/todo

    vim noah.txt

    if git diff --exit-code noah.txt
        echo "No changes in noah.txt."
    else
        git add noah.txt
        git commit -m "Update noah.txt" && git push || echo "Push failed."
    end

    cd -
end
