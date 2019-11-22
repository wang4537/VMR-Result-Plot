# VMR Result Plot Script and Tutorial
##### Author: BC Wang
##### 11/22/2019

## Overview
This tutorial aims to free your hands in VMR result analysis to generate the displacement curve of the samples.

There are two ways to make it work:
1. run the R script via R or R studio: all you need to do is to modify the path to the result ".xls" file.
2. run the script via Windows command prompt: this requires you to setup the Windows command prompt for the first run but you do not need to worry about the script itself.

Overall, here are the components involved in the workflow:
  - **Input** "result.xls", the result file from the VMR run.
  - **Script** "main.R", the main script for the analysis
  - **Output** "treatment_group.pdf", .pdf files of the displacement curve plots for treatment groups and the number of plots depends on the number of "genotypes" in the result file

To execute the post VMR analysis, all you need to do is to put the script and result file in the same folder, and run the command `Rscript main.R %cd%`. This is all you need every time you need to do the analysis.

By default, Windows command prompt does not recognize `Rscript` command and in the next section you will learn how to set up the system to run the command.

## Getting Started
### Prerequisites
Note: This only works in **Windows** system and you only need to setup the prerequisites once for the first time. If you want to run the script via R or R studio, you can skip this sections. If you are first to the programming, it is highly recommended that you follow the prerequisites.

The following R packages are required for the analysis and script:
   - Install required packages in R:
     ```
       install.packages(ggplot2)
       install.packages(grid)
       install.packages(plyr)
     ```
  - Windows environment path setup (for running in **Windows prompt**).

    In order to excute R script in command prompt in Windows, you have to add the path of **Rscript.exe** to the `PATH` variable in the system. To do this, follow these steps:
      1. Search "View Advanced System Setting" in the search bar
      2. Navigate to "Environmental Variable"
      3. Select "Path" row in the "System Variable"
      4. Click "Edit..." -> "New"
      5. Insert the directory path to R, usually it will be "C:\Program Files\R\R-3.6.1\bin\"
      6. Click "OK" and exit the panels

      Now your Windows command prompt will recognize the `Rscript` and `R` as executable command. Let's move on to the actual thing.

## How to Run
1. running from R or R studio
   All you need to do is to find `Line 26`: `path <- "Z:\Lab data\name\date genotype VMR\color Plate"` and input your directory path here. After that, run the script and the result plots will be generated in the same directory
2. To run the script in command prompt
- Put "main.R" file in the same folder where the VMR result file "xxxxxxxx color plate result.xls" file is located
- Open the Windows command prompt by type "command prompt" in the search bar
- use `cd` command to relocate the working directory to the folder of "main.R" and "xxxxxxxx color plate result.xls", for example:
```
      cd Z:\Lab data\name\date genotype VMR\color Plate
```
    The easiest way to do this is probably to copy the path from the address bar and paste it to command prompt
- execute the following command to run the analysis:
```
      Rscript main.R %cd%
```

If the command is successfully run, the following output will be displayed in the command prompt:
```
[1] "Z:\\Lab data\\rotations\\Leung\\pipeline_script"
$Q344X
null device
    1

$Arecoline
null device
    1

$`DisodiumChromoglycat `
null device
    1

$Q344XDMSO
null device
    1
```
