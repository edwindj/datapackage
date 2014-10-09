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
           Date      = "datetime",
           "Any"
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