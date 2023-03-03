## Future work {#chapter:future_work}
\renewcommand{\sectionmark}[1]{\markright{\textsf{Chapter \thechapter.~ The future of Unipept}}}

*No scientific work is ever complete and there still remain a lot of challenges in the field of metaproteomics and proteogenomics that still need to be solved. In this section, I discuss some issues and challenges that currently arise and what needs to be overcome in order to solve these.*

\newpage

### Modelling the inherent ambiguities in the Unipept matching system
#### Current situation
In a process prior to database construction, peptide sequences are reconstructed by spectral search engines.
During the construction of the protein reference database, Unipept aggregates the functional and taxonomic annotations of proteins by grouping them by exact matching of peptide sequences.
Since a single mass spectrum can, however, be explained by different peptide sequences, a search engine sometimes needs to pick and output the most probable peptide sequence that explains this spectrum.
This inherent ambiguity is ignored during the Unipept database construction process by only considering peptide sequence similarity when grouping and summarising the functional and taxonomic annotations of peptides.

Right now, all proteins that are fed into Unipept during database construction will be in-silico tryptically digested into peptides.
Then, a similarity function is used to compare peptides with each other, and the protein-level annotations of peptides that are found to be equal, according to this similarity function, are grouped and summarised.
Currently, two peptides are considered to be equal when their peptide sequences are exactly the same.
In this case, we rely on the search engines that are matching experimental mass spectra with peptide sequences in order to get a reliable result.
In practice, it is common for multiple peptide sequences to correspond with the same mass spectrum, causing ambiguity in the spectral matching process.
But, since Unipept only looks at sequence identity, part of this spectral ambiguity is (potentially unjustified) ignored.

#### Proposed work plan
Instead of grouping together different peptides by only looking at the sequence similarity, we can predict the mass spectrum of each peptide in the Unipept protein reference database using a tool such as MS2PIP [@degroeveMS2PIPToolMS2013].
MS2PIP employs the XGBoost machine learning algorithm in order to predict MS2 signal peak intensities from peptide sequences and has proven to produce very reliable results.
Tryptic peptides that were identical when using the sequence-based similarity metric, will also be identical with this new metric.
But important to note is that the spectrum-based similarity metric will be “less strict” than sequence-based similarity, meaning that peptides that were different under the sequence-based similarity can now be considered identical.
Consequently, this also means that resolution of the taxonomic and functional profile for a metaproteomics sample will go down.
By now taking into account the spectral ambiguity that was previously masked by Unipept’s analysis, we can design an experiment to investigate to what extent this ambiguity proves to be an issue.

##### Update the Unipept database construction process
The construction process of the Unipept database is currently not designed to work with different similarity metrics when it comes to grouping peptides.
A first, big change, will have to be made to this construction process in order to allow it to accept arbitrary similarity metrics.
This will, in turn, allow us to implement the spectrum based similarity metric (as well as variants) and easily plug them into the database construction process.
No other major changes will have to be made to the finalised Unipept database, the underlying database structure will be more or less the same.

##### Perform a first experiment
In order to test the hypothesis that we proposed at the start of this section, we will have to perform an experiment in which we compare the end result of a metaproteomics analysis using the updated spectrum-based similarity approach for Unipept against using the traditional sequence-based similarity approach.
For this experiment, we can analyse the SIHUMI sample using each of the approaches and compare the end results.
SIHUMI is a sample that was artificially constructed for the renowned CAMPI study [@vandenbosscheCriticalAssessmentMetaProteome2021] and for which the exact taxonomic composition is known.
We expect to find that the spectrum-similarity based Unipept leads to a lower, but more realistic, taxonomic and functional resolution for the provided sample.

##### Predict retention times
Instead of only looking at the predicted MS2 peak intensities of a peptide sequence using MS2PIP, we can go one step further and also predict retention times and take these into account and expand the similarity metric that was developed during the previous steps.
Retention times can be predicted using the DeepLC tool [@bouwmeesterDeepLCCanPredict2021] and will cause some peptides, that are similar when we compare them solely by spectra, to be different if we also take into account this predicted retention time.
Since the Unipept database construction process has already been updated to be compatible with hot-pluggable similarity metrics at this point, we only need to implement a new similarity metric and rebuild the Unipept database.

##### Perform a second experiment
Finally, we can augment the experiment designed earlier to compare the results between the updated spectrum-based similarity approach for Unipept against using the traditional sequence-based similarity approach with the analysis using the spectrum-similarity based Unipept that also takes into account retention times for the tryptic peptides.
For this comparison, we expect the taxonomic and functional resolution of the end result to have increased when comparing it to the spectrum-based similarity of before.

### Identification and analysis of arbitrary peptides, including variants

