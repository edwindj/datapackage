#' @export
table_schema <- function(x, ...){
}

derive_schema <- function(tbl, ...){
}

#' @importFrom jsonlite fromJSON
read_schema <- function(json){
  obj <- jsonlite::fromJSON(schema)
  #TODO check obj
  table_schema(obj)
}