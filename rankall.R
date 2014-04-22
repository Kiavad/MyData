rankall <- function(outcome, num = "best") {
        ## Check that  outcome is valid 
        poutcome <-  c("heart attack", "heart failure","pneumonia")   
        if (!(is.element(outcome,poutcome))) {stop("invalid outcome")}
        
        state <- sort(state.abb) 
        hospital <- as.character(0)

        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
     
                
        ## For each state, find the hospital of the given rank
        for (cstate in state) {
                        
                canidates <-data$Hospital.Name[cstate==data$State]
                                
                
                ## get the correct colunm
                posCol = c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" )
                cname <- posCol[match(outcome,poutcome)]
                possible_data <- subset(data,data$State == cstate)
                scores <- suppressWarnings(sapply(possible_data[cname],as.numeric))
                                
                
                df <- data.frame(canidates,scores)
                sorted.d <- df[order(scores,canidates,na.last = NA,decreasing = F),]
                              
                lnum <- num
                ## Return hospital name in that state with the given rank
                if (num == "best") {
                        lnum <- 1
                } else if (num == "worst") {
                        lnum <- nrow(sorted.d)
                } 
                
                hosp <- as.vector(sorted.d[lnum,1])      
                
                hospital[match(cstate,state)]<- hosp
                
                
                
                
        }
      
        
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        ans <- data.frame(hospital,state)   
        
       return(ans)  
        
        
}