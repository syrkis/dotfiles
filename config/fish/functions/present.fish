function present
    if test (count $argv) -lt 1
        echo "Usage: present <file>"
        return 1
    end

    set file $argv[1]
    set template /Users/syrkis/.config/fish/functions/slide.tex

    if not test -e $file
        echo "File '$file' not found."
        return 1
    end

    # Extract title and process it
    set title (sed -n 's/^title: \(.*\)$/\1/p' $file | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr ' ' '_')

    if test -z "$title"
        echo "No title found in '$file'."
        return 1
    end

    mkdir -p output

    if not pandoc $file --template=$template -t beamer --slide-level=3 --metadata=link-citations:true --biblatex -o output/output.tex
        echo "Pandoc conversion failed."
        return 1
    end

    cd output

    cp ../*.{png,jpg,jpeg} .


    for img in *.png *.jpg *.jpeg
        if test -e $img
            convert "$img" -resize 1920x1080 -quality 75 "$img"
        end
    end

    pdflatex output.tex && biber output.bcf && pdflatex output.tex && pdflatex output.tex

    mv output.pdf "../$title.pdf"

    cd ../

    echo "Presentation created: $title.pdf"
    open "$title.pdf"
end

