function fuckfuck
    set file $argv[1]
    set template ~/code/template/slide.tex
    set output_dir (mktemp -d)

    # Convert from Markdown to PDF directly
    pandoc $file -t beamer --template=$template --biblatex --pdf-engine=pdflatex -o $output_dir/output.pdf

    # Check if PDF was successfully created
    if test -f $output_dir/output.pdf
        cp $output_dir/output.pdf ./slide.pdf
        open slide.pdf
    else
        echo "Error: Failed to generate PDF."
    end

    # Cleanup
    rm -rf $output_dir
end

