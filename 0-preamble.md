---
title: Comparative Analysis of High-Throughput Metaproteomics Data in Unipept 
author: Pieter Verschaffelt
bibliography: all_publications.bib
csl: bioinformatics.csl
geometry: a5paper, margin=2cm
header-includes:
    - \usepackage{microtype}
    - \usepackage{fontspec}
    - \setmainfont{TeX Gyre Pagella}
    - \setsansfont{TeX Gyre Heros}
    - \usepackage{sectsty}
    - \usepackage[labelfont=bf]{caption}
    - \usepackage{hyperref}
    - \usepackage{fancyhdr}
    - \usepackage{booktabs}
    - \usepackage{bbding}
    - \pagestyle{fancy}
    - \fancyhead[RE]{}
    - \fancyhead[LE]{\leftmark}
    - \fancyhead[LO]{}
---

\allsectionsfont{\sffamily}
\newcommand{\ra}[1]{\renewcommand{\arraystretch}{#1}}

[//]: # (https://tex.stackexchange.com/a/13395/91462)
\let\Oldpart\part
\newcommand{\parttitle}{}
\renewcommand{\part}[1]{\Oldpart{#1}\renewcommand{\parttitle}{#1}}

\renewcommand{\chaptermark}[1]{\markboth{\textsf{Part \thepart.~ \parttitle}}{}}
\renewcommand{\sectionmark}[1]{\markright{\textsf{\thechapter.~ chapter title}}}



