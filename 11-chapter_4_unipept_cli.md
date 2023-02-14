## Unipept CLI 2.0: adding support for visualisations and functional annotations
\renewcommand{\sectionmark}[1]{\markright{\textsf{Chapter \thechapter.~ Functional annotations in the Unipept CLI and API}}}

\newpage

\color{gray}
*This chapter contains a verbatim copy of the technical note by [@verschaffeltUnipeptCLIAdding2020] as submitted to Bioinformatics.*
\color{black}

**Abstract** ---
Unipept [@mesuereUnipeptTrypticPeptideBased2012] is a collection of tools developed for fast metaproteomics data analysis.
The Unipept ecosystem consists of a web application, an application programming interface (API) as a web service [@mesuereUnipeptWebServices2016] and a command-line interface (CLI) [@mesuereHighthroughputMetaproteomicsData2018].
The key strengths of Unipept are its speed, its ease-of-use and the extensive use of interactive data visualization in the analysis results.
The Unipept database is derived from the UniProt (UniProt, 2019) KB and consists of tryptic peptides linked with taxonomic and functional annotations.
Unipept initially launched with support for taxonomic analysis of metaproteomics data in 2012.
Version 4.0 [@gurdeepsinghUnipeptFunctionalAnalysis2019] of the Unipept web application was launched in November 2018 and extended the web interface with support for functional annotations such as Gene Ontology (GO) terms [@ashburnerGeneOntologyTool2000], Enzyme Commission (EC) numbers [@webbEnzymeNomenclature19921992] and InterPro entries [@hunterInterProIntegrativeProtein2009].

### Introduction
Unipept [@mesuereUnipeptTrypticPeptideBased2012] is a collection of tools developed for fast metaproteomics data analysis.
The Unipept ecosystem consists of a web application, an application programming interface (API) as a web service [@mesuereUnipeptWebServices2016] and a command-line interface (CLI) [@mesuereHighthroughputMetaproteomicsData2018].
The key strengths of Unipept are its speed, its ease-of-use and the extensive use of interactive data visualization in the analysis results.
The Unipept database is derived from the UniProt [@theuniprotconsortiumUniProtWorldwideHub2019] KB and consists of tryptic peptides linked with taxonomic and functional annotations.
Unipept initially launched with support for taxonomic analysis of metaproteomics data in 2012.
Version 4.0 [@gurdeepsinghUnipeptFunctionalAnalysis2019] of the Unipept web application was launched in November 2018 and extended the web interface with support for functional annotations such as Gene Ontology (GO) terms [@ashburnerGeneOntologyTool2000], Enzyme Commission (EC) numbers [@webbEnzymeNomenclature19921992] and InterPro entries [@hunterInterProIntegrativeProtein2009].

The GO terms are organized into three different domains: ‘cellular components’, ‘molecular functions’ and ‘biological processes’.
Every GO-term is associated with exactly one domain and consists of a name, an identifier and an exact definition.
The EC numbers can be used to classify enzymes, based on the chemical reactions that they catalyze.
Every EC number consists of four numbers, separated by a dot, yielding a hierarchical classification system with progressively finer enzyme classifications.
InterPro is a database that consists of predictive models collected from external databases that can be classified into five different categories.
More information about functional annotation in metaproteomics can be found in the study by [@schiebenhoeferChallengesPromiseInterface2019].

For each input peptide, Unipept finds all functional annotations associated with all of the UniProt entries in which the peptide occurs.
All found functions are listed in order of decreasing number of peptides associated with this function.

In this article, we present several new additions to the Unipept API and CLI which allow third-party applications \[such as Galaxy-P [@jagtapMetaproteomicAnalysisUsing2015]\] to integrate the new functional analysis capabilities provided by Unipept.

### Materials and methods
The Unipept API is a high-performance web service that responds in a textual format (JSON) to HTTP-requests from other applications or tools and allows to integrate the services provided by Unipept into other workflows.
Unipept’s CLI is a Ruby-based application and high-level entry point which allows users to actively query Unipept’s database.
Compared to the API, users do not need to compile API-requests manually but can rely on the CLI to automatically do so in a parallelized way.
In addition, it supports multiple input and output formats such as FASTA and CSV.

The Unipept database and web application were recently expanded to include GO terms, EC numbers and InterPro entries.
These new annotations are now also available from newly developed API-endpoints and CLI-functions, providing structured access to this functional information.

Most of the newly developed endpoints support batch retrieval of information for a list of peptides.
In this case, the API returns a list of objects where each object in the response corresponds with information associated with one of the input peptides.
Every API-endpoint is accompanied by an identically named CLI-function, which provides the user with the ability to import data from or export data to various specifically formatted files.
In addition, version 2 of the Unipept CLI introduces the ability to produce interactive visualizations directly from the command line.

Among other information, the Unipept tryptic peptide analysis lists functional annotations associated with a given tryptic peptide.
These data are aggregated because a peptide can occur in multiple proteins that each can have multiple functional annotations.
For each annotation, we also return the amount of underlying proteins that match with this specific annotation.

Some applications require all known information for a list of tryptic peptides. The ‘pept2funct’ function is a combination of the preceding three endpoints and returns all functional annotations associated with the given tryptic peptide.
‘peptinfo’ on the other hand, returns all the available information for one or more tryptic peptides.
All functional annotations for this peptide are part of the response, as well as the lowest common ancestor for this peptide.
Both functions also support splitting the GO terms and InterPro entries over the respective domains, and naming information can optionally be retrieved.

The ‘taxa2tree’ function constructs a tree from a list of NCBI taxon ids.
This tree is an aggregation of the lineages that correspond with the given taxa and can be exported as three distinct output formats: JSON, HTML and as a URL.
The HTML and URL representation of a taxonomic tree both provide three interactive data visualizations, albeit with different possibilities.
A generated HTML-string first needs to be stored in a file before it can be rendered by a browser and cannot be easily shared with other people but is easily editable.
A URL on the other hand is simply a shareable link to an online service that hosts all interactive visualizations.

### Conclusion
Version 2.0 of the Unipept API and CLI is a significant update that provides fast and easy access to the powerful analysis pipeline of Unipept.
In addition to the existing taxonomic analysis, it now features multiple functional annotations which will enable users to gain new insights into complex ecosystems.
These new features can easily be integrated into third-party tools such as the MetaProteome Analyzer [@muthMPAPortableStandAlone2018].
Galaxy-P, a highly used workflow integration system, is already successfully making use of the novel analysis functions that are introduced with this new release.

### Funding
This work was supported by the Research Foundation—Flanders (FWO) \[1164420N to P.V.; 12I5220N to B.M.; 1S90918N to T.V.D.B.; G042518N to L.M.; 12S9418N to C.D.T.\].

