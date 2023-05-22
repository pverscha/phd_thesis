\mainmatter

\renewcommand{\chaptermark}[1]{\markboth{\textsf{Chapter \thechapter.~ Introduction}}{}}
\renewcommand{\sectionmark}[1]{\markright{\textsf{Chapter \thechapter.~ Introduction}}}

## Introduction

\pagestyle{fancy}

*The research presented in this PhD thesis is situated at the overlap of computer science and biotechnology.
In order to fully understand and grasp the concepts that are presented throughout this thesis, it is important that I first introduce a set of terms, definitions and techniques that are extensively used throughout this work.*

### Biotechnological concepts

#### The central dogma in biology
Every organism in our universe is made up of cells and each of these cells contains the instructions that define what the organism is, how it behaves and how new proteins or other products should be created.
Each cell contains an exact copy of these instructions.
These instructions can be compared with a recipe book that describes and instructs a cook to bake a specific kind of cake.
All recipes are collected in this book, and every cell has an exact copy of this recipe collection.
Whenever a client in the restaurants requests a dish, the request is sent to the kitchen where the cook selects the appropriate recipe from the recipe book and starts making the dish.

This is a simple analogy to explain how DNA and RNA are used throughout the cells of an organism to create new proteins (\autoref{fig:recipe_book_analogy}).
Our book of recipes represents the DNA that is present in every cell.
RNA, on the other hand, can be regarded as a copy of a single recipe in the book, while the final dish itself corresponds to a single protein.

We can continue to use this analogy to explain exactly what the central dogma of biology is and how it works.
The first step in making a dish is to choose a recipe from the book, a process that's called **transcription**.
In transcription, a section of DNA is copied into an RNA-sequence (more specifically messenger-RNA, or mRNA), which serves as a template for building proteins later on.

Next, all the necessary ingredients for the dish are gathered.
These can be thought of as the raw materials that are needed to build a protein.
For proteins specifically, these raw materials are amino acids, which are brought to the site of **protein synthesis** by a molecule called **transfer-RNA** (or tRNA).

Once all the ingredients have been delivered to the construction site, the cell follows the instructions in the encoded recipe (or thus the instructions encoded by a strand of messenger-RNA, or mRNA), during a process called **translation**.
During the translation phase, this mRNA template is read by a ribosome which assembles all required amino acids in the correct order to form a protein.

The concept explained above, is called the **central dogma of biology**.
It is one of the most fundamental principles of molecular biology and was first depicted in 1958 by Francis Crick who also reformulated it in a manuscript published in Nature in 1970 [@crickCentralDogmaMolecular1970].
The central dogma explains how proteins in organisms are constructed and is very important to grasp in order to understand a lot of the basic principles of biology.

See also \autoref{fig:cell_chromosome_gene} for the relation between a cell, chromosomes, genes and DNA. These are all components that play a very important role in the central dogma and form the basis of living organisms.