#### Current situation
Unipept requires that all input peptides are tryptic in order to be able to match them with peptides in its reference database.
However, researchers are transitioning to experiment with datasets that contain other peptide formats that Unipept currently can not use for downstream analysis.
In this work package, I will therefore design a new index structure for Unipept based on bidirectional FM-indices and search schemes.
This new index will no longer require the input peptides to adhere to a fixed format.

Over the last 10 years, a lot of research has gone into the development and improvement of efficient data structures for sequence alignment.
One such highly-used data structure that offers excellent performance is the FM-index [@ferraginaOpportunisticDataStructures2000].
An FM-index is produced by computing the Burrows-Wheeler transform of a specific string and allows to look up if (and where) a pattern occurs in the preprocessed text in a very efficient manner.
By adjusting the FM-index and its accompanying query algorithms, we are not limited to matching exact strings but we can also detect if a specific sequence (with up to a certain number of k mismatches) is present in a longer string.

A big advantage of these FM-indices over the approach that Unipept currently follows for matching input peptides with proteins in the protein reference database is that the FM-index allows us to match arbitrary peptide sequences with proteins (instead of only directly matching tryptic peptides as we do today).
This opens up the possibility to go and analyse semi-tryptic peptides using Unipept, or even matching tryptic peptides with missed cleavages.
At this point, it is already possible to analyse peptides with missed cleavages, but this drastically slows down the analysis since a lot of Unipept’s precomputed aggregations are not available in this case.

In order to efficiently match a peptide (with up to k mismatches) with a protein, an FM-index by itself does not suffice and we need to look for improved data structures.
This is where search schemes come into play.
A search scheme is a strategy that describes how a bi-directional FM-index can be queried such that patterns with up to k mismatches can efficiently be matched with a long string (such as a protein).
Search schemes were first proposed by (Lam et al.) and were further generalised by [@kucherovApproximateStringMatching2014].

#### Proposed work plan

