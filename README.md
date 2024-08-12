# Does inflation make you spend less?

## Overview

This repository gathers data from Statistics Canada in relation to the average household spending, annual consumer price index, and the number of tax fillers with income. 

To download the data from the Statistics Canada website, use the `cansim` package and run the "01-download.data.R" file.

## File Structure

The repository is structured as:

-   `data/raw_data` contains the raw data as obtained from Statistics Canada.
-   `data/analysis_data` contains the cleaned datasets that was constructed. Explanations are provided in the "02-data_cleaning.R" file.
-   `model` contains fitted models.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean, test, model and graph the data.


## Statement on LLM usage

ChatGPT 4 was used to make the abstract short and concise. The entire chat history is available in other/llms/usage.txt.

