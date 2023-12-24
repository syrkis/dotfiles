function edit
    # file is the first argument
    set file $argv[1]
    # file path is current directory + file
    set file_path (pwd)/$file
    # Open Alacritty in fullscreen mode with nvim editing the file
    alacritty --option window.startup_mode=Fullscreen -e nvim $file_path
end