##### Design and implement a new index structure for Unipept
The first step that should be performed in order to allow Unipept to match peptides of arbitrary format, is to design a new index structure for our database, using FM-indices, and to implement this new index structure.
For each protein in the protein reference database, we can construct an FM-index of the protein sequence, which allows us to match any kind of peptide with this protein and keep it in our new index structure.
We can use the Rust programming language since it is designed with performance and parallelization in mind, and it already provides a very good, open-source implementation of the FM-index data structure ^[https://docs.rs/fm-index/latest/fm_index/].
These changes will allow us to match arbitrary peptides and peptides with missed cleavages using Unipept.

##### Implement a bi-directional FM-index
A second step consists of updating the FM-index data structure that was used during the previous step such that supports matching patterns in two directions (backwards *and* forwards).
This so-called bi-directional FM-index is extensively described in [@lamHighThroughputShort] and is required for efficiently performing approximate pattern matching using search schemes.
We can improve and expand the existing, open-source Rust FM-index implementation from the previous step such that it allows searching in two directions.
By contributing to this open-source project we do not need to start from scratch, and we can share our improvements with other researchers around the globe.

##### Implement and validate search scheme prototypes
A lot of different proposals for search schemes already exist at this point. During this step, we can take a look at a selection of search schemes such as the Pigeon H.S. [@fletcherFoundationsHigherMathematics1996], 01*0 seeds [@vrolandApproximateSearchShort2016], schemes proposed by Kucherov [@kucherovApproximateStringMatching2014], and $Man_{best}$ [@pockrandtApproximateStringMatching2019].
All of these search schemes will have to be benchmarked for performance and applicability for our needs.
The search scheme that comes out as best from this comparison can then be tweaked and refined further.

##### Integrate the best search scheme into Unipept
Finally, the search scheme that was selected during the previous step needs to be integrated into the Unipept database index structure.
By doing so, Unipept will effectively support matching peptides with up to $k$ mismatches with the proteins from a reference database.

### Towards a meta-, multi-omics Unipept

#### Current situation
Over the last few years, we have been working very hard to build the Unipept Desktop application which provides a first step in the integration of metagenomics information in metaproteomics experiments.
By first performing a metagenomics experiment on a sample, researchers are able to derive the taxonomic profile of the ecosystem under study.
This taxonomic profile can then be used in a subsequent step as a guide for constructing a targeted protein reference database (that only contains proteins that are associated with the taxa that were detected during the metagenomics experiment).

As a possible future addition to Unipept, I propose to further integrate data from different “omics” sources such as transcriptomics and metagenomics into Unipept
Building on the individual strength of these techniques, an aggregated view enables researchers to gain a much deeper insight into and understanding of what exactly is taking place in a complex ecosystem.
By augmenting Unipept with support for both metagenomics and metatranscriptomics analyses, it has the potential to become the “go-to” tool for all analyses related to the “meta-omics” research disciplines.
The ultimate goal of this work package is to transform Unipept into the first tool that provides a complete global overview of multi-disciplinary “meta-omics” experiments.

#### Proposed work plan

##### Allow Unipept to directly load metagenomics reads
By improving Unipept with the capability of loading metagenomics reads directly into the software, we can allow users to construct a fully custom protein reference database from these reads.
At this time, a targeted reference database is always constructed by extracting and filtering proteins from the UniProtKB resource.
This works very well when the organisms under study have been analysed before and their proteomic profile is available in the UniProtKB resource.
By providing support for the construction of protein reference databases from metagenomic reads instead, we can also allow organisms that are not present in the UniProtKB resource to be analysed.

##### Design and implement new visualizations for metagenomics experiments
Unipept provides a lot of valuable and interactive data visualisations that increase the insight of researchers into the taxonomic and functional profile of a metaproteomics ecosystem.
These visualisations are implemented in a very generic way that allows them to be applicable to other situations as well.
I propose to expand Unipept with the ability to visualise the taxonomic profile determined by a metagenomics experiment, and the potential functional profile that is determined by performing a metatranscriptomics experiment.
This will increase the insight of users into the ecosystem that they are currently investigating.

### Differential analysis of metaproteomics data

#### Current situation
Dedicated data analysis methods for differential metaproteomics are currently lacking.
Different tools for the analysis of metaproteomics data exist at this point, but none of them provide a statistically sound framework for the **comparative** analysis of metaproteomics data.

By devising a framework that allows for filtering and normalisation, we can take advantage of the parallel data structures in metaproteomics and we can extent beyond two-group comparisons by building on the general linear model (GLM) framework.
This approach provides researchers with the tools to assess differential abundance in both taxa, as well as in functional annotations between conditions.
Moreover, we could also devise methods to detect shifts in the population or the use of functions induced by treatment or biological processes such as diseases.

Ideally, this comparative analysis pipeline can be integrated and embedded into user-friendly workflows for Unipept. 

#### Proposed work plan

##### Develop and validate normalisation and filtering strategies for metaproteomics applications
A Unipept analysis will map peptides to taxa and functions resulting in a count table, but these counts can be largely driven by library size, i.e., the total number of peptides in a sample.
Hence, the data need to be normalised, which will be done by calculating normalisation offsets for the GLMs that will be developed in the next step.
Besides library size, we also have to evaluate the use of other features, e.g., average peptide length, for more advanced normalisation using a CQN approach [@hansenRemovingTechnicalVariability2012].

##### Establish a generalized linear model (GLM)
The second step in my proposed work plan consists of establishing a generalised linear model (GLM) framework for count regression in metaproteomics.
Development will start from well-established tools for modelling bulk RNA sequencing (RNA-seq) data.
A preliminary edgeR [@robinsonEdgeRBioconductorPackage2010] analysis that we’ve performed shows that metaproteomics counts exhibit a similar mean-dispersion relation as RNA-seq data.
Hence, negative binomial (NB) count regression and existing empirical Bayes methods to stabilise the dispersion estimation seem to be promising for metaproteomics data analysis applications.
The GLM framework also naturally extends the analysis beyond two group comparisons and enables for normalisation.
Indeed, experiments with more complex designs can be accommodated for by including factors with multiple levels and even continuous covariates in the model, and normalisation offsets can be included in the linear predictor.
Finally, the challenge to detect shifts in communities, e.g., at a certain taxonomic level, shows many similarities with assessing differential transcript usage in bulk RNA-seq experiments, where researchers try to discover shifts in the relative abundance of isoforms within a gene.
Again, we will have to port and tailor these tools towards metaproteomics.

##### Perform statistical inference
Within the GLM framework, likelihood ratio tests, score tests and Wald tests can be conducted.
We can evaluate their performance within an empirical Bayes context and in terms of computational efficiency.
Next, false discovery rate (FDR) methods should be adopted and more advanced FDR methods will be developed for metaproteomics applications.
Specifically, we can build upon stage-wise testing procedures that have proven their merits for transcript level analysis and gene-set enrichment analysis [@vandenbergeStageRGeneralStagewise2017].

##### Develop a user-friendly workflow and integrate into Unipept
The last step that I can propose for this workplan is to integrate all of the methods and strategies that where developed during the previous tasks into a user-friendly workflow for the Unipept web application.
For each of the steps we will have to consider whether to implement the step in JavaScript and run it directly in the browser, or to offload it to an R instance running server-side.
The latter will probably require less implementation work because of the available R packages but comes at the cost of less flexibility and interactivity.
During the implementation phase, it is extremely important to gather feedback from end-users to iterate on the proposed solution.
