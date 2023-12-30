# helper functions



# helper function to detect and count whitespace errors
# function detects and sums if:  
  # 2 or more concurrent spaces
  # leading space or trailing space
find_whitespace <- function(x) { 
  y <- unique(x)
  sum(str_detect(y, "[:space:]{2,}|^[:space:]|[:space:]$"), na.rm = TRUE)
}



# function to summarize number and percentage of na values for
# each variable in a dataframe 
na_summary <- function(df) {
  na_table <- df %>%  map_df(function(x) sum(is.na(x))) %>% 
    pivot_longer(cols = everything()) %>% 
    set_names("variable", "na_count") %>% 
    mutate(na_pct = 100 * na_count / nrow(df))
  na_table
}


# count length of intersect between NA values for 2 variables
count_mutual_na <- function(df, var1, var2) {
  df %>% filter(is.na( {{var1 }} ), is.na( {{var2}} )) %>% 
    nrow()
}

count_exclusive_na <- function(df, var1, var2) {
  df %>% filter(is.na( {{var1 }} ), !is.na( {{var2}} )) %>% 
    nrow()
}


count_union_na <- function(df, var1, var2) {
  df %>% filter(is.na( {{var1 }} ) | is.na( {{var2}} )) %>% 
    nrow()
}




x <- tibble(a = c(NA, 1 , 2),  b = c(NA, 1, 2), c = c(1, 2, NA) )
count_mutual_na(x, a, c)


# var1 is grouping variable; var2 is variable to look for NA's in
summarize_na_by_var <- function(df, var1, var2) {
  summary <- df %>% group_by({{var1}}) %>% 
    summarize(
      n = n(), 
      na_count = sum(is.na({{var2}})),
      na_pct = 100 * na_count / n
      )
  summary
}



