here()
here("data")

# find raw data files, these should include 2022 or 2023
csv_files <- dir_ls(here("data"), regexp ="2022.*.csv$|2023.*.csv$")
csv_files
length(csv_files) # should be length of 12

# read .csv files into a list
files_list <- map(csv_files, read_csv)
names(files_list)


# bind rows into a single data frame
combined_data_raw <- bind_rows(files_list, .id = NULL)

# glimpse(combined_data_raw)  # 5.65M rows, 13 cols

object.size(combined_data_raw) %>% print(units = "Mb", standard = "legacy") # 992.4 Mb


# remove the list as it is about 1 GB
rm(files_list)


# write combined_data_raw to a .csv if the file does not already exist
# csv file takes some time to write
tic()
if(!file_exists("data/combined_data_raw.csv")) {
	write_csv(combined_data_raw, here("data", "combined_data_raw.csv"))
}
toc()
