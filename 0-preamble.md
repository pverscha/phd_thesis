---
title: "Building the Unipept Ecosystem"
subtitle: "Empowering high-throughput metaproteomics data analysis for characterizing complex microbial communities"
author: Pieter Verschaffelt
bibliography: all_publications.bib
csl: bioinformatics.csl
documentclass: book
papersize: a5
geometry: margin=3cm
mainfont: Adobe Caslon Pro
sansfont: Myriad Pro
classoption: x11names, table
codeBlockCaptions: true
header-includes:
    - \usepackage{microtype}
    - \usepackage{sectsty}
    - \usepackage[labelfont=bf]{caption}
    - \usepackage{hyperref}
    - \usepackage{fancyhdr}
    - \usepackage{booktabs}
    - \usepackage{fontawesome}
    - \usepackage{setspace}
    - \fancyhead[RE]{}
    - \fancyhead[LE]{\leftmark}
    - \fancyhead[LO]{}
    - \allsectionsfont{\sffamily}
    - \captionsetup[table]{font={small,stretch=1.2}}
    - \captionsetup[figure]{font={small,stretch=1.2}}
    - \usepackage{tocloft}
    - \renewcommand{\cftchappresnum}{Chapter\ } 
    - \renewcommand{\cftchapnumwidth}{0.7in}
    - \renewcommand{\cftchapdotsep}{\cftdotsep}
    - \renewcommand{\cftpartpresnum}{Part\ }
    - \renewcommand{\cftpartnumwidth}{0.7in}
    - \renewcommand{\cftpartdotsep}{\cftdotsep}
    - \newfontfamily\myriad[]{Myriad Pro Regular}
---

\makeatletter
\renewcommand*\@makechapterhead[1]{%
%       \vspace*{50\p@}%
{%
\singlespacing\parindent\z@\raggedright\normalfont
           \ifnum\c@secnumdepth>\m@ne
               \sffamily\huge\bfseries\@chapapp\space\thechapter\par
               \nobreak\vskip 5\p@
           \fi
           \interlinepenalty\@M
\sffamily\Huge\bfseries
#1\par
\nobreak\vskip 20\p@
\onehalfspacing
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

\raggedbottom

