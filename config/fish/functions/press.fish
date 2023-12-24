function press
    if test (count $argv) -lt 1
        echo "Usage: press <file>"
        return 1
    end

    set file $argv[1]
    set template_path /Users/syrkis/text/template
    set output (string replace -r ".md" ".pdf" $file)

    # Determine the type of document
    set title (sed -n 's/^title: \(.*\)$/\1/p' $file)
    set type (sed -n 's/^type: \(.*\)$/\1/p' $file)

    if test -z "$title"
        set document_type "letter"
    else if test "$type" = "slide"
        set document_type "slide"
    else
        set document_type "report"
    end

    switch $document_type
        case letter 
            # Letter processing
            sed '/—$/s/$/\\\\hfill\\\\today/' $file > .temp.md
            pandoc .temp.md -o $output \
                -V documentclass="article" \
                -V geometry="margin=3cm" \
                -V fontsize="12pt" \
                -V linestretch="1.5" \
                --template=$template_path/letter.tex
            open $output ; rm .temp.md

        case report
            # Report processing
            pandoc $file -o $output \
                -V author="Noah Syrkis" \
                -V documentclass="article" \
                -V geometry="margin=3cm" \
                -V fontsize="12pt" \
                -V date="\today" \
                -V linestretch="1.5" \
                --metadata=link-citations:true --biblatex \
                --template=$template_path/report.tex \
                -o temp.tex

            pdflatex temp.tex && biber temp.bcf && pdflatex temp.tex && pdflatex temp.tex

            mv temp.pdf $output
            open $output
            rm temp.*

        case slide
            # Slide presentation processing
            if not test -e $file
                echo "File '$file' not found."
                return 1
            end

            set title (sed -n 's/^title: \(.*\)$/\1/p' $file | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr ' ' '_')

            if test -z "$title"
                echo "No title found in '$file'."
                return 1
            end

            mkdir -p output

            pandoc $file --template=$template_path/slide.tex -t beamer \
                --slide-level=3 --metadata=link-citations:true --biblatex \
                -o output/output.tex

            pushd output
            cp ../*.{png,jpg,jpeg} .

            for img in *.png *.jpg *.jpeg
                if test -e $img
                    convert "$img" -resize 1920x1080 -quality 75 "$img"
                end
            end

            pdflatex output.tex && biber output.bcf && pdflatex output.tex && pdflatex output.tex
            mv output.pdf "../$title.pdf"
            popd
            open "$title.pdf"
    end
end
