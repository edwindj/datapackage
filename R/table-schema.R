#' @export
table_schema <- function(fields, ...){
  if (missing(fields)){
    fields <- data.frame(name=character(), title=character(), type=character())
  }
  structure(list(fields=fields), class="table_schema")
}

#' Derive a schema from a table
#' 
#' Derive a schema from a table
#' @param tbl table, can be a \code{data.frame} or a \code{\link{tbl}} object.
#' @export
derive_schema <- function(tbl, ...){
  # TODO check if tbl is a data.frame or tbl object
  tbl <- dplyr::as.tbl(tbl)
  name <- dplyr::tbl_vars(tbl)
  x <- head(tbl, 1) # convert to data.frame with first row
  type <- sapply(x, function(v){
    switch(class(v),
           numeric   = "number",
           integer   = "integer",
           character = "string",
           factor    = "string",
           Date      = "date",
           POSIXct   = "datetime",
           "any"
    )
  })
  fields <- data.frame(name=name, title=name, type=type)
  table_schema(fields)
}

#' @importFrom jsonlite fromJSON
read_schema <- function(file, ...){
  obj <- jsonlite::fromJSON(file)
  #TODO check obj
  table_schema(obj)
}

#' Checks if data.frame x conforms to schema
# TODO allow for number/integer and date/datetime conflicts? : option
# Should order of the variables be identical? : yes
#' @export
check_schema <- function(tbl, schema, ...){
  name <- dplyr::tbl_vars(tbl)
  check_name <- name == schema$field$name
  if (!all(check_name)){
    stop("Name conflict: ", name, " and ", schema$field$name, "are not equal")
  }
  
  tbl_schema <- derive_schema(tbl)
  invisible(TRUE)
}

# data may have more columns, so reorder and make a selection that follows the 
# schema
#' @export
select_with_schema <- function(tbl, schema, ...){
  #TODO may generate error!
  vars <- schema$fields$name
  if (!all(vars %in% dplyr::tbl_vars(tbl))){
    #TODO improve error message
    stop("Data does not contain all variables: ", call. = FALSE)
  }
  #TODO check schema for type?
  dplyr::select_(tbl, .dots=vars)
}