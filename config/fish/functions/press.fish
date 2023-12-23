function print
    set file $argv[1]
    set bibfile ~/text/Zotero/biblio/library.bib
    set output (string replace -r ".md" ".pdf" $file)
    set template_path /Users/syrkis/.config/fish/functions

    # Check if the Markdown file contains a title
    set title (sed -n 's/^title: \(.*\)$/\1/p' $file)
    if test -z "$title"
        set template "letter.tex"
    else
        set template "article.tex"
    end

    # Create a temporary modified markdown file
    set temp_file (mktemp)
    sed '/—$/s/$/\\hfill\\textbf{\\today}/' $file > $temp_file

    # Pandoc command with conditional template
    pandoc $temp_file --bibliography=$bibfile --citeproc -o $output \
        -V author="Noah Syrkis" \
        -V documentclass="article" \
        -V geometry="margin=3cm" \
        -V fontsize="12pt" \
        -V date="\today" \
        -V linestretch="1.5" \
        --template=$template_path/$template
    open $output

    # Clean up temporary file
    rm $temp_file
end