![The central dogma in biology can easily be explained with the recipe book analogy. The DNA corresponds to a recipe book that contains the recipe for every dish that can be made. A copy of a single recipe corresponds to the concept of RNA and a dish corresponds to a single protein that's been completely assembled. \label{fig:recipe_book_analogy}](resources/figures/chapter1_recipe_book.eps)

##### DNA
DNA stands for **D**eoxyribo**N**ucleic **A**cid and, as explained above, contains the instructions on how all proteins in an organism can be constructed.
A copy of the complete DNA of an organism is present in every cell of this organism and is organised in chemical structures that we call **chromosomes**.
These so-called chromosomes mostly appear in pairs (humans, for example, have 23 pairs of chromosomes).

Chromosomes themselves are then further divided into specific regions that we refer to as **genes**.
A gene is a well-defined region of DNA that corresponds to the instructions required to construct one specific protein (and thus corresponds with one recipe of our book of recipes analogy that we used earlier).

The DNA is made up of a sequence of nucleotides (simple molecules that can be chained together) that are always represented by the four letters A, C, G and T.

The famous double helix structure of DNA was first discovered by Francis Crick, James Watson, Rosalind Franklin and Maurice Wilkins after Franklin obtained images of DNA using X-ray crystallography.
This discovery was done in 1953 and is of very big importance for the research that is presented in this work.

![Relation between a cell, chromosomes, genes and DNA. All chromosomes are collected in the cell nucleus. A chromosome is a structure that consists of DNA and the DNA consists of well-defined pieces that we refer to as genes. \label{fig:cell_chromosome_gene}](resources/figures/chapter1_cell_chromosome_gene.eps)

##### RNA
RNA stands for **R**ibo**N**ucleic **A**cid and is chemically very similar to DNA.
Instead of Thymine, RNA uses its complement Uracil (represented by U), but the other three nucleotides A, C and G remain the same.
Unlike DNA, RNA is found in nature as a single strand folded onto itself, rather than a paired double strand.

There exist different types of RNA that are each responsible for an important process in the creation of proteins.
Cellular organisms (such as humans) use messenger RNA (mRNA) to convey genetic information that is subsequently used to direct the synthesis of specific proteins.
A second important type of RNA is the transfer RNA (tRNA) which is used for bringing amino acids to the site where protein synthesis takes place.
Lastly, a third important type is the ribosomal RNA (rRNA) that is responsible for chaining together amino acids to form finished proteins.

##### Proteins
Proteins are large, complex molecules composed of long chains of amino acids.
Although hundreds of amino acids exist in nature, only 20 of them will appear in proteins.
Every amino acid has its own chemical properties and is generally represented by a single capital letter: K stands for lysine, R stands for arginine, etc. 
It is the specific ordering of these amino acids that defines the function and structure of a protein.

![Schematic depiction of how information recorded in a gene is converted (or synthesized) into a protein. The DNA in a gene is first converted to mRNA (transcription). The mRNA will then be read in groups of 3 nucleotides at a time and matched with amino acids. The final sequence of amino acids constructed this way corresponds with a protein. \label{fig:dna_transcription_translation}](resources/figures/chapter1_dna_transcription_translation.eps)

Proteins can have a variety of different functions in an organism.
They can act as enzymes (that help to catalyze chemical reactions), they can support the immune system, act as transporters, take care of communication between important processes (hormones), etc.
In short, proteins are a critical component of living organisms and play many important roles in maintaining health and supporting life processes.

A protein will be constructed from an mRNA strand by the **ribosomes**.
These are large molecules that link amino acids together to form proteins in a process called protein synthesis.
See \autoref{fig:dna_transcription_translation} for a schematic overview of the protein synthesis process.

#### (Meta)genome, (meta)transcriptome and (meta)proteome
The **genome** of an organism can be defined as the collection of DNA that is present in this organism.
It defines which proteins can potentially be constructed by the organism.
Secondly, the **transcriptome** of an organism is simply the set of all RNA transcripts in an organism and already provides a little more information about which parts of the DNA do actually encode proteins.
Lastly, the **proteome** of an organism is the collection of all proteins that are expressed by an organism.

In this thesis, we mainly discuss the terms **meta**genome, **meta**transcriptome and **meta**proteome.
Instead of respectively refering to the collection of genes, transcripts and proteins that can be expressed by a single organism, the **meta** prefix denotes that we are respectively talking about the set of genes, transcripts or proteins that can be expressed by a **collection** of different organisms (typically of the same biological environment).
See \autoref{fig:proteome_metaproteome} for a schematic display of the proteome and metaproteome.

![A schematic overview of the proteome and the metaproteome. The proteome is defined as the proteins that can be expressed by a single organism. The metaproteome, on the other hand, is then defined as the set of proteins that can be defined by a collection of organisms. \label{fig:proteome_metaproteome}](resources/figures/chapter1_proteome_metaproteome.eps)

Since our DNA provides the instructions for all proteins that can possibly be expressed, it provides no suitable information about which proteins are really being expressed at a specific moment in time.
By exploring the genome, it is thus possible to deduce what an organism is capable of doing, but not what it actually *is* doing right now.
Not all pieces of an organism's DNA have a "meaning" or will lead to suitable proteins.
Around 98% of the human genome is **non-coding**, meaning that these parts of the DNA will never be synthesized to a meaningful protein, but rather to regulatory sequences, non-coding genes or something that has not been discovered yet.

Studying the transcriptome of an organism has several advantages over studying the genome.
First of all, it allows researchers to understand dynamic changes that can present themselves during the transcription process in a cell.
The transcriptome reflects the dynamic changes in gene expression that occur in response to environmental cues, developmental stages, and disease conditions.
In contrast, the genome remains mostly static, with relatively stable genetic sequences.
As the transcriptome of an organism captures the expression of genes at a specific time and in a specific context, it provides more information to a researcher and it might help them to understand the underlying mechanisms of diseases, drug responses and other complex biological processes.
Finally, the transcriptome can also be used to study the regulation of gene expression, including alternative splicing, post-transcriptional modifications, and non-coding RNA expression.

The study of the proteome is important for understanding many aspects of biology and medicine. By analyzing the proteins that are present in a particular cell or tissue, researchers can learn more about how it functions and how it responds to different conditions or treatments.
This knowledge can be used to develop new therapies for diseases, as well as to improve our understanding of basic biological processes.

#### Metaproteogenomics
In recent years, there has been a growing interest in a cutting-edge research discipline called *metaproteogenomics*, which is revolutionizing our understanding of microbial communities and their functional dynamics.
metaproteogenomics represents a powerful and interdisciplinary approach that combines metagenomics and metaproteomics to provide a comprehensive understanding of microbial communities. 
By leveraging the strengths of both fields, researchers can achieve more accurate taxonomic assignments, unravel the functional potential of microorganisms, and gain insights into the intricate interplay between the genetic information encoded in the metagenome and the expressed proteins in a community.
Metaproteogenomics is driving advancements in our knowledge of microbial ecology, paving the way for new discoveries and applications in diverse scientific domains.

#### Shotgun metaproteomics (analysing the metaproteome)
In this work, we focus on analysing the **metaproteome** of an ecosystem.
The term metaproteomics was first coined by Paul Wilmes in 2004 [@wilmesApplicationTwodimensionalPolyacrylamide2004] and was previously referred to as **community proteomics** [@wilmesMetaproteomicsStudyingFunctional2006].
We will first explain how proteins can be identified from a biological sample by using a very advanced device called a **mass spectrometer**.
Currently, most researchers are using a technique called **shotgun proteomics** when analysing a protein sample and follow a predefined set of steps.
Each of the different steps in shotgun proteomics (\autoref{fig:shotgun_metaproteomics}) will be covered in detail in this section.

![Overview of the different steps in a typical shotgun metaproteomics analysis pipeline. Each step comes with its own set of challenges that need to be overcome for which dedicated tools have been developed. \label{fig:shotgun_metaproteomics}](resources/figures/chapter1_metaproteomics_pipeline.eps)

##### Protein digestion
Since a protein is typically a molecule that is too big to be analysed by a mass spectrometer, it first needs to be cut into smaller fragments or **peptides**.
The process of cutting a protein into peptides is called **protein digestion** and is performed using a specific enzyme: trypsin.
Other proteases (i.e. enzymes that can be used to digest proteins) exist, but trypsin is by far the most popular one since it digests and usually *cuts* the protein at a fixed position: whenever the amino acids lysine (K) or arginine (R) are encountered, the protein will most-probably be cleaved by trypsin (except when lysine or arginine are directly followed by proline (P) or because trypsin missed a cleavage site, which does happen sometimes).
All peptides that are the result of a tryptic digest of proteins are called **tryptic peptides**.
See \autoref{fig:trypsin_digestion} for an example of a tryptic digestion of 2 proteins.

![Digestion of two proteins using the protease trypsin. The amino acids depicted in red are either lysine (K) or arginine (R) and indicate the location where trypsin will cleave the protein (except if one of these is directly followed by proline (P). In the second protein there will be no cleave after the second occurrence of lysine, since the next amino acid is proline. \label{fig:trypsin_digestion}](resources/figures/chapter1_trypsin_digestion.eps)

##### Mass spectrometry
Before we can start to explain the different steps in shotgun metaproteomics, we need to provide a basic understanding of the mass spectrometer.
A mass spectrometer is a very advanced and expensive device that allows us to measure the "weight" of molecules.
Instead of measuring the force of gravity on an object (which is what a traditional scale does), a mass spectrometer uses magnetic and electric fields to measure the **mass-to-charge** ($m/z$) ratio of the particles in the input sample.

Typically, molecules will be ionized (or charged) after which their mass-to-charge ratio is measured.
Mass spectrometry typically begins by vaporizing or dissolving the sample of interest and injecting it into a mass spectrometer.
Next, the sample is ionized, usually by bombarding it with high-energy electrons, or by using a laser.
This process converts the molecules in the sample into charged ions which can then be separated based on their mass-to-charge ratio using a combination of electric and magnetic fields.
The ions are accelerated through these fields, causing them to be deflected in different directions depending on their mass-to-charge ratio.
The resulting ion separation creates a mass spectrum, which shows the relative abundance of ions at different mass-to-charge ratios.

These "mass-to-charges" for each of the particles that were found in the input sample can be visualised as a **mass spectrum** (see \autoref{fig:mass_spectrum}).
Each peptide that's fed into the mass spectrometer produces such a mass spectrum, which is not necessarily unique (i.e. different peptides can produce the same mass spectrum) and the following step in shotgun metaproteomics consists of mapping these mass spectra onto peptide sequences.

![Example of a mass spectrum for the peptide WNQLQAFWGTGK/2, taken from [@bittremieuxSpectrumUtilsPython2020]. The different peaks in the spectrum correspond with the observed "mass-to-charge" ratio of the different particles of the input sample. \label{fig:mass_spectrum}](resources/figures/chapter1_mass_spectrum.svg)

We have to make a distinction between mass spectrometry consisting of a single step (MS1 mass spectrometry) and tandem mass spectrometry (often denoted as MS/MS or MS\textsuperscript{2}).

##### MS1 vs Tandem Mass Spectrometry (MS/MS)
MS1 is a type of mass spectrometry that measures the mass-to-charge ratio (m/z) of intact peptides or proteins.
In MS1, the peptide mixture is ionized and then introduced into the mass spectrometer, which separates the ions based on their m/z ratio.
The resulting spectra represent the mass distribution of the entire peptide population, without any information about the sequence of individual peptides.

MS/MS, also known as tandem mass spectrometry, is a more advanced form of mass spectrometry that provides more detailed information about the peptide sequence.
In MS/MS, the peptide mixture is first subjected to MS1 analysis to select a particular peptide ion of interest.
Then, this ion is isolated and fragmented into smaller fragments using collision-induced dissociation.
The resulting spectra provide information about the amino acid sequence of the peptide, as well as the types and positions of any post-translational modifications.

##### Matching mass spectra with peptide sequences
Now, in order to map mass spectra back to peptide sequences, researchers use **search engines**.
These search engines are complex software applications that contain a list of peptides and the corresponding expected mass spectra and that try to match the experimentally obtained spectra with the theoretically modelled mass spectra in their database.

How exactly this is done is out-of-scope for this work, but more information can be found in [@BenchmarkImprovingMethods2022].
The most important thing to realize at this point is that the data that comes out of the mass spectrometer (i.e. the mass spectra) can be converted into the peptide sequences that most probably occur in the input sample.
The CompOmics group at Ghent University, led by Prof. Lennart Martens, is specialised in the development of novel search engines, such as IONBOT [@degroeveIonbotNovelInnovative2022].

Once a list of peptide sequences has been determined, the data is finally ready to be sent to Unipept (or other tools) for further downstream analysis (\autoref{fig:shotgun_metaproteomics}).

##### Protein inference problem
In metaproteomics, the protein inference problem involves identifying the proteins from the different microorganisms present in the sample, and determining their relative abundances.
This is difficult because the sample may contain thousands of different microorganisms, each with its own unique set of proteins, and the proteins from different microorganisms may have very similar amino acid sequences or fragment ions.

There exist some approaches in which proteins are inferred based upon a set of identified peptide sequences.
In this case, every peptide sequence provides *evidence* for a specific set of proteins and specialized algorithms have been developed to perform protein inference by exploiting these evidence values.
A more in-depth explanation of one of these techniques, called protein grouping, can be found in \autoref{chapter:other_projects}. 

The problem of protein inference is already challenging in the context of proteomics research, where all observed peptides originate from a single organism.
In metaproteomics, this problem is even harder since different proteins of different organisms can be very similar, making it harder to distinguish them from each other.

##### Taxonomic and functional analysis of metaproteomics
In order to compile a taxonomic and functional report for an ecosystem under study, downstream analysis tools (such as Unipept) are used.
These tools typically rely on external databases for retrieving functional and taxonomic annotations and the approach followed to infer these annotations can broadly be classified in three different categories:

1. **Peptide-centric approach:** Tools that are peptide-centric rely solely on identified peptides and do not infer the corresponding proteins, thereby circumventing the protein inference problem. This approach is less complex, but nonetheless, has a drawback, as it does not use the complete protein sequence information. Longer sequences are more likely to be unique to more specific taxa, which improves taxonomic resolution.
2. **Protein-centric approach:** Tools that are protein-centric will first try to infer which proteins are expressed in the ecosystem under study (by looking at the identified peptide sequences or the mass spectra that were generated by a mass spectrometer). This allows analysis tools to exploit more information in the sample and to build a more complete picture of all taxonomic and functional properties of the microbial community present in the sample, as it considers the biological context of the proteins. On the other hand, the protein-centric approach requires more computational resources and may be more challenging to implement than peptide-centric approaches, particularly for samples with a high degree of complexity. Additionally, the protein-centric approach may miss some proteins that are present in low abundance or that are not well-represented in existing protein databases.
3. **Hybrid approach:** Some tools can not directly be categorized in one of the first two categories, but instead follow a combined / hybrid approach.

### The metaproteomics analysis tools landscape
A lot of different tools exist for the analysis of metaproteomics datasets.
Each of these tools has its own speciality, and different tools typically aim to overcome a different challenge that might occur during the analysis of metaproteomics data.
A brief overview of the most commonly used tools for **downstream** metaproteomics analysis is presented here.

#### MetaProteomeAnalyzer (MPA)
First released in 2014, the MetaProteomeAnalyzer (MPA) [@muthMetaProteomeAnalyzerPowerfulOpenSource2015] is an open-source Java tool that performs the taxonomic and functional analysis of metaproteomics data.
In order to do so, MPA uses a sequence-based and spectral-based approaches to identify the organisms and functional pathways present in a sample.
This allows researchers to gain insights into the metabolic activities of microbial communities and their interactions with the environment.
MPA includes multiple search engines and the feature to decrease data redundancy by grouping protein hits to so-called meta-proteins.

The first version of the MetaProteomeAnalyzer follows a client-server architecture where the client is a graphical Java software application that uploads data to a server (which is responsible for processing this data) and keeps track of datasets that have been analysed previously.
In 2018, MPA Portable [@muthMPAPortableStandAlone2018] was also released.
In contrast to the original server-based MPA application, MPA portable no longer requires computational expertise for installation, it is independent of any relational database system and it provides support for the latest state-of-the-art database search engines.

Compared to Unipept, MPA expects a list of mass spectra as input and combines the results of different search engines for a later taxonomic and functional analysis.
In 2020, the MetaProteomeAnalyzer (and PeptideShaker) have been connected to Unipept [@vandenbosscheConnectingMetaProteomeAnalyzerPeptideShaker2020], which allows researchers to further analyse and visualise the identified peptide sequences using Unipept. 

#### Prophane
Prophane [@schiebenhoeferCompleteFlexibleWorkflow2020] is a software tool that was first released in 2011 and that offers taxonomic and functional annotation of metaproteomes based on various annotation databases, interactive result visualization, and an intuitive web service.
It integrates results from various data sources such as NCBI, UniProt, eggNOG or PFAMs.

In contrast to Unipept, Prophane follows a protein-centric approach and tries to perform the taxonomic and functional analysis on this basis.
The tool is available as a Conda package or as a web service.

#### MetaLab / iMetaLab
MetaLab [@chengMetaLabAutomatedPipeline2017] is an integrated software platform that provides a pipeline for fast microbial identification, quantification and taxonomic profiling.
In order to do so, MetaLab requires mass spectrometry raw data.

MetaLab follows a hybrid approach and thus combines the information extracted from performing both a peptide-centric and protein-centric metaproteomics analysis.
Similar to Unipept, MetaLab builds a precomputed index of the UniProtKB and uses this as a source for the taxonomic classification of identified peptides.
While Unipept also uses UniProt for the retrieval of functional annotations, MetaLab extracts its functional information from the eggNOG [@huerta-cepasEggNOGHierarchicalFunctionally2019] database.

### Unipept
Unipept is an ecosystem of software tools that are mainly focussed on the analysis of metaproteomics datasets.
Prof. Dr. Bart Mesuere, co-supervisor of this PhD thesis, initially started the Unipept project at Ghent University in 2010 in the context of his PhD.
Since its early days, Unipept has undergone a big transition, while still maintaining its initial focus of providing an excellent user experience and top-of-the-line performance when compared to similar tools.

#### The Unipept ecosystem
All tools in the Unipept ecosystem work by taking a list of tryptic peptide sequences as input and matching these peptides with the proteins in a **protein reference database** in order to provide a taxonomic and functional summary for this input sample.
Every Unipept tool has its own target audience and functionality.
See the list in the next subsection for more information on the tools that currently exist and what each of these is aimed at.
\autoref{fig:unipept_timeline} presents a timeline with all major milestones that Unipept achieved over the last 13 years.

![Timeline of tools in the Unipept ecosystem and perspective on when I joined the team in 2018. \label{fig:unipept_timeline}](resources/figures/chapter1_unipept_timeline.eps)

##### Unipept Web application (2012)
The first real Unipept tool that was presented to the outside world, is the Unipept Web application.
This app is accessible at [https://unipept.ugent.be](https://unipept.ugent.be) and provides a user friendly web component that allows users to perform metaproteomics analysis and consult the results that are presented to them as a collection of visualizations and tables.
All information that is provided by our web application can easily be exported (and can subsequently be imported into other tools for further analysis).

##### Unipept CLI (2015)
For power-users that require the metaproteomics analysis of many large samples, we provide the Unipept command line interface (CLI).
This command line interface allows Unipept's analysis to be plugged into existing analysis pipelines and allows machines to automate specific steps.
Unlike the web application, the CLI has no graphical user interface and mainly provides textual output (support for visualizations is also limited).

##### Unipept API (2015)
The Unipept API (Application Programming Interface) is a collection of endpoints that allow third-party applications to integrate some of Unipept's functionality into their own workloads.
Data can be sent to each endpoint using `HTTP POST` or `GET` requests to our servers, after which the Unipept server will respond with the requested results as a `JSON`-formatted object.

##### Unipept Desktop (2021)
Unlike the previous three tools, the Unipept Desktop application has been added to our ecosystem very recently and does not necessarily needs to communicate with the Unipept servers in order to function.
The desktop application combines some of the advantages of the web app, CLI and API into one and allows users to process large metaproteomic samples using a user friendly graphical user interface (making it more accessible to less tech-savvy users).
It is similar to the CLI in the way that it allows to process much larger samples than the web application, and requires less technical skills to operate.
The biggest difference with the web application is the fact that it cannot be plugged into existing analysis pipelines as easily, but it's also not designed to do so.

##### UMGAP (Unipept MetaGenomics Analysis Pipeline) (2022)
UMGAP, or the Unipept MetaGenomics Analysis Pipeline, is a bit of an outsider because it focuses on the analysis of metagenomics data (instead of metaproteomics data).
This pipeline has been developed by Dr. Felix Van der Jeugt and is only accessible from the command line.
Since all tools presented in this thesis focus solely on the analysis of metaproteomics data, we will not go into more detail here.

#### The Unipept MetaProteomics Analysis Pipeline
In this section, we are going to take a look at how exactly a metaproteomics data sample is processed by Unipept.
Every input sample consists of a list of tryptic peptide sequences.
Non-tryptic peptides will be ignored by Unipept, since they cannot be matched with the information in our **peptide reference database**.

##### Construction of the peptide reference database
Grasping how a peptide reference database is being used by Unipept is already one of the most important things that help to understand how Unipept processes input samples and generates a taxonomic and functional profile for an ecosystem.
A peptide reference database can be seen as some kind of information resource that maps peptides onto organisms and functions, associated with these peptides.
In order to construct this database, we extract all proteins (including their mapping to organisms and functions) from the UniProtKB resource [@theuniprotconsortiumUniProtWorldwideHub2019].
UniProt is an organization that focuses on providing a protein database that is as complete as possible.
It contains full protein sequences and information about the organisms and functions that these proteins are associated with.

The UniProtKB resource consists of two major parts: TrEMBL and SwissProt.
TrEMBL (Translated EMBL Nucleotide Sequence Data Library), the largest of the two, contains 250 million proteins at this time (version 2023.2) and is an automatically annotated protein database.
This means that the data is generated by a computer program without manual curation.
TrEMBL is built from translations of all publicly available nucleotide sequences in the EMBL (European Molecular Biology Laboratory) database, which includes sequences from many different organisms.
Because TrEMBL is automatically generated, it is much larger than SwissProt, but it is also less accurate and less well-curated.
The advantage of TrEMBL, however, is that it contains a much larger number of protein sequences and can be useful for discovering new or uncharacterized proteins.

SwissProt, on the other hand, is a high-quality, manually curated protein database, which means that every entry is thoroughly reviewed, annotated and updated by experts to ensure that the information is accurate, consistent and up-to-date.
The data in SwissProt is carefully selected, filtered, and each entry includes a wealth of information about the protein, including its function, structure, interactions, and post-translational modifications.
SwissProt 2023.2 contains 596 000 different proteins at the time of writing.

Both TrEMBL and SwissProt are non-redundant databases, which means that they contain a unique set of protein sequences without any duplicates.
However, due to the different nature of TrEMBL and SwissProt, we have to make an important distinction between both.
TrEMBL is a non-redundant database in the sense that all identical, full-length protein sequences are represented in a single record (provided they come from the same species).
Fragments, isoforms, variants, and so on, encoded by the same gene, are stored in separate entries.
SwissProt is non-redundant in the sense that all protein products encoded by one gene in a given species are represented in a single record.
This includes alternative splicing isoforms, fragments, genetic variations, etc.

The non-redundancy of these databases is important for a couple of reasons.
First of all, it improves the performance of applications working with these databases.
Because identical entries are merged, the size of the database is decreased and the time needed to search through it is lower.
Secondly, the non-redundancy property of these databases improves the accuracy of the resource.
If a database contains the same records multiple times, it is harder to maintain this database and errors happen more frequently.

Since Unipept expects a user to provide a list of peptides (instead of proteins), we need to transform the information from the UniProtKB resource into a peptide reference database.
Internally, Unipept does so by performing an in-silico tryptic digest of the proteins encountered and cleaves them by the rules imposed by trypsin (see \autoref{fig:protein_to_peptide_db}).
Note that one tryptic peptide typically matches with more than one protein.
This makes sense since the proteins from organisms that have co-evolved closely over the years can be very similar to each other and that some of the peptides that result from tryptic digestion of these proteins are identical.
This actually happens relatively frequently and can even occur between organisms of very different lineages (sometimes purely due to chance).

![The Unipept database is constructed by extracting the proteins from the UniProtKB resource and performing an in-silico tryptic digest on each of the proteins. \label{fig:protein_to_peptide_db}](resources/figures/chapter1_protein_to_peptide_db.eps)

Since users only provide peptides to Unipept (and no other information), it is impossible to distinguish between the different proteins that match with one of the peptides from the input (e.g. if an input peptide appears in three different proteins A, B and C, it is impossible for Unipept to know if it should draw conclusions from protein A, B or C).
In order to overcome this issue, we simply report only information that is applicable to all matched proteins (or thus information that is correct in either the situation that the peptide originated from either protein A, protein B or protein C in the example above).

**Summarizing taxonomic information**

For taxonomic information, we aggregate all organisms that are associated with the protein matches of a single peptide and compute the lowest common ancestor for this set of organisms.
This lowest common ancestor is the most specific taxon in the NCBI taxonomy that is a direct or indirect parent of all organisms in the collection.
In \autoref{fig:lca_example1}, the lowest common ancestor of the organisms in the input set is the root node.
This example is one that occurs relatively frequently and in which case no valuable information can be reported by Unipept (apart from the fact that an organism was indeed found).
Compare this example to the one given in \autoref{fig:lca_example2}.
In this case, the lowest common ancestor of the two viruses from the input set is the *Coronaviridae* taxon.

![If the organisms in orange are selected, the lowest common ancestor of these organisms in the NCBI taxonomy will be the root node (organism), because this is the most specific node that is a parent of all organisms in the collection. \label{fig:lca_example1}](resources/figures/chapter1_lca_example1.eps)

![If the organisms in orange are selected, the lowest common ancestor of these organisms in the NCBI taxonomy will be *Coronaviridae*, because this is the most specific node that is a parent of both organisms. \label{fig:lca_example2}](resources/figures/chapter1_lca_example2.eps)

Instead of thus reporting all organisms that are associated with a peptide, Unipept reports the lowest common ancestor of these organisms (as demonstrated in the examples above).

**Summarizing functional information**

In order to summarize the functional information of a single peptide, Unipept simply counts how many times each functional annotation appears in the matched set of proteins.
To make this more concrete, if a peptide occurs in proteins A, B and C, and function X is associated with protein B and C, and function Y is associated with protein A, then function X will be reported as occurring twice for this peptide and function Y will be reported to occur once.

##### Processing a metaproteomics dataset
In order now to process a list of peptides, Unipept will match each of the input peptides with its peptide reference database and report all lowest common ancestors and functional annotations found per peptide.
For a single sample, it will then provide something in the line of "species x was found to occur in 12 out of 153 total peptides" (and it will do so for every identified taxon).
This information is not only presented in a textual fashion, but will also be rendered by a collection of interactive data visualizations (which have been designed and implemented in-house [@verschaffeltUnipeptVisualizationsInteractive2022]).

### Expanding the Unipept ecosystem
#### Part I: The need for the Unipept Desktop application
Throughout my PhD thesis, I have encountered various challenges in pursuit of my research goals that needed to be overcome.
One notable challenge is the large increase in volume of data that needs to be processed, surpassing any previous benchmarks [@zhangPerspectiveGuidelinesMetaproteomics2019;@kleinerMetaproteomicsMuchMore2019].
Consequently, the current approach employed by Unipept necessitates significant improvement.
The limitations imposed by web browsers render the Unipept web application inadequate for handling this scale of data analysis.
While matching peptides with taxonomic and functional annotations is performed server-side, the task of summarizing this information and constructing interactive data visualizations is carried out client-side, relying on the end-user's machine.
As analyses become more time-consuming, particularly when combined with specific configuration options of Unipept, it is increasingly desirable to have the capability to pause and resume the process, as well as to save analysis results offline for future reuse.

In order to facilitate metaproteogenomics analyses, Unipept needs to possess the capability to query a specific subset of the protein reference database.
Specifically, only proteins associated with organisms identified in a prior metagenomics experiment should be considered during the metaproteomics analysis.
This, however, renders all precomputations that are performed during the construction of the server-side protein reference database useless and causes the analysis time to increase dramatically (from a few minutes to multiple hours or even days).
Not only does this cause a significant delay when working with these metaproteomics samples, it also requires a massive amount of computational power for Unipept to handle these expensive queries for multiple users concurrently.

By building a new Unipept Desktop application, we can overcome both of these major challenges and provide a novel approach to analyse both metaproteogenomics datasets, as well as the increasingly larger modern metaproteomics datasets.
Unipept Desktop, which is what this novel desktop application is called, is able to maximally utilize the computational power of an end user's machine and provides support for saving analysis results offline.
The desktop application also allowed me to move the protein reference database from the server to the client, allowing researchers to construct a custom, filtered database that only contains those proteins associated with organisms identified by a prior metagenomics experiment.
All required precomputations and in-silico tryptic digestion of the proteins in this database is performed locally, by each end-user individually, alleviating the Unipept servers from this intensive task.

In \autoref{part:unipept_desktop} of my PhD thesis, I explain in more detail how the Unipept Desktop application is constructed and how the migration of the protein reference database is handled.

By leveraging the Electron framework that allows us to use web technologies to build desktop applications, we can reuse a large portion of the code behind Unipept's web application.
The graphical user interface of the Unipept Web application has been rewritten and restructured into a collection of standalone web components that are subsequently isolated into the Unipept Web Components software library.
By doing so, a new feature or a fix for a bug only needs to be implemented once (as part of the web components library) and avoids me having to implement the same change twice.

#### Part II: Building new tools in the Unipept ecosystem
The second part of this PhD thesis, \autoref{part:unipept_ecosystem}, contains a summary of other tools that have been developed and further aid the analysis of metaproteomics data.
Each of these tools tackle an existing problem in metaproteomics and provide a suitable approach to overcome the associated challenges linked to these problems.

##### Unipept CLI / API 2.0
Since the latest release of the Unipept Web application (version 4.0), we have introduced support for functional analysis of metaproteomics datasets.
However, this advanced functional analysis pipeline was not yet accessible through the Unipept CLI and API, making it challenging to conduct such analyses on large samples and incorporate them into third-party applications.

To address this limitation, I have enhanced the Unipept CLI in version 2.0 by adding seven new commands to the command-line interface.
Five of these commands empower researchers to extract functional information from the database.
Additionally, two new commands, namely `taxa2tree` and `taxonomy`, have been included to facilitate the export functionality of basic interactive data visualizations.

In line with these improvements, the Unipept API version 2.0 now offers six new endpoints.
These endpoints allow seamless integration of Unipept's functional analysis pipeline into third-party applications, enabling developers to leverage its capabilities effectively.

##### MegaGO
A key feature of metaproteomics research is finding out what a collection of microorganisms is doing in an ecosystem by creating a functional profile.
Numerous different ontologies exist that each provide an ontology and definition for the different functions that occupy organisms. 
The Gene Ontology [@thegeneontologyconsortiumGeneOntologyResource2019] is an example of one such ontology and is widely used in the field of metaproteomics (and beyond) [@maddaProteomicProfilingIdentification2020;@vuProteinFunctionPrediction2021;@conesaBlast2GOUniversalTool2005].

In order to highlight the differences and shifts in exposed functionality between different ecosystems and organisms, it is important that we can efficiently compare how "similar" two sets of GO-terms are.
A lot of different similarity metrics that fulfill this purpose have been developed over the years, but accessible and performant tools that allow these to be used are currently lacking.

MegaGO is a web application (and command line tool) that is developed specifically for this purpose.
It highly exploits the parallelism of modern CPUs with multiple processing cores by efficiently spreading the numerous computations required to determine set-based similarity over all of those cores.
Since computing the similarity of two sets containing respectively $m$ and $n$ GO-terms requires approximately $m*n$ comparisons, an efficient approach was required.

Additionally, the similarity metric that was eventually chosen for the comparison of two GO-terms, the Lin-semantic similarity metric [@linInformationTheoreticDefinitionSimilarity1998], requires a baseline of how "frequent" each GO-term occurs on average in the real world.
In order to compute these average occurrences, we focus on the proteins found in the UniProtKB database (SwissProt).
Because of the size of this database, these frequency counts are precomputed beforehand by the servers provided by GitHub and are automatically updated after every new release of the SwissProt database.
A new release of the MegaGO software package is automatically published on PyPi after each update of the term frequency counts and an new version of the associated web application (accessible at [https://megago.ugent.be](https://megago.ugent.be)) is automatically deployed as well.

##### Other tools in the Unipept ecosystem

