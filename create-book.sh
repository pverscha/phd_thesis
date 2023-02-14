rm -rf output
mkdir output

MD_FILES=$(find . -name "[0-9]*.md" | sed "s/\.\///" | sort -t "-" -k1,1n)


# --top-level-division=chapter will prepend chapter names with "Chapter"
pandoc \
  --pdf-engine=lualatex \
  --top-level-division=part \
  --number-sections \
  --citeproc \
  --toc \
  -s \
  --include-before-body="1-acknowledgements.front.tex" \
  --include-before-body="2-summary.front.tex" \
  --include-before-body="3-samenvatting.front.tex" \
  --include-before-body="4-publications_summary.front.tex" \
  --include-before-body="5-conferences_summary.front.tex" \
  $MD_FILES \
  -o thesis.pdf
