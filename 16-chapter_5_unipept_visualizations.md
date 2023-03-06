## Unipept Visualizations: an interactive visualization library for biological data {#chapter:unipept_visualizations}
\renewcommand{\sectionmark}[1]{\markright{\textsf{Chapter \thechapter.~ Novel visualizations tailored at biological data}}}

*Unipept's visualizations have been designed to be flexible and useable for data that is not generated by Unipept.
In order to promote reuse of these visualizations by other parties, we extracted the visualizations from Unipept and exposed them as separate modules in a JavaScript package ^[https://www.npmjs.com/package/unipept-visualizations].
Each visualization exposes an interface that data needs to adhere to in order for them to be visualized by the components provided in this package.
A new visualization, the heatmap (with support for dendrograms), also makes it first appearance here.*

*Together with the extraction of the visualization components, we have also updated the underlying code from JavaScript to TypeScript.
I've had a lot of help from Dr. James Collier (VIB) and Dr. Alexander Botzki (VIB) for this.
The application note that's included in this chapter provides a technical description about these visualizations, and how they are designed on the inside.*

\newpage

\color{gray}
*This chapter contains a verbatim copy of the application note by [@verschaffeltUnipeptVisualizationsInteractive2022] as submitted to Bioinformatics.*
\color{black}

**Abstract** ---
The Unipept Visualizations library is a JavaScript package to generate interactive visualizations of both hierarchical and non-hierarchical quantitative data.
It provides four different visualizations: a sunburst, a treemap, a treeview and a heatmap.
Every visualization is fully configurable, supports TypeScript and uses the excellent D3.js library.
The Unipept Visualizations library is available for download on NPM: [https://npmjs.com/unipept-visualizations](https://npmjs.com/unipept-visualizations).
All source code is freely available from GitHub under the MIT license: [https://github.com/unipept/unipept-visualizations](https://github.com/unipept/unipept-visualizations).

### Introduction
Unipept is an ecosystem of software tools for the analysis of metaproteomics datasets that consists of a web application [@gurdeepsinghUnipeptFunctionalAnalysis2019], a desktop application [@verschaffeltUnipeptDesktopFaster2021], a command line interface [@verschaffeltUnipeptCLIAdding2020] and an application programming interface.
It provides taxonomic and functional analysis pipelines for metaproteomics data and highly interactive data visualizations that help interpret the outcome of these analyses.

We developed custom visualizations used for Unipept from scratch because existing libraries, such as Krona [@ondovInteractiveMetagenomicVisualization2011], were lacking essential features or were hard to integrate.
They were designed as generic tools to visualize hierarchical quantitative data and can therefore also be used to visualize data from nonproteomics origins.
To facilitate reuse of these broadly usable components, we have isolated the visualizations from the main Unipept project and made them available as a standalone package that can easily be reused by other software tools.
We released this package under the permissive MIT open-source license, so researchers from other disciplines are free to reuse these visualizations and connect them to their own data sources.
Currently, our visualizations are already incorporated in TRAPID 2.0, a web application for the analysis of transcriptomes ([@bucchiniTRAPIDWebApplication2021] and UMGAP, the Unipept MetaGenomics Pipeline [@vanderjeugtUMGAPUnipeptMetaGenomics2022].

### Visualizations
We currently provide four highly interactive data visualizations that are all designed for a specific purpose: a sunburst, a treeview, a treemap and a heatmap.
The sunburst (\autoref{fig:visualizations_overview}a), treeview (\autoref{fig:visualizations_overview}d) and treemap (\autoref{fig:visualizations_overview}b) can be used to visualize quantitative hierarchical data and are designed to depict the parent–child relationship of a hierarchy of nodes as clearly as possible, while still incorporating the strength of the relationship between, or the counts associated with, connected nodes.
The heatmap (\autoref{fig:visualizations_overview}c), conversely, is not suitable to visualize hierarchical information but displays a magnitude in two dimensions, including optional clustering and dendrogram rendering.

![Overview of the visualizations currently provided by the Unipept Visualizations library. All examples were generated with default configuration settings, except for the heatmap for which the setting ‘dendrogramEnabled’ was set to ‘true’.\label{fig:visualizations_overview}](resources/figures/chapter5_visualizations_overview.png)

#### Quantitative hierarchical data visualizations
Hierarchical data occurs throughout a variety of bioinformatics disciplines.
In the metaproteomics research area alone, many examples of hierarchical data exist, such as the hierarchical structure of the NCBI taxonomy [@schochNCBITaxonomyComprehensive2020], the hierarchy imposed by the enzyme commission numbers and the gene ontology terms [@thegeneontologyconsortiumGeneOntologyResource2019].
In most cases, quantitative data are available for multiple nodes at many levels in the hierarchy.
For example, Unipept assigns peptide counts to taxa that are scattered around the NCBI taxonomy, including identifications that are highly specific (near leaves of the tree) or lack deep taxonomic resolution (near the root of the tree).
Being able to interactively zoom in and out on the hierarchical data enables exploratory analysis.

The three visualizations for hierarchical data provided by our package take input data in the same hierarchical format, making it trivial to switch between the different types of visualization once the input data are formatted correctly.

#### Quantitative non-hierarchical data visualizations
A heatmap (\autoref{fig:visualizations_overview}c) is a well-known visualization that consists of a two-dimensional grid of cells in which each cell is assigned a specific color from a scale corresponding to its magnitude.
The heatmap implementation in our package provides this functionality in an extensively customizable form.
Users can reorganize elements, change the color scheme and update label information, among other operations.
All values are also automatically normalized to a \[0, 1\]-interval.

As neighboring rows and columns in the input data can have very distinct values, and as this can interfere with reasoning about the heatmap, it is important to group similar values.
Our implementation achieves this through hierarchical clustering based on the UPGMA algorithm [@sokalStatisticalMethodEvaluating1958].
The produced grouping of rows and columns is further clarified by an optional dendrogram that can be plotted alongside each axis of the heatmap.

However, after clustering, it can still occur that two consecutive leaves in a dendrogram are quite dissimilar due to the $2^n−1$ possible linear orderings that can be derived from a dendrogram (a dendrogram contains $n - 1$ flipping points for which both children can be switched).
This can be addressed by reordering the leaves of the tree, as the orientation of the children of all n nodes in a dendrogram can be flipped without affecting the integrity of the dendrogram itself.
Our heatmap implementation uses the Modular Leaf Ordering technique [@sakaiDendsortModularLeaf2014] to reorder all leaves of the dendrogram such that the distance between consecutive leaves is minimized.
This technique is a heuristic that performs very well in comparison to the more resource-intensive Optimal Leaf Ordering [@bar-josephFastOptimalLeaf2001] or Gruvaeus–Wainer algorithms [@gruvaeusTwoAdditionsHierarchical1972].

### Implementation
The visualization package has been developed with D3 [@bostockDataDrivenDocuments2011] and TypeScript [@biermanUnderstandingTypeScript2014] and every visualization is displayed in the web browser with one of two technologies: SVG or HTML5 canvas.
SVG’s are easy-to-use and are scalable by nature but often lack necessary performance for complex interactive visualizations.
HTML5 canvas, in contrast, provides much better performance using a rasterized image.

Every visualization is presented as a single JavaScript class and provides a full set of configuration options to extend and configure the visualization.
New versions of the package will automatically be published on NPM ([https://npmjs.org](https://npmjs.org)) and GitHub ([https://github.com/unipept/unipept-visualizations](https://github.com/unipept/unipept-visualizations)), so that any project depending on it package can always use the latest version.

We also provide an extensive set of documentation resources that ease the adoption process of our package, as well as a collection of live notebooks (see [https://observablehq.com/collection/\@unipept/unipept-visualizations](https://observablehq.com/collection/\@unipept/unipept-visualizations)).
These notebooks provide interactive and editable examples that demonstrate the full potential and guide users through the different configuration options.
The code and resources that make up the live notebooks can be modified online and provide a very convenient way to try out the package.

### Funding
This work has been supported by the Research Foundation—Flanders (FWO) \[1164420N to P.V.; 12I5220N to B.M.; G042518N to L.M.\].