rm -rf output
mkdir output

# --top-level-division=chapter will prepend chapter names with "Chapter"
pandoc \
  --top-level-division=chapter \
  --number-sections \
  --citeproc \
  --toc \
  chapter0.md \
  chapter1.md \
  chapter2.md \
  references.md \
  -o thesis.pdf
