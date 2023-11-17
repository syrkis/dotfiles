function print
    set file $argv[1]
    set bibfile ~/text/Zotero/biblio/library.bib
    set output (string replace -r ".md" ".pdf" $file)

    # Create the temporary header file with two empty lines before the "References" heading

    # Concatenate the original markdown file with the header file and pass it to pandoc
    pandoc $file --bibliography=$bibfile --citeproc -o $output \
        -V author="Noah Syrkis" \
        -V documentclass="article" \
        -V geometry="margin=3cm" \
        -V fontsize="12pt" \
        -V date="\today" \
        -V linestretch="1.5"
end
