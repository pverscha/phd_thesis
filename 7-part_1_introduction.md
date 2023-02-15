\renewcommand{\chaptermark}[1]{\markboth{\textsf{Part \thepart.~ \parttitle}}{}}
\renewcommand{\sectionmark}[1]{\markright{\textsf{Part \thepart.~ Introduction}}}

# Unipept Desktop

On February 3, 2011, the first version of the Unipept web application was released.
This date marked the start of Unipept as a tool that could be used by outside researchers.
The web application has undergone an enormous evolution since then and has been expanded with numerous new tools and features in order to aid researchers in analysing metaproteomics data.
Over the years, the Unipept ecosystem has further been expanded with an API that allows our analysis pipelines to be integrated with third-party tools, a command line interface (CLI) that can be used to automate the analysis of large datasets and a desktop application.
Lately, the size and complexity of metaproteomics datasets have both increased, making it harder for a web application to process and produce the expected results.
Since web applications are managed by a web browser, access to compute resources and storage space on the user's local machine is limited (to ensure stability and security of the web apps managed by the browser).

In order to power the next generation of metaproteomics data analysis, I started working on the Unipept Desktop application.
This application is developed using the Electron framework ^[https://www.electronjs.org/] which allows us to use web technologies (such as JavaScript, HTML, CSS, etc.) to build desktop applications.
Since we already have a functioning web application, we want to reuse as much of the work we have put into this for this new desktop application (which is why Electron is the perfect choice).
Most of the rationale and reasoning behind this is explained in \autoref{chapter:unipept_desktop_v1}.

Once the desktop application reached feature parity with the web application, I started on expanding it with new features that could not be realised with our web application.
The most important of these features is the ability to build targeted protein reference databases, which can increase the taxonomic and functional resolution of a metaproteomics or proteogenomics data analysis.
Proteogenomics is a novel research discipline that utilizes the findings of a metaproteomics data analysis to guide a subsequent metaproteomics analysis.
Unipept Desktop 2.0 was released on February 10, 2023, and is the first release of our desktop application that supports all of these new features.
Proteogenomics, and how the construction of targeted protein reference databases was realised, is discussed in \autoref{chapter:unipept_desktop_v2}.
