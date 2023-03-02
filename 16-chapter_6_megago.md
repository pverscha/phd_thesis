## MegaGO: a fast yet powerful approach to assess functional Gene Ontology similarity across meta-omics data sets {#chapter:megago}
\renewcommand{\sectionmark}[1]{\markright{\textsf{Chapter \thechapter.~ A new similarity metric for GO-terms}}}

*The MegaGO project was born at the 2020 EuBIC Developer's meeting in Nyborg, Denmark.
This developer's meeting was the first conference that I joined as a PhD-student and consisted of little hackathon projects that were planned and executed in groups of about 6 to 8 people.
Together with Bart Mesuere, Tim Van Den Bossche and Henning Schiebenhoefer, I hosted a hackathon project over there.
During the months after the conference, we have further expanded this project with a command line tool and a web application ^[https://megago.ugent.be/].*

*The manuscript discussed in this chapter has mainly been written by Tim Van Den Bossche, Henning Schiebenhoefer and myself.
I was furthermore the main responsible of the web application and a big portion of the back-end code that powers the analyses of our web app.*

\newpage

\color{gray}
*This chapter contains a verbatim copy of the manuscript by [@verschaffeltMegaGOFastPowerful2021] as submitted to Journal of Proteome Research.*
\color{black}

![Screenshot of the MegaGO Web application. This application is accessible at [https://megago.ugent.be](https://megago.ugent.be). \label{fig:megago_screenshot}](resources/figures/chapter6_megago_application_screenshot.png)

**Abstract** ---
The study of microbiomes has gained in importance over the past few years and has led to the emergence of the fields of metagenomics, metatranscriptomics, and metaproteomics.
While initially focused on the study of biodiversity within these communities, the emphasis has increasingly shifted to the study of (changes in) the complete set of functions available in these communities.
A key tool to study this functional complement of a microbiome is Gene Ontology (GO) term analysis.
However, comparing large sets of GO terms is not an easy task due to the deeply branched nature of GO, which limits the utility of exact term matching.
To solve this problem, we here present MegaGO, a user-friendly tool that relies on semantic similarity between GO terms to compute the functional similarity between multiple data sets.
MegaGO is high performing: Each set can contain thousands of GO terms, and results are calculated in a matter of seconds.
MegaGO is available as a web application at [https://megago.ugent.be](https://megago.ugent.be) and is installable via pip as a standalone command line tool and reusable software library.
All code is open source under the MIT license and is available at [https://github.com/MEGA-GO/](https://github.com/MEGA-GO/).

### Introduction
Microorganisms often live together in a microbial community or microbiome where they create complex functional networks.
These microbiomes are therefore commonly studied to reveal both their taxonomic composition as well as their functional repertoire.
This is typically achieved by analyzing their gene content using shotgun metagenomics.
Whereas this approach allows a detailed investigation of the genomes that are present in such multiorganism samples, it reveals only their functional potential rather than their currently active functions [@janssonMultiomicFutureMicrobiome2016].
To uncover these active functions within a given sample, the characterization of the protein content is often essential [@lohmannFunctionWhatCounts2020].

The growing focus on functional information as a complement to taxonomic information [@loucaDecouplingFunctionTaxonomy2016] is derived from the observation that two taxonomically similar microbial communities could have vastly different functional capacities, whereas taxonomically quite distinct communities could have remarkably similar functions.
Whereas the investigation of the active functions is thus increasingly seen as vital to a complete understanding of a microbiome, the identification and comparison of these detected functions remains one of the biggest challenges in the field [@schiebenhoeferChallengesPromiseInterface2019].

Several omics tools exist to describe functions in microbial samples, although these tools link functionality to different biological entities such as genes, transcripts, proteins, and peptides [@muthMetaProteomeAnalyzerPowerfulOpenSource2015; @muthMPAPortableStandAlone2018; @vandenbosscheConnectingMetaProteomeAnalyzerPeptideShaker2020; @verschaffeltUnipeptCLIAdding2020; @gurdeepsinghUnipeptFunctionalAnalysis2019; @riffleMetaGOmicsWebBasedTool2018; @schneiderStructureFunctionSymbiosis2011; @schiebenhoeferCompleteFlexibleWorkflow2020; @huerta-cepasEggNOGHierarchicalFunctionally2019; @husonMEGANAnalysisMetagenomic2007].
However, most tools are capable of directly or indirectly reporting functional annotations as a set of Gene Ontology [@thegeneontologyconsortiumGeneOntologyResource2019] (GO) terms, regardless of the biological entities they are assigned to.
In October 2020, there were 44264 of these terms in the complete GO tree.
GO terms are organized into three independent domains: molecular function, biological process, and cellular component [@ashburnerGeneOntologyTool2000].
In each domain, terms are linked into a directed acyclic graph, an excerpt of which is shown in \autoref{fig:megago_biological_process_excerpt}.
\autoref{fig:megago_biological_process_excerpt} shows the Gene Ontology graph for all parent terms up to the root for the GO-term "translation" (GO:0006412).
In this case, the root GO term “biological process“ (GO:0008150) has multiple children, while the most specific term “translation”, in contrast, has multiple parents.
When comparing the two terms GO:0044267 and GO:0034645 (portrayed in light red), we find two different lowest common ancestors: GO:0044249 and GO:1901576 (dark red). 
Only one of these, however, can be the most informative common ancestor (MICA), that is, the common ancestor with the highest information content for the terms in light red. 
Because an IC of 1.52 is larger than 1.48, the GO:0044249 is the MICA. 
The terms GO:0043604 and GO:0006518 (in light blue) are more similar than the two terms we previously described and have only one lowest common ancestor, which is also automatically the MICA for these terms: GO:0043603 (in dark blue).

![Excerpt of the biological process domain of the Gene Ontology showing all parent terms up to the root for “translation” (GO:0006412). IC, information content; *, most informative common ancestor.\label{fig:megago_biological_process_excerpt}](resources/figures/chapter6_megago_graph.eps)

Whereas this highly branched graph structure of GO allows flexible annotation at various levels of detail, it also creates problems when the results from one data set are compared to those of another data set.
Indeed, even though two terms may be closely linked in the GO tree and are therefore highly similar (e.g., as parent and child terms or as sibling terms), the typically employed exact term matching will treat these terms as wholly unrelated, as the actual GO terms (and their accession numbers) are not identical.
This problem is illustrated in a study by [@sajulgaSurveyMetaproteomicsSoftware2020], where a multisample data set was analyzed using several metaproteomics tools.
The resulting GO terms were then compared using exact matching.
The overlap between the result sets was quantified using the Jaccard index and was found to be low.
As previously explained, this low similarity is likely the result of the limitations of the exact term matching approach.

There is thus a clear need for a more sophisticated GO term comparison that takes into account the existing relationships in the full GO tree.
However, most existing tools that provide such comparison are based on enrichment analyses [@huangSystematicIntegrativeAnalysis2009; @waardenbergCompGOPackageComparing2015; @fruzangoharComparativeGOWeb2013].
In such analyses, a list of genes is mapped to GO terms, which are then analyzed for enriched biological phenomena.
As a result, to the best of our knowledge, no tools allow the direct comparison of large functional data sets against each other, nor are these able to provide metrics to determine how functionally similar data sets are.

We therefore present MegaGO, a tool for comparing the functional similarity between large sets of GO terms.
MegaGO calculates a pairwise similarity score between multiple sets of GO terms for each of the three GO domains and can do so in seconds, even on platforms with limited computational capabilities.

### Implementation
To measure the similarity between sets of GO terms, we first need to measure the similarity of two individual terms.
We compare two terms using the Lin semantic similarity metric, which can take on a value between 0 and 1 (Supplementary Formula 1a). 
The Lin semantic similarity is based on the ratio of the information content of the most informative common ancestor (MICA) to the average of the terms’ individual information content.

The information content (Supplementary Formula 1b) is computed by estimating the terms’ probability of occurrence (Supplementary Formula 1c), including that of all of their children. Term frequencies are estimated based on the manually curated SwissProt database [@theuniprotconsortiumUniProtWorldwideHub2019].
As a result, a high-level GO term such as “biological process” (through its many direct or indirect child terms) will be present in all data sets and thus carries little information.
A more specific term such as “translation” (or any of its potential child terms) will occur less frequently and thus will be more informative (\autoref{fig:megago_biological_process_excerpt}).
To finally calculate the similarity of two terms, we compare their information content with that of their shared ancestor that has the highest information content, the MICA.
If the information content of the MICA is similar to the terms’ individual information content, then the terms are deemed to be similar.
The dissimilar terms “peptide biosynthetic process” and “cellular macromolecule biosynthetic” are situated further from their MICA “cellular biosynthetic process” than the similar terms “amide biosynthetic process” and “peptide metabolic process” with their respective MICA “cellular amide metabolic process” (\autoref{fig:megago_biological_process_excerpt}).

MegaGO, however, can compare not only two terms but also sets of GO terms.
More specifically, two sets of GO terms can be compared via the web application, but an unlimited number of sets can be compared via the command line tool.
Note that in these sets, duplicate GO terms will be removed so that each GO term will be equally important, regardless of how often it is provided by the user.
To compare the sets of GO terms, pairwise term similarities are aggregated using the Best Matching Average (BMA, Supplementary Formula 2) [@schlickerNewMeasureFunctional2006].
For each GO term in the first input data set, the BMA finds the GO term with the highest Lin semantic similarity in the second data set and averages the values of these best matches.
Moreover, MegaGO calculates the similarity for each of the three domains of the gene ontology (molecular function, biological process, and cellular component), as GO terms from distinct domains do not share parent terms.
The general overview of MegaGO is shown in \autoref{fig:megago_workflow_overview}.

![Overview of MegaGO workflow. The Gene Ontology (GO) terms of each sample set are separated into three GO domains: molecular function, cellular component, and biological process. Each term of each sample set is compared to every term in the other set that is from the same domain. The match with highest similarity for each term is then selected, and the average across all of these best matches is calculated.\label{fig:megago_workflow_overview}](resources/figures/chapter6_megago_workflow_overview.png)

MegaGO is implemented in Python, is installable as a Python package from PyPi, and can easily be invoked from the command line.
The GOATOOLS [@klopfensteinGOATOOLSPythonLibrary2018] library is used to read and process the Gene Ontology and to compute the most informative common ancestor of two GO terms, which are both required to compute the information content value (Supplementary Formula 1, p(go)).
GO term counts are recomputed with every update of SwissProt, and a new release is automatically published bimonthly to PyPi, which includes the new data set.
Automated testing via GitHub Actions is in place to ensure correctness and reproducibility of the code.
In addition, we also developed a user-friendly and easily accessible web application that is available on https://megago.ugent.be.
The backend of the web application is developed with the Flask web framework for Python, and the frontend uses Vue.
Our web application has been tested on Chromium-based browsers (Chrome, Edge, and Opera) as well as Mozilla Firefox and Safari.
The MegaGO application is also available as a Docker-container on Docker Hub (https://hub.docker.com/repository/docker/pverscha/mega-go) and can be started with a single click and without additional configuration requirements.
Our Docker container is automatically updated at every change to the underlying MegaGO code.
All code is freely available under the permissive open source MIT license on https://github.com/MEGA-GO/.
Documentation for our Python script can be found on our Web site: https://megago.ugent.be/help/cli.
A guide on how to use the web application is also available: https://megago.ugent.be/help/web.

MegaGO is cross-platform and runs on Windows, macOS, and Linux systems.
The system requirements are at least 4 GiB of memory and support for either Python 3.6 (or above) or the Docker runtime.

### Validation
To validate MegaGO, we reprocessed the functional data from [@easterlyMetaQuantomeIntegratedQuantitative2019].
This data set consists of 12 paired oral microbiome samples that were cultivated in bioreactors.
Each sample was treated with and without sucrose pulsing, hereafter named ws and ns samples, respectively.
Each sample contains mass-spectrometry-based proteomics measurements, and all samples were annotated with 1718 GO terms on average.
We calculated the pairwise similarity for each of the 300 sample combinations, which took less than 1 min for a single sample pair on the web version of MegaGO.
This resulted in a MegaGO similarity score for each of the three GO domains for each sample combination.
These similarities were then hierarchically clustered and visualized in a heatmap.
All data and intermediate steps of our data analysis are available at https://github.com/MEGA-GO/manuscript-data-analysis/ and can be reproduced with the command line tool using the --heatmap option.

In the heatmap (\autoref{fig:megago_heatmap}), we can observe that the two sample groups cluster together, except for 730ns and 733ns that are clustered in the ws sample group.
These two samples were also identified as outliers in [@easterlyMetaQuantomeIntegratedQuantitative2019] and 733ns was originally also identified as both a taxonomic and functional outlier in [@rudneyProteinRelativeAbundance2015].
Similar results can be observed for the GO domain “molecular function” (Supplementary Figure 1).
The MegaGO similarity-based clustering of “cellular component” GO terms (Supplementary Figure 2) has two additional samples clustered outside of their treatment group: 852ws in the ns cluster and 861ns in the ws group.
Again, these patterns can also be found in previous analyses: 852ws is placed in direct proximity of the ns samples in the principal component analysis (PCA) of the HOMINGS analysis by Rudney et al., and 861ns is closest to 730ns and 733ns in PCA of Rudney et al.’s taxonomic analysis.
Interestingly, subjects 730 and 852 were the only ones without active carious lesions, which could cause their divergence in the similarity analyses.

![Hierarchically clustered heatmap comparing MegaGO similarities for the GO domain “biological process” for each of the samples from [@easterlyMetaQuantomeIntegratedQuantitative2019] Samples that are treated with sucrose pulsing are labeled as “ws” and are displayed in orange.\label{fig:megago_heatmap}](resources/figures/chapter6_megago_heatmap_example.png)

Results produced by MegaGO are thus in close agreement with prior analyses of the same data, showing that MegaGO offers a valid and very fast approach for comparing the functional composition of samples.

### Conclusions
MegaGO enables the comparison of large sets of GO terms, allowing users to efficiently evaluate multiomics data sets containing thousands of terms.
MegaGO separately calculates a similarity for each of the three GO domains (biological process, molecular function, and cellular component).
In the current version of MegaGO, quantitative data are not taken into account, thus giving each GO term identical importance in the data set.

MegaGO is compatible with any upstream tool that can provide GO term lists for a data set.
Moreover, MegaGO allows the comparison of functional annotations derived from DNA-, RNA-, and protein-based methods as well as combinations thereof.

### Acknowledgements
We acknowledge the European Bioinformatics Community for Mass Spectrometry (EuBIC-MS).
This project found its origin at the EuBIC Developers’ 2020 meeting [@ashwoodProceedingsEuBICMS20202020] in Nyborg, Denmark.
We thank Thilo Muth (Bundesanstalt für Materialforschung und -prüfung, Berlin, Germany) and Stephan Fuchs (Robert Koch Institute, Berlin, Germany) for their support.
P.V., T.V.D.B., L.M., and B.M. acknowledge the Research Foundation - Flanders (FWO) (grants 1164420N, 1S90918N, G042518N, and 12I5220N).
L.M. also acknowledges support from the European Union’s Horizon 2020 Programme under grant agreement 823839 (H2020-INFRAIA-2018-1).
H.S. and B.Y.R. acknowledge support by Deutsche Forschungsgemeinschaft (DFG; grant numbers RE3474/5-1 and RE3474/2-2) and the BMBF-funded de.NBI Cloud within the German Network for Bioinformatics Infrastructure (de.NBI; 031A537B, 031A533A, 031A538A, 031A533B, 031A535A, 031A537C, 031A534A, and 031A532B).
