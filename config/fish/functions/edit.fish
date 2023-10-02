function edit
    set file_path (realpath $argv[1])
    if test -e $file_path
        set file_name (basename $file_path)
        ln -sf $file_path ~/text/cache/$file_name
        open -a "Obsidian" ~/text/cache/$file_name
    else
        echo "File does not exist."
    end
end

