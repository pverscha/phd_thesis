---
title: "Building the Unipept Ecosystem"
subtitle: "Empowering high-throughput metaproteomics data analysis for characterizing complex microbial communities"
author: Pieter Verschaffelt
bibliography: all_publications.bib
csl: bioinformatics.csl
documentclass: book
papersize: a5
mainfont: Adobe Caslon Pro
sansfont: Myriad Pro
header-includes:
    - \usepackage{microtype}
    - \usepackage{sectsty}
    - \usepackage[labelfont=bf]{caption}
    - \usepackage{hyperref}
    - \usepackage{fancyhdr}
    - \usepackage{booktabs}
    - \usepackage{bbding}
    - \usepackage{setspace}
    - \usepackage{xcolor}
    - \fancyhead[RE]{}
    - \fancyhead[LE]{\leftmark}
    - \fancyhead[LO]{}
    - \allsectionsfont{\sffamily}
    - \captionsetup[table]{font={small,stretch=1.2}}
    - \captionsetup[figure]{font={small,stretch=1.2}}
---

\makeatletter
\renewcommand*\@makechapterhead[1]{%
%       \vspace*{50\p@}%
{%
\parindent\z@\raggedright\normalfont
           \ifnum\c@secnumdepth>\m@ne
               \sffamily\huge\bfseries\@chapapp\space\thechapter\par
               \nobreak\vskip 5\p@
           \fi
           \interlinepenalty\@M
\sffamily\Huge\bfseries
#1\par
\nobreak\vskip 20\p@
}
}
\makeatother

\onehalfspacing

\newcommand{\ra}[1]{\renewcommand{\arraystretch}{#1}}

[//]: # (https://tex.stackexchange.com/a/13395/91462)
\let\Oldpart\part
\newcommand{\parttitle}{}
\renewcommand{\part}[1]{\Oldpart{#1}\renewcommand{\parttitle}{#1}}

\pagestyle{plain}

