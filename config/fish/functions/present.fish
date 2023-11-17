function present
    set file $argv[1]
    set template ~/code/template/slide.tex
    mkdir output
    pandoc $file -t beamer --template=$template --biblatex -o output/output.tex
    cd output
    pdflatex output.tex
    biber output.bcf
    pdflatex output.tex
    pdflatex output.tex
    mv output.pdf ../output.pdf
    cd ..
    rm -rf output
    open output.pdf
end



# LaTeX commands
