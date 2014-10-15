# implementation of data difference
daff <- function(a, b, ...){
  diff <- list()
  structure(diff, class="daff")
}

data_diff <- daff

#'assume row names and ids.
make_diff <- function(tbl_local, tbl_remote, ids, ...){
  # get columns structure diff
  
  # get row differences, if both have row.names use that otherwise use row_number
  
  # check if ids are distinct?
  # join tbl_local and tbl_remote on ids
  # find the differences
}

apply_diff <- function(x, daff){
  # change columns
  # remove and add rows
  
}