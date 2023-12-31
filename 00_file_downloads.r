# load libraries
source("00_libraries.r")


# "https://divvy-tripdata.s3.amazonaws.com/index.html" - this is page containing .zip folders
# want data from Nov 2022 - October 2023


url_root <- "https://divvy-tripdata.s3.amazonaws.com/"

#for loop to create URLs and download files
# generate strings
# For months 11 and 12 want 2022; for months 1-10 want 2023

z <- vector()
for (i in 1:12) {
  if (i <=10 ) {
    z[i] <- paste0("2023", str_pad(i, width = 2, pad = "0"))
  }
  else z[i] <- paste0("2022", str_pad(i, width = 2, pad = "0"))                             
}
z



# download the .zip files
for(i in z) {
  url <- paste0(url_root, i, "-divvy-tripdata.zip")
  destfile <- here("data", paste0("trips_", str_sub(i, 1, 4), "_", str_sub(i, 5,6), ".zip"))
  download.file(url, destfile)
}



# code to programmatically unzip files
# list files in the data dir, but only .zip files
zip_files <- dir_ls(here("data"))  %>% keep(function(x) str_detect(x, ".zip$"))
zip_files

# iterate unzip over files 
for(i in zip_files) {  
  unzip(i, exdir = here("data"))
}


# now that .csv files are extracted, need to rename
csv_files <- dir_ls(here("data"))  %>% keep(function(x) str_detect(x, "divvy.*.csv"))
csv_files
length(csv_files)

# create strings for new names
months <- str_extract(csv_files, "202.*[0-9]")
months
new_names <- paste0(str_sub(months, 1, 4), "_", str_sub(months, 5, 6), ".csv")
new_names


# rename files
file_move(csv_files, here("data", new_names))


# remove older files
rm_files <- dir_ls(here("data")) %>% keep(function(x) str_detect(x, "divvy"))
rm_files
file_delete(rm_files)

# remove the "MACOSC" subdir
rm_dir <- dir_ls(here("data")) %>% keep(function(x) str_detect(x, "MAC"))
rm_dir
dir_delete(rm_dir)


# inspect objects still in the environment
ls()

# clean up objects
ls()
rm(list = ls())
ls()