table <- list()

server <- function(){
  
  while(TRUE){
    writeLines("Listening...")
    con <- socketConnection(host="localhost", port = 6011, blocking=TRUE,
                            server=TRUE, open="r+")
    data <- unserialize(con)
    
    if (!is.list(data)){
      obj <- table[[data]]
      if (is.null(obj)) {
        response <- NULL
      } else {
        response <- obj
      }
        
    } else {
      table[[data[['hash']]]] <- data[['val']]
      response <- "object added"
    }
    serialize(response, con)
    close(con)
  }
}
server()
