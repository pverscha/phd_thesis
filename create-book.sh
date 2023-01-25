rm -rf output
mkdir output

# --top-level-division=chapter will prepend chapter names with "Chapter"
pandoc \
  --pdf-engine=lualatex \
  --top-level-division=chapter \
  --number-sections \
  --citeproc \
  --toc \
  chapter0.md \
  chapter1.md \
  chapter2.md \
  chapter3.md \
  references.md \
  -o thesis.pdf
