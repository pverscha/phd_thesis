rm -rf output
mkdir output

MD_FILES=$(find . -name "[0-9]*.md" | sed "s/\.\///" | sort -t "-" -k1,1n)


# --top-level-division=chapter will prepend chapter names with "Chapter"
pandoc \
  --pdf-engine=lualatex \
  --template latex.template \
  --top-level-division=part \
  --number-sections \
  --citeproc \
  -s \
  --include-before-body="1-front_page.front.tex" \
  --include-before-body="2-permission.front.tex" \
  --include-before-body="3-acknowledgements.front.tex" \
  --include-before-body="4-summary.front.tex" \
  --include-before-body="5-samenvatting.front.tex" \
  --include-before-body="6-publications_summary.front.tex" \
  --include-before-body="7-conferences_summary.front.tex" \
  --include-before-body="8-repositories_summary.front.tex" \
  --include-before-body="9-table_of_contents.front.tex" \
  $MD_FILES \
  -o thesis.pdf
