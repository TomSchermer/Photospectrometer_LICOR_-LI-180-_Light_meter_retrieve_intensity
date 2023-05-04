## Welcome to the hopefully faster method of retrieving the .csv data from the Licometer, for the purposes of getting
## the intensity data back.

library(data.table); library(tidyverse); library(readxl); library(writexl);

## First, set the working directory to the one you wish to extract all the intensities for. You do this by modifying 
## the string in the function "setwd()". Then, execute all the code by pressing ctrl+shift+enter.
## In case you already ran the code, it will have made an OUTPUT.xlsx , which no longer let's you execute the code

setwd("C:/Users/tom04/surfdrive/Experimental_data/Light_quality_experiments/Light meter/Light_intensity_uMOL files/WHITE/255_1_NEW_aim5/uMOLs")
getwd()

## The actual function for retrieving the intensity for an observation.


retrieve_intensity <- function(filename_input){
  

dat <- read.csv(filename_input)

light_values <- c()

for (i in 1:401){
  character_number <- (dat[i, ])
  real_number <- as.numeric(substr(character_number, 5, 13))
  light_values <- c(light_values, real_number)
}

intensity <- sum(light_values)

return(intensity)

}

## Lists of all the files in the directory. And applies the function to all the path names to get the intensity

file_path_names <- c()
for (a in 1:length(list.files())){
  file_list <- list.files()
  file_path_names <- c(file_path_names, paste(getwd(),"/", file_list[a], sep = ""))
}

# The writing of the OUTPUT file will only occur when it's not been run before. 
# The files in the list should all be uMOL .csv files directly from the lightmeter.


intensity_list <- c()
for (u in 1:length(list.files())){
  intensity_list <- c(intensity_list, (retrieve_intensity(file_path_names[u])))
}

dat_file <- data.frame(file_path_names, intensity_list)
dat_file
write_xlsx(dat_file, "OUTPUT.xlsx")
??write.xlsx
