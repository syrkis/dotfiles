function press
    set file $argv[1]
    set bibfile ~/Zotero/biblio/library.bib
    set output (string replace -r ".md" ".pdf" $file)
    pandoc $file --bibliography=$bibfile --citeproc -o $output
end
