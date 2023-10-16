function slide
    set file $argv[1]
    set template ~/code/template/slide.tex
    set bibfile ~/Zotero/biblio/library.bib
    mkdir output
    pandoc $file -t beamer --template=$template --biblatex -o output/output.tex
    cd output
    pdflatex output.tex
    biber output.bcf
    pdflatex output.tex
    pdflatex output.tex
    mv output.pdf ../slide.pdf
    cd ..
    rm -rf output
end



# LaTeX commands
