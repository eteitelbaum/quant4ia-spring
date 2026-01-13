library(lubridate)

mon <- as_date("2026-01-12")
tues <- mon + days(1)
wed <- mon + days(2)
thurs <- mon + days(3)
fri <- mon + days(4)
sat <- mon + days(5)
sun <- mon + days(6)

advdate <- function(day, week) {
  date <- (day + weeks(week))
  dm <- paste(month(date, label = TRUE), day(date))
  return(dm)  
}

advdate2 <- function(day, week) {
  date <- (day + weeks(week))
  day_name <- wday(date, label = TRUE, abbr = FALSE)
  month <- month(date, label = TRUE, abbr = FALSE)
  dm <- paste0(day_name,", ", month, " ", day(date))
  return(dm)  
}