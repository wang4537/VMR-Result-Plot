######### functions ########
#construct a function to convert the output.sub to group.ave
group_ave <- function(group_sub)
{
  #aggregate the means for each position in a treatment for given start point
  group_ave <- aggregate(.~genotype+an+start+end, group_sub, mean)
  #fill the mean column with the sum of inadist, smldist and lardist
  group_ave$mean <- rowSums(group_ave[,c(7, 10, 13)])
  #fill the lo, up and sec column
  group_ave$lo <- rep(0, nrow(group_ave))
  group_ave$up <- rep(0, nrow(group_ave))
  group_ave$sec <- seq(1,nrow(group_ave))
  #change the genotype column type to character
  group_ave$genotype <- group_ave$genotype

  return(group_ave)
}

#construct a function to generate plot for each treatment group
generate_plot <- function(group_ave)
{
  pdf(file= paste(unique(group_ave$genotype), ".pdf", sep = ""))
  response <- ggplot(data=group_ave, aes(x=sec, y=mean, ymin=lo, ymax=up)) +
    labs(y = "Average Displacement (cm)", x = "time (s)") +
    geom_line(aes(color = genotype), size = 0.6, alpha = 1) +
    geom_ribbon(aes(fill = genotype), alpha = 0.2) +
    scale_colour_manual(values = "#0a6284",
                        labels = unique(group_ave$genotype)) +
    scale_fill_manual(values = "#0a6284",
                      labels = unique(group_ave$genotype)) +
    scale_x_continuous(breaks=c(0,(1:6)*30), labels=c(0,(1:6)*30)-60) +
    coord_cartesian(xlim = c(10,170), ylim = c(-0.00,0.4)) +
    theme_bw(base_size = 32) +
    theme(panel.grid.minor.x = element_blank(),panel.grid.minor.y = element_blank(),panel.grid.major = element_line(colour = "#bababa",size = 0.1),
          axis.text.x = element_text(color="#000000"), axis.text.y = element_text(color="#000000"),
          legend.position = "top",legend.title=element_blank(), legend.spacing = unit(1,"cm"),
          axis.title.x = element_text(size =20), axis.title.y = element_text(size =20, vjust = 0.3),
          plot.margin = unit(c(0, 1, 0.5, 0.5), "cm"))
  print(response)
  dev.off()
}

######### main ########
#import libraries
library(ggplot2)
library(grid)
library(plyr)

######### retrieve export_subtotal file ########
#read the path from the windows prompt argument
#args <- commandArgs(trailingOnly = TRUE)
#print(args)
#path <- args[1]

#read the output .xls file from the VMR run

#set the working directory where the result file is located
# for example Z:\Lab data\name\date genotype VMR\color Plate
path <- "C:/Purdue_related/research/data_analysis/result/20210126 WT Q344X"
setwd(path)
#read the result file within the directory
result_file_names <- list.files(path = path, pattern = "\\Result.XLS$", ignore.case = TRUE)
output <- read.csv(result_file_names, header = TRUE, sep = "\t")
rm(path)
#list all colunms saving for later use
out.columns <- colnames(output)[c(4,5,7,8,12:20)]
#subset the output dataframe by the columns
output.sub <- output[out.columns]
rm(output)
rm(out.columns)
#subset the dataframe for start time between 5340 and 5520, and an == 0
output.sub <- output.sub[output.sub$start >= 5340 & output.sub$start <= 5520 & output.sub$an == 0,]
######### retrieve export_subtotal file ########
#retreive the group/treatment names in the subset
group.name <- unique(output.sub$genotype)
#assign genotype names as the dataframe name, i.e. parse the genotype dataframes
treatment_list <- list()
for(i in 1:length(group.name))
{
  treatment_list[[i]] <- output.sub[output.sub$genotype == group.name[i],]
  names(treatment_list)[i] <- as.character(group.name[i])
}
rm(i)
rm(group.name)
######### retrieve export_subtotal file ########
#apply the group_ave function to all treatment in the list
treatment_ave <- lapply(treatment_list, group_ave)
#plot the result
lapply(treatment_ave, generate_plot)
