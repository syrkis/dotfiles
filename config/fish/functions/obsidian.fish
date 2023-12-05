function obsidian
    set file_path (realpath $argv[1])
    if test -e $file_path
        ln -sf $file_path ~/text/writing/open_file.md
        open "obsidian://open?vault=writing&file=open_file.md"
    else
        echo "File does not exist."
    end
end

