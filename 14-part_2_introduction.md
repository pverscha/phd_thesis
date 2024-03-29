# The Unipept ecosystem

\pagestyle{empty}

\renewcommand{\sectionmark}[1]{\markright{\textsf{Part \thepart.~ Introduction}}}

Unipept is not a single tool, but rather a collection of tools that support the analysis of metaproteomics and metagenomics datasets.
In the previous part of this PhD thesis, I discussed the novel Unipept Desktop application and all of the improvements that have been made in that area.
I have, however, also been part of a lot of other projects that are either a direct part of the Unipept ecosystem or very closely related to it.

In \autoref{chapter:unipept_cli_v2}, I discuss the changes made to the Unipept CLI and API.
As described in [@gurdeepsinghUnipeptFunctionalAnalysis2019], a functional analysis pipeline for metaproteomics datasets has been added to the Unipept web application in 2018.
Initially, we supported the annotation and analysis of Enzyme Commission numbers [@webbEnzymeNomenclature19921992] and Gene Ontology terms [@ashburnerGeneOntologyTool2000].
Together with Philippe Van Thienen (a master student that I guided in 2019), we expanded the functional analysis pipeline with support for InterPro annotations [@hunterInterProIntegrativeProtein2009] and integrated our novel functional analysis with the Unipept CLI and API.

All of the visualizations that are incorporated in the Unipept web application are, in the first place, designed to visualize the results produced by Unipept.
The visualizations are, however, powerful enough to be used for other types of data as well.
In \autoref{chapter:unipept_visualizations}, I discuss how all of the visualizations were extracted into a separate JavaScript visualization library that can be used by third-party applications.
A new visualization, the heatmap (including support for the visualization of a dendrogram), is also featured in this chapter.

MegaGO is a tool for the comparison of multiple sets of GO-terms and is discussed in \autoref{chapter:megago}.
This tool is not a direct member of the Unipept ecosystem, but is nonetheless closely related to Unipept.
For each metaproteomics analysis, Unipept reports a set of GO-terms that have been identified and which can afterwards be fed into the MegaGO application for comparison with other analysis results.

Finally, I also consider three side-projects that I contributed to in \autoref{chapter:other_projects}.
The first project, Pout2Prot, talks about the application of protein grouping on a specific type of output file (with the `.pout` extension, as generated by the Percolator software).
The second project has not received a definitive name yet and consists of highlighting the metabolic pathways that are active in a complex microbial ecosystem.
Lastly, I present a very special `HashMap` implementation for JavaScript that can be used by multiple processes simultaneously.
