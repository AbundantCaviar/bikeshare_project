


# Start section ----
# add in step other to deal w/ problem of rare names

make_recipe_2 <- function(train) {
recipe_2 <- recipe(member_casual ~ ride_id + rideable_type + hod + dow + month + start_name + end_name +
                     is_weekend + is_holiday + round_trip, data = train) %>%   
  update_role(ride_id, new_role = "id variable")   %>% 
  # lump together stations with <500 records
  step_other(start_name, end_name, threshold = 500)
 
}



make_recipe_1 <- function(train) {
  recipe_1 <- recipe(member_casual ~ ride_id + rideable_type + hod + dow + month + 
                       is_weekend + is_holiday + round_trip, data = train) %>%  #  
    update_role(ride_id, new_role = "id variable")   # %>% 
   # step_other(start_name, end_name, threshold = 0.05)
  
}


# end section ----



