# Project
## Overview
This repo contains the data and code used for the study presented in the following paper:

[*The 4.2 ka event and the end of the Maltese ‘Temple Period’*]()

A DOI for the paper will be added to this document after acceptance to a peer-reviewed journal. A Zenodo DOI for an archived version of this repo will also be added after the associated paper has been accepted.

## Abstract
The small size and relatively challenging environmental conditions of the semi-isolated Maltese archipelago mean that the area offers an important case study of societal change and human-environment interactions. Following an initial phase of Neolithic settlement, the ‘Temple Period’ in Malta began ~5.8 thousand years ago (ka), and came to a seemingly abrupt end ~4.3 ka, and was followed by Bronze Age societies with radically different material culture. Various ideas concerning the reasons for the end of the Temple Period have been expressed. These range from climate change, to invasion, to social conflict resulting from the development of a powerful ‘priesthood’. Here, we explore the idea that the end of the Temple Period relates to the 4.2 ka event – often cited as an example of an abrupt climate change event. The 4.2 ka event has been linked with several examples of significant societal change around the Mediterranean, such as the end of the Old Kingdom in Egypt, yet its character and relevance have been debated. We explore archaeological and environmental data from the Maltese islands to elucidate the end of the Temple Period. The Maltese example offers a fascinating case study for understanding issues such as chronological uncertainty, disentangling cause and effect when several different processes are involved, and the role of abrupt environmental change in impacting human societies. Ultimately, it is suggested that the 4.2 ka event may have played a role in the end of the Temple Period, but that other factors seemingly played a large, and possibly predominant, role. As well as our chronological modelling indicating the decline of Temple Period society in the centuries before the 4.2 ka event, we highlight the possible significance of other factors such as a plague epidemic.

## Software
The R scripts contained in this repository are intended for replication efforts and to improve the transparency of research. They are, of course, provided without warranty or technical support. That said, questions about the code can be directed to me, Chris Carleton, at ccarleton@protonmail.com.

### R
This analysis described in the associated manuscript was performed in R. Thus, you may need to download the latest version of [R](https://www.r-project.org/) in order to make use of the scripts described below.

### chronup
Some of the analyses described in this paper make use of a custom R package called 'chronup' (https://github.com/wccarleton/chronup). The package is under development and currently in a pre-release state. But, it can be installed using R::devtools::install_github or downloaded from the linked GitHub repo and installed/used manually.

## Replication
To replicate the analyses described in the associated paper, follow these steps:

1. Use 'oxcal_commands_RL4_Sisal.oxcal' to produce an OxCal deposition model. Save the resulting age-depth model samples file and edit line 66 of 'data_prep.R' as needed.

2. Run data_prep.R

3. Run rec_model.R

The 'data_prep.R' script creates several large bigmemory files. The ones we produced for the study can be obtained from Zenodo servers with the following DOI:

10.5281/zenodo.5354992

## Contact

[ORCID](https://orcid.org/0000-0001-7463-8638) |
[Google Scholar](https://scholar.google.com/citations?hl=en&user=0ZG-6CsAAAAJ) |
[Website](https://wccarleton.me)

## License

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
