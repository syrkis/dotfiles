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
            pandoc .temp.md -o /Users/syrkis/text/collator/$output \
                -V documentclass="article" \
                -V geometry="margin=3cm" \
                -V fontsize="12pt" \
                -V linestretch="1.5" \
                --metadata=link-citations:true --biblatex \
                --template=$template_path/letter.tex \
                -o temp.tex

            pdflatex temp.tex && biber temp.bcf && pdflatex temp.tex && pdflatex temp.tex

            # copy latex of .md to clipboard ([@name2000] should be \citet and @name200 \cite). We are on mac so use sed right
            cat .temp.md | sed -e 's/\[@\([^]]*\)\]/\\\cite{\1}/g' -e 's/@\([^ ]*\)/\\\citet{\1}/g' -e 's/\*\([^*]*\)\*/\\emph{\1}/g' | pbcopy

            mv temp.pdf /Users/syrkis/text/collator/$output

            open /Users/syrkis/text/collator/$output
            rm temp.* .temp.md

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

            mv temp.pdf /Users/syrkis/text/collator/$output
            open /Users/syrkis/text/collator/$output
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
            cp ../figures/*.{png,jpg,jpeg} .

            for img in *.png *.jpg *.jpeg
                if test -e $img
                    convert "$img" -resize 1920x1080 -quality 75 "$img"
                end
            end

            pdflatex output.tex && biber output.bcf && pdflatex output.tex && pdflatex output.tex
            mv output.pdf /Users/syrkis/text/collator/$title.pdf
            popd
            open /Users/syrkis/text/collator/$title.pdf
    end
end
