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
  $MD_FILES \
  -o thesis.pdf
