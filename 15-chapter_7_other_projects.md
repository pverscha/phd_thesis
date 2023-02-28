## Other projects {#chapter:other_projects}
\renewcommand{\sectionmark}[1]{\markright{\textsf{Chapter \thechapter.~ Other projects conducted during my PhD}}}

*During the course of my career as a PhD student, I have also been working on a lot of different research projects for which I was not the main contributor, but for which I, nonetheless, provided a significant addition.
I have selected two of these projects and included them as sections in this chapter.*

\newpage

### Pout2Prot: An efficient tool to create protein (sub)groups from Percolator output files

\color{gray}
*This section contains a verbatim copy of the manuscript by [@schallertPout2ProtEfficientTool2022] as submitted to Journal of Proteome Research.*
\color{black}


**Abstract** ---
In metaproteomics, the study of the collective proteome of microbial communities, the protein inference problem is more challenging than in single-species proteomics.
Indeed, a peptide sequence can be present not only in multiple proteins or protein isoforms of the same species, but also in homologous proteins from closely related species.
To assign the taxonomy and functions of the microbial species, specialized tools have been developed, such as Prophane. This tool, however, is not directly compatible with post-processing tools such as Percolator.
In this manuscript we therefore present Pout2Prot, which takes Percolator Output (.pout) files from multiple experiments and creates protein group and protein subgroup output files (.tsv) that can be used directly with Prophane.
We investigated different grouping strategies and compared existing protein grouping tools to develop an advanced protein grouping algorithm that offers a variety of different approaches, allows grouping for multiple files, and uses a weighted spectral count for protein (sub)groups to reflect abundance.
Pout2Prot is available as a web application at [https://pout2prot.ugent.be](https://pout2prot.ugent.be) and is installable via pip as a standalone command line tool and reusable software library.
All code is open source under the Apache License 2.0 and is available at [https://github.com/compomics/pout2prot](https://github.com/compomics/pout2prot).

#### Introduction
In metaproteomics, the study of the collective proteome of whole (microbial) ecosystems, it is important to learn about the taxonomy and functions represented in the community.
For this purpose, tools such as Unipept [@verschaffeltUnipeptDesktopFaster2021] and Prophane [@schiebenhoeferCompleteFlexibleWorkflow2020] have been made available to specifically perform downstream annotation of metaproteomic data, while other, more generic tools also provide connections to downstream annotation tools [@schiebenhoeferCompleteFlexibleWorkflow2020; @vandenbosscheConnectingMetaProteomeAnalyzerPeptideShaker2020; @muthMetaProteomeAnalyzerPowerfulOpenSource2015].
These tools, however, work very differently: while Unipept relies on identified peptides without inferring the corresponding proteins (a peptide-centric approach), Prophane uses protein groups as input (a protein-centric approach).
Recently, these two tools were compared in the first multilab comparison study in metaproteomics (CAMPI), [@vandenbosscheCriticalAssessmentMetaProteome2021] which indicated that the choice between these approaches is a matter of user preference.

The process of grouping proteins is unfortunately not as straightforward as it might first appear [@martensProteomicsDataValidation2007; @uszkoreitPIAIntuitiveProtein2015; @audainIndepthAnalysisProtein2017; @nesvizhskiiInterpretationShotgunProteomic2005].
Identified peptide sequences have to be assembled into a list of identified proteins, but when a peptide can be mapped to multiple proteins, this leads to the protein inference problem [@nesvizhskiiInterpretationShotgunProteomic2005].

In metaproteomics, this problem is exacerbated due to the presence of homologous proteins from multiple species in its necessarily large protein databases [@schiebenhoeferChallengesPromiseInterface2019].
Protein grouping is therefore commonly used to generate a more manageable list of identified protein groups that can be used for further downstream analysis.
However, different protein grouping algorithms can be chosen, leading to different lists of protein groups from a single set of identified peptides [@martensProteomicsDataValidation2007].

In the past, many protein grouping methods have been developed, as reviewed in Audain et al., [@audainIndepthAnalysisProtein2017] but these typically do not interface well with post-processing tools like Percolator, [@kallSemisupervisedLearningPeptide2007] which are able to increase the number of peptide-to-spectrum matches (PSMs) due to a better separation of true and false matches [@bouwmeesterAgeDataDrivenProteomics2020].
Moreover, the common strategy used by these tools is the Occam’s razor strategy, which is not always ideal [@vandenbosscheCriticalAssessmentMetaProteome2021].

We here therefore present a new tool, Pout2Prot, which provides users with two relevant protein inference options that are tailored toward metaproteomics use cases: Occam’s razor and anti-Occam’s razor.
Occam’s razor is based on the principle of maximum parsimony and provides the smallest set of proteins that explains all observed peptides.
Here, however, proteins that are not matched by a unique peptide are discarded, and their associated taxonomy and functions, which might actually be present in the sample, are lost.
This algorithm is for example used in the X!TandemPipeline [@langellaTandemPipelineToolManage2017].
On the other hand, anti-Occam’s razor is based on the maximal explanatory set of proteins, where any protein that is matched by at least one identified peptide will be included in the reported protein list.
This algorithm is used in, for example, MetaProteomeAnalyzer (MPA) [@muthMetaProteomeAnalyzerPowerfulOpenSource2015].
Unfortunately, there is no simple way to determine a priori which algorithm will be optimal, as this can differ from sample to sample [@muthMetaProteomeAnalyzerPowerfulOpenSource2015].
These strategies are visually represented in \autoref{fig:pout2prot_grouping_example}.

![Protein grouping algorithms Occam’s razor (left) and anti-Occam’s razor (right). Groups can be based on shared peptide rule (protein groups) or on shared peptide set rule (protein subgroups). This figure also illustrates how PSMs are assigned to protein (sub)groups and shows the weighted PSM count for subgroups. When a PSM is assigned to multiple subgroups, it will be calculated as one divided by the number of subgroups, which can result in fractional PSM counts.\label{fig:pout2prot_grouping_example}](resources/figures/chapter7_pout2prot_grouping_example.svg)

Moreover, as proteins are grouped based on their identified peptides, carefully defined rules are required on when and how to group these proteins.
There are two possible approaches here: the first approach consists of grouping all proteins that share one or more identified peptides (i.e., the shared peptide rule), while the second approach consists of only grouping proteins that share the same set (or subset) of identified peptides (i.e., the shared peptide set rule).
These two approaches can also be interpreted as grouping at two different levels: the protein group level (based on the shared peptide rule) and the protein subgroup level (based on the shared peptide set rule). These two approaches are also visualized in \autoref{fig:pout2prot_grouping_example}.

Pout2Prot implements all of these approaches: Occam’s razor and anti-Occam’s razor, and both of these at the protein group and protein subgroup level.
During conceptualization and testing, we discovered challenges with the naive description of these algorithms.
First, different protein subgroups can have the same peptide and therefore have the same spectrum assigned to them, leading to distorted spectrum counts.
Second, when removing proteins using Occam’s razor or when assigning subgroups using anti-Occam’s razor, “undecidable” cases can occur as illustrated in \autoref{fig:pout2prot_undecidable_cases}.
In these undecidable cases, the naive approach might produce inconsistent results when the algorithm is run multiple times.

![Illustration of undecidable cases. Undecidable cases are situations where peptides and proteins are matched in such a way that the naive interpretation of the algorithm cannot make a clear decision. Specifically, this occurs in Occam’s razor when one of two or more proteins can be removed to explain the remaining peptides (top), and this occurs in anti-Occam’s razor when a protein can be put into a subgroup with two or more other proteins that cannot be subgrouped together (bottom). \label{fig:pout2prot_undecidable_occam}](resources/figures/chapter7_pout2prot_undecidable_cases.eps)

In this manuscript, we describe a new command line tool and web application that can convert .pout files from different experiments into two files containing protein groups and subgroups either as .tsv for direct use with Prophane or as human readable .csv files.
Furthermore, we include a file converter that turns Proteome Discoverer output files into the .pout file format.
Thus, Pout2Prot enables Percolator (or Proteome Discoverer users) to use Prophane for downstream functional and taxonomic analysis.

#### Implementation
Pout2Prot is implemented in Python and installable as a Python package from PyPI.
It can then be invoked from the command line.
We also provide a user-friendly and easily accessible web application of our tool (https://pout2prot.ugent.be).
The transpiler Transcrypt (https://www.transcrypt.org/) was used to convert our Python package into JavaScript-compatible code and reuse it in our web application. Protein grouping analysis is efficient and can, consequently, be performed entirely on the user’s local machine.
Moreover, the web application processes all data locally, so that no data is sent to our servers.
This safeguards user data and allows researchers to analyze confidential information more safely.

The detailed implementation of the protein grouping algorithms is visualized in the Supporting Information (Figure S1 and S2) and consists of four sub-algorithms: the creation of protein groups, the removal of proteins using the rule of maximum parsimony, and a subgroup algorithm each for Occam’s razor and anti-Occam’s razor.

#### Evaluation
Pout2Prot converts .pout files to protein (sub)group files that can be immediately imported in Prophane for further downstream analysis.
This Prophane input file consists of four tab-separated fields: sample category, sample name, protein accessions, and spectrum count.
The sample category allows users to divide their experiment in different categories (e.g., “control” and “disease”).
If no sample categories are provided, these values will be identical to the sample name, which results in individual quantification by Prophane.
The sample name is identical to the name of the .pout file, so each protein (sub)group can be traced back to its origin file.
The protein accessions will contain the proteins present in the protein (sub)group, based on the chosen strategy.
Finally, the spectrum count contains the weighted spectrum count from all PSMs present in that protein (sub)group, with PSMs present in multiple subgroups counted as fractional values in each subgroup.

##### Qualitative comparison to other tools
To develop a protein grouping algorithm and to truly compare different protein grouping tools, the behavior of the algorithm must be validated against a set of well-defined data, where differences between expected and observed behavior (i.e., the composition of the groups) can be clearly distinguished.
During the development of Pout2Prot, it quickly became clear that multiple algorithms can solve certain test cases, but fail at others.
This also led to the discovery of the undecidable cases outlined in \autoref{fig:pout2prot_undecidable_cases}.
Therefore, we created 14 test cases (Supporting Information, Figures S3–S16) that capture all possible pitfalls of protein grouping algorithms, and solved those cases by using both Occam’s razor and anti-Occam’s razor at the protein group and subgroup level.
To resolve the issue of undecidability, we propose that no choice should be made at all.
For undecidable cases for protein removal (Occam’s razor), no protein should be removed, and for undecidable cases of protein subgroups (anti-Occam’s razor), the protein in question should remain in its own subgroup.

\label{tab:pout2prot_tool_comparison} shows the result of the comparison between five protein grouping tools: PIA, Fido (integrated into Percolator), MetaProteomeAnalyzer (MPA), X!TandemPipeline, and Pout2Prot.
To run tests with each tool, appropriate input files that reflect the test cases were created manually, and these are all available on the Pout2Prot GitHub repository.
If a test case did not produce the expected output, it was investigated more closely to ensure this was not the result of differences between, or potential errors in, these input files.
For undecidable cases, it was verified that the random choice behavior could be observed (i.e., multiple analyses, different results).
For anti-Occam’s razor subgrouping Cases 3 and 10, a difference in behavior was observed for PIA and Fido that can be attributed to a different conception of what a protein group is.
Specifically, if a protein’s peptide set is a strict subset of another protein’s peptide set, PIA and Fido will not group these two proteins, while MPA and Pout2Prot will.
Of all the tests that could be run, one resulted in an error: the algorithm for X!TandemPipeline for Case 13.
In this case, only one of the six proteins was put into a single group, which leads to a situation where one of the three peptides was not explained by the resulting groups.

\begin{table*}
\scriptsize
\centering
\begin{tabular}{p{0.13\textwidth}p{0.14\textwidth}p{0.18\textwidth}p{0.15\textwidth}p{0.16\textwidth}}\toprule
Tool & Occam grouping & Occam subgrouping & Anti-Occam grouping & Anti-Occam subgrouping\\ \midrule
PIA & \cellcolor{lightgray} & \cellcolor{PaleGreen1} case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14 successful & \cellcolor{lightgray} & \cellcolor{PaleGreen1} case 1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14 successful \\
& \cellcolor{lightgray} & \cellcolor{LemonChiffon1} case 12 undecidable & \cellcolor{lightgray} & \cellcolor{PaleTurquoise1} case 3, 10 different approach \\ \midrule
FIDO (Percolator) & \cellcolor{lightgray} & \cellcolor{lightgray} & \cellcolor{lightgray} & \cellcolor{PaleGreen1} case 1, 2, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14 successful \\
& \cellcolor{lightgray} & \cellcolor{lightgray} & \cellcolor{lightgray} & \cellcolor{PaleTurquoise1} case 3, 10 different approach \\ \midrule
MPA & \cellcolor{lightgray} & \cellcolor{lightgray} & \cellcolor{PaleGreen1} all successful & \cellcolor{LemonChiffon1} case 1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12 successful \\
& \cellcolor{lightgray} & \cellcolor{lightgray} & \cellcolor{PaleGreen1} & \cellcolor{LemonChiffon1} case 8, 13, 14 undecidable \\ \midrule
X!TandemPipeline & \cellcolor{PaleGreen1} case 1, 2, 3, 4, 5, 6, 8, 10, 11, 14 successful & \cellcolor{PaleGreen1} case 1, 2, 3, 4, 5, 6, 8, 10, 11, 14 successful & \cellcolor{lightgray} & \cellcolor{lightgray} \\
& \cellcolor{LemonChiffon1} case 7, 9, 12 undecidable & \cellcolor{LemonChiffon1} case 7, 9, 12 undecidable & \cellcolor{lightgray} & \cellcolor{lightgray} \\
& \cellcolor{LightSalmon1} case 13 incorrect & \cellcolor{LightSalmon1} case 13 incorrect & \cellcolor{lightgray} & \cellcolor{lightgray} \\ \midrule
Pout2Prot & \cellcolor{PaleGreen1} all successful & \cellcolor{PaleGreen1} all successful & \cellcolor{PaleGreen1} all successful & \cellcolor{PaleGreen1} all successful \\
\bottomrule
\end{tabular}
\caption{Comparison of the outcome of test cases for five protein grouping tools. The 14 test cases were run with the PIA, Fido (Percolator), MetaProteomeAnalyzer (MPA), X!TandemPipeline, and Pout2Prot. Test cases producing the expected outcome are marked as “successful” (green). Otherwise, these are either categorized as “undecidable” (yellow) if a random choice was made in case of undecidability, “incorrect” (red) if the result cannot be explained logically, and as “different approach” for PIA and Fido, because the anti-Occam protein subgrouping approach used here follows different rules (blue). If a tool does not implement a certain grouping method it is marked as “not implemented” (grey). \label{tab:pout2prot_tool_comparison}}
\end{table*}

While we tried to make a fair comparison, it should be noted that PIA also offers and even recommends another option that falls in between Occam’s razor and anti-Occam’s razor.
This method called SpectrumExtractor uses spectrum level information to determine which proteins should be removed or grouped together.
Furthermore, Fido offers an option similar to Occam’s razor that operates at the level of the protein database.
Percolator and other tools (e.g., Triqler [@theIntegratedIdentificationQuantification2019]) assign probabilities to proteins instead of making a binary choice for each protein.
In contrast, Pout2Prot is based on the binary model in which a peptide or protein is either identified or not.
This choice is influenced by the fact that a probabilistic approach makes the assignment of taxonomies and functions in metaproteomics very difficult.

##### Performance evaluation
To evaluate the performance of Pout2Prot, we tested it on a metaproteomics data set, derived from the six selected SIHUMIx [@schapeSimplifiedHumanIntestinal2019] data sets used in the Critical Assessment of Metaproteome Investigation (CAMPI) study [@vandenbosscheCriticalAssessmentMetaProteome2021].
Here, we used the X!Tandem [@craigTANDEMMatchingProteins2004] files available on PRIDE [@perez-riverolPRIDEDatabaseRelated2019] (PXD023217) to (i) convert these files to Percolator Input (.pin) files with tandem2pin, (ii) process the .pin files with Percolator resulting in Percolator Output (.pout) files, and (iii) convert these .pout files to protein (sub)grouping files with Pout2Prot, once using Occam’s razor, once using anti-Occam’s razor.

Interestingly, the identification rate (the number of identified spectra divided by the total number of spectra measured) at 1% False Discovery Rate (FDR) increases on average by 7% when using Percolator (\autoref{fig:pout2prot_identification_rates}a, blue bars (X!Tandem) vs red bars (Percolator)).
It is important to notice that Pout2Prot takes into account the PSM FDR, not the protein FDR. As expected and described before, the semisupervised machine learning algorithm Percolator is able to increase the number of PSMs due to the better separation of true and false matches [@kallSemisupervisedLearningPeptide2007; @bouwmeesterAgeDataDrivenProteomics2020].
More interestingly, we examined the effect of Percolator on the number of protein groups and subgroups.
To establish the number of protein (sub)groups before Percolator analysis, we reanalyzed the publicly available raw files of the selected data sets with MPA, also using X!Tandem with identical search settings.
Note here that MPA is only able to group proteins according to the anti-Occam’s strategy, so only those numbers were compared in the section below.

![(A) Identification rates per sample for X!Tandem and Percolator analyses. Here, the identification rate was defined as the number of identified spectra divided by the total number of spectra measured. (B) Number of protein (sub)groups compared between X!Tandem and Percolator for the anti-Occam’s razor strategy, and number of protein (sub)groups using Percolator for the Occam’s razor strategy. S03, S05, S07, S08, S11_F1–4, and S14_Rep1 refer to the six SIHUMIx samples.\label{fig:pout2prot_identification_rates}](resources/figures/chapter7_pout2prot_identification_rates.jpeg)

In \autoref{fig:pout2prot_identification_rates}b, we observe that after Percolator analysis, the number of protein groups per sample increased by 18.5% on average (blue vs red bars) and the number of protein subgroups per sample increased by 25.3% on average (yellow vs green bars).
The total number of groups and subgroups across all samples increased more drastically (by 34.7% and 39.9%, respectively) in comparison to the averages per sample.
All raw data is available in Supporting Information (Tables S1 and S2).

Furthermore, we also investigated the effect on the number of protein (sub)groups of combining different fractions at different places in the workflow.
We combined (i) the Mascot Generic Format (.mgf) files before the X!Tandem search, (ii) before the Percolator search, and (iii) before Pout2Prot protein inference.
Since the range for the number of protein (sub)groups constitute a 2–3% difference, the point in the workflow where the different files are combined, is of minimal impact (Supporting Information, Table S3).
For completeness, an example result file for taxonomic and functional analysis after processing of Pout2Prot output in Prophane can be found in Supporting Information, Figures S17 and S18).
In addition, the time for a Pout2Prot analysis (Occam’s razor) for the complete SIHUMIx experiment via the web service was less than 5s.

#### Conclusion
Pout2Prot enables the conversion of Percolator output (.pout) files to protein group and protein subgroup files, based on either the Occam’s razor or anti-Occam’s razor strategy, and therefore closes an important gap in the bioinformatic workflow of metaproteomics data analysis.
Moreover, Pout2Prot also allows the user to create protein (sub)groups across experiments.
The output of Pout2Prot can be imported directly into Prophane, which in turn allows users to perform downstream taxonomic and functional analysis of metaproteomics samples.

#### Acknowledgements
This work has benefited from collaborations facilitated by the Metaproteomics Initiative ([https://metaproteomics.org/](https://metaproteomics.org/)) whose goals are to promote, improve, and standardize metaproteomics [@vandenbosscheMetaproteomicsInitiativeCoordinated2021].
TVDB, PV, LM, and BM would like to acknowledge the Research Foundation - Flanders (FWO) \[grants 1S90918N, 1164420N, G042518N, and 12I5220N\].
LM also acknowledges support from the European Union’s Horizon 2020 Programme under Grant Agreement 823839 \[H2020-INFRAIA-2018-1\].
KS and DB would like to acknowledge the German Federal Ministry of Education and Research (BMBF) of the project “MetaProteomanalyzer Service” within the German Network for Bioinformatics Infrastructure (de.NBI) \[031L103\].
The authors declare no conflict of interest.

\newpage

### Highlighting taxonomic diversity of metaproteomic samples in metabolic pathways

\newpage

### Efficiently exploiting parallelism in modern web applications

#### Introduction
JavaScript is one of the most popular programming languages at this point in time.
According to a report of GitHub, it was the number one most used programming language in 2022 ^[See https://octoverse.github.com/2022/top-programming-languages].
In recent years, web applications have become a viable alternative for desktop applications and are increasingly favored by software developers.
Because of the increased functionality that is provided by these web applications, they have also grown in complexity and started to adopt some of the programming paradigms that are traditionally used by desktop applications.

In order to efficiently process large amounts of data, software developers try to split up hard tasks into smaller tasks that can be processed in parallel by the different cores in modern-day CPUs.
Since web applications are almost exclusively relying on JavaScript, this programming language of the web has adopted support for multithreading by implementing the "Web Workers" construct.

A "Web Worker" is a JavaScript script that is executed by the browser using a background thread.
Web applications can provide them with a collection of input data, instruct it to process the data and receive the results when done, all without occupying the browser's "main thread".

In order to understand what the "main thread" is in JavaScript, you need to realise that JavaScript is an event-driven programming language.
Every single operation that is performed by a piece of JavaScript code will be send to a queue that is systematically queried and emptied by the "Event loop".
The main JavaScript thread is constantly checking this event queue for new tasks that need to be taken care of and executes them one-by-one in a specific order.
Because only one thread is available to process the tasks pushed onto this queue, a long-running task blocks the execution of other tasks and can cause the web browser to "hang" on a specific operation.
It will only continue to process interactions of the user with a web app's user interface once this long-running task is completed (which is not user-friendly).

In the past, this was never really an issue since JavaScript was typically only used for providing some simple interactivity to a web page, but since the advent of complex web apps, this is becoming a major hurdle.
The amount of data that needs to be handled by modern-day web applications has seen a tremendous growth and can no longer be efficiently processed with a single thread.

#### Web Workers to the rescue
An initial proposal to add a "Web Workers" construct to the JavaScript programming language was first suggested in the ECMAScript 5 standard and has been formally adopted by all major browsers at this point.
A Web Worker can be defined as a task that receives some data as input, processes in the background and notifies the main thread when it is done.
These workers are typically managed by a separate browser process and can thus be executed in parallel to the tasks of the main JavaScript process.

Since each web worker runs in a separate process, they don't share the same memory space.
A reference to an object or piece of data that lives in one thread cannot be simply transferred to a web worker.
Instead, every object that needs to be sent between a web worker and the main JavaScript thread needs to be serialized on the sender's side and reconstructed on the receiver's side.

The "structured clone algorithm" is a mechanism in JavaScript that allows for the deep copying of complex objects in order to transmit or store them in a serialized format (see \autoref{fig:hashmap_serialization}).
If an object is transferred between contexts in JavaScript, this algorithm will be used.
This works very well for simple and small objects, but becomes slow very soon when large chunks of data need to be transferred and partially negates some important benefits of using Web Workers.

To make matters even worse, either one of the serialization or deserialization of an object is always performed by the main JavaScript thread, causing the application to hang again (which is one of the problems we are trying to overcome).

![If a normal JavaScript Object is being sent from one worker (or the main thread) to another, it first needs to be serialized on the sending side using the "structured clone algorithm". On the receiving end, it will then be completely deserialized again. \label{fig:hashmap_serialization}](resources/figures/chapter7_hashmap_serialize.eps)

##### Near zero-cost copy of ArrayBuffers
Since a few years, JavaScript exposes a new type of object called an `ArrayBuffer`.
An `ArrayBuffer` is a built-in object that represents a fixed-length raw binary data buffer.
This means that it allows a software developer to store a sequence of bytes that can be accessed and manipulated in a low-level way.
Such an `ArrayBuffer` is similar to a normal JavaScript array in that it is a collection of values, but the values in this `ArrayBuffer` are binary data instead of rich values such as numbers or strings.

Since the `ArrayBuffer` is just a series of binary values, it can also be thought of as a block of memory.
Because of its very simple structure, an `ArrayBuffer` does not need to be copied between different Web Workers, but instead only "ownership" of this memory block needs to be transferred (see \autoref{fig:hashmap_arraybuffer_transfer}).
The thread or Web Worker that currently has the "ownership" of an ArrayBuffer is the only one that is allowed to make changes (or read from) the block of memory at that point.
Transferring ownership is almost instantly.

![When sending an ArrayBuffer from one worker to another, it's ownership will be transferred. This means that no data needs to be copied which makes this operation a lot faster than for normal JavaScript Objects since the "structured clone algorithm" is not involved. \label{fig:hashmap_arraybuffer_transfer}](resources/figures/chapter7_hashmap_transfer_ownership.eps)

##### Sharing data between Web Workers
Next to `ArrayBuffers`, modern JavaScript specifications also describe a new concept called a `SharedArrayBuffer`.
Contrary to `ArrayBuffers`, `SharedArrayBuffers` no longer need to be "transferred" between Web Workers.
Instead, a `SharedArrayBuffer` object provides a "view" on a contiguous block of memory and can be "transmitted" to other workers in which case a new `SharedArrayBuffer` object will be created on the receiving side which is simply a view onto the same block of memory (see \autoref{fig:hashmap_shared_memory}).
The shared data block referenced by the two `SharedArrayBuffer` objects is the same block of data, and a side change made to this block of memory in one worker, will also become visible to the other worker.

If we compare `ArrayBuffers` to `SharedArrayBuffers` when it comes to the transfer of information from one Web Worker to another, we can conclude that `SharedArrayBuffers` allow multiple Web Workers to read and write to the same block of memory at the same time.
This hidden feature of JavaScript is something that we decided to exploit in order to speed up the Unipept Web and Unipept Desktop applications.
How we were able to do so is explained in depth in the next section.

![SharedArrayBuffers point to a specific block of memory that can be modified and used by different workers at the same time. This allows applications to split intensive operations and let them be executed by different workers in parallel which can then all read and write from the same HashMap.  \label{fig:hashmap_shared_memory}](resources/figures/chapter7_hashmap_shared_memory.eps)

#### A shared-memory HashMap in JavaScript

##### General structure of the HashMap
At this point, it is clear that there are constructs that allow the communication of large data sets between different Web Workers.
For most structured data, however, it is not trivial to encode it as a stream of raw bits and bytes.
In order to accommodate for this issue, we decided to implement a `HashMap` that allows arbitrary data and objects to be encoded as a stream of bits in an `ArrayBuffer` or `SharedArrayBuffer` that can then easily be transferred between threads.

Our `HashMap` implements the interface that is provided by JavaScript and is thus fully compatible and interchangeable with pieces of code that use the default `Map` implementation of JavaScript.
It follows the idea of most `HashMaps` that are already implemented in other programming languages such as Java.
In short, there is one block of memory that can keep track of $n$ pointers (referred to as the "index table" from now on).
Since every element in a `HashMap` has both a key and a value, we hash the value of the key and use this hash to determine at what position in the "index block" a point to the corresponding value can be found.

For a `HashMap`, a hash function typically needs to generate hashes as fast as possible that are distributed evenly.
We chose the Fowler-Noll-Vo hash function [@fowlerFNVNonCryptographicHash], which can be computed really fast on modern CPUs and produces hashes that are evenly distributed.
Another advantage of this hashing algorithm is that there already exists a good implementation of it for JavaScript ^[See https://www.npmjs.com/package/fnv-plus].

Each generated hash is represented as a large number.
In order to map this number onto a specific position in the index table, we simply compute the remainder of the hash when divided by $n$ (the size of the index table).
So, in order to retrieve the value that's associated with a specific key, we first compute the hash of the key, then find out its remainder when divided by $n$ and look at the pointer in the index table at this position.
\autoref{fig:hashmap_lookup_example} shows a detailed example of how a lookup for the key "cat" is performed.
Note that it might happen that multiple keys are mapped onto the same position in the index table, which is why every value object always keeps track of the original key and a pointer to the next item that is mapped onto the same index.
When retrieving a value for a key, this linked list of value objects needs to be processed until the key is found, or until the list ends.
See this article on Wikipedia for more information on how a `HashMap` works internally: [https://en.wikipedia.org/wiki/Hash_table](https://en.wikipedia.org/wiki/Hash_table).

![Looking up a value in the HashMap consists of several steps. First the key is hashed, then the position of this hash in the index table is computed. At last, the pointer at this computed position in the index table can be used to retrieve the value associated with the key. \label{fig:hashmap_lookup_example}](resources/figures/chapter7_hashmap_hash_function.eps)

##### Internal memory lay-out
My `HashMap` implementation requires the reserve two blocks of memory:

* **index table:** This block of memory keeps track of all pointers to data objects that keep track of the key and value for a `HashMap` entry and also a pointer to the next data objects. Each of these data objects live in the second reserved block of memory (the "data block"). Some extra bytes are also reserved as part of this memory black at the beginning for internal housekeeping of the `HashMap`.
* **data block:** This block of memory keeps track of all data objects that actually store the values that the user put into the `HashMap`.

Each of the values that are provided by the user need to somehow be translated into bytes before we can store them in a raw block of memory.

For some of the most common data types in JavaScript (e.g. string, integer, etc), a default serialization implementation is provided.
This is not the way that most `HashMaps` are implemented in other programming languages.
Normally, the values themselves are not serialized and stored as part of the `HashMap`, but rather a pointer to each of the values is kept, decreasing the amount of memory required.
Because this is a high-level implementation of a `HashMap`, we don't have access to the raw object pointers that are used internally by the JavaScript engine and we have to reside to this workaround.

##### Serialization of complex objects
Since serialization of objects can be very slow in some cases, the `ShareableHashMap` allows the user to provide a custom serialization (and deserialization) function.
These allow for some really nice optimizations and can circumvent the need to convert objects to strings and bytes altogether, leading to a significant speed up.
By cleverly exploiting the structure of some objects, we can encode objects as streams of bytes and directly extract those bytes that are associated with a specific property of the object.

#### Case study: keeping track of peptides in Unipept
In order to demonstrate the power of this specific `HashMap` implementation in JavaScript, we will be looking at its specific use in the Unipept Web and Desktop application.
For each metaproteomic analysis, both Unipept applications need to keep track of the taxa and functions associated with each peptide that was provided by the user.
This information is queried from Unipept's API, but since this querying process takes a long amount of time, it is performed by a Web Worker in the background and once done, a big `Map` containing the peptide/results mapping is passed onto the main thread.

If we use JavaScript's default implementation of `Map` for this, it takes around ... s to transfer the `Map` between the Web Worker and the main thread.
During all of this time, the deserialization of all information is performed by the main thread and the application is thus unresponsive to all interactions of the user.

Every `(key, value)` pair in this mapping has a specific structure.
The keys will always be peptides (i.e. strings) and the values are JSON-objects that keep track of some annotations for this peptide.
Since most properties in this object have a fixed length, or the property value lengths are known beforehand, we can encode these objects as streams of bytes in an ArrayBuffer.
See \autoref{fig:hashmap_object_encoding} for an example of how the information that's tracked by Unipept can be respresented by a stream of bytes.
Using this information, it is no longer required to serialize this object to a string-based representation (such as JSON).

![Example of how a complex object (in the case of Unipept) can be encoded as a simple stream of bytes that direclty fits into an ArrayBuffer. We know that the lowest common ancestor is always an unsigned integer, so we can store it in the first 4 bytes of a block of memory. The lineage in this example is a numeric array that always contains 3 unsigned integers, thus the next three places in the ArrayBuffer are reserved for this array. By continuing this strategy, each of the properties can directly be encoded in the memory block and can be recovered very efficiently. \label{fig:hashmap_object_encoding}](resources/figures/chapter7_hashmap_object_encoding.eps)

#### Conclusion and remarks
Based on the results from the case study, it is fair to conclude that this `HashMap` is not suitable for all projects, but can be of very high value in a specific environment (as is the case with Unipept).
In order to counteract the effects of some serious vulnerabilities that were dedected in x86 CPUs (i.e. the Spectre [@Kocher2018spectre] and Meltdown [@Lipp2018meltdown] attacks), most major browsers have taken serious precautions to counteracts these attacks and blocked the use of `SharedArrayBuffers` in most cases.
Only websites that pack a specific set of HTTP headers into their HTTP responses ^[See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer#security_requirements ] are allowed to use SharedArrayBuffers.

This means that consumers of our `HashMap` implementation either need to resort to regular `ArrayBuffers` if they don't need multiple Web Workers to manipulate the `HashMap` simultaneously or that they need to properly configure their servers in order to take care of the required Cross-Origin Isolation headers.
