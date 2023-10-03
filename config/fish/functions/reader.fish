function reader
    echo -e "\033]50;SetProfile=Reader\a" # Switch to 'epy' profile
    epy $argv # Run the original epy command with any arguments passed to it
    echo -e "\033]50;SetProfile=Default\a" # Switch back to 'Default' profile
end

