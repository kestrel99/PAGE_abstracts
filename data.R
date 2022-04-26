## data processing

library(httr)
library(rvest)
library(RSelenium)
library(tidyverse)

PAGE_name <- "PAGE2022"
data_loc  <- "abstracts.xls"

abstracts <- read_html(data_loc) %>%
  html_table(header = T) %>% .[[1]]



## play with data

abstracts <- abstracts[order(abstracts$lastname),]

abstracts$author <- stringi::stri_enc_toutf8(abstracts$author)
abstracts$title <- stringi::stri_enc_toutf8(abstracts$title)
abstracts$affiliation <- stringi::stri_enc_toutf8(abstracts$affiliation)
abstracts$firstname  <- stringi::stri_enc_toutf8(abstracts$firstname )
abstracts$lastname  <- stringi::stri_enc_toutf8(abstracts$lastname )
abstracts$fullname  <- stringi::stri_enc_toutf8(abstracts$fullname )

abstracts_lbs      <- abstracts[grepl("Lewis Sheiner Student Session", abstracts$type),]

lbs_id <- unique(abstracts_lbs$`_id`)

abstracts_oral     <- abstracts[grepl("Oral:", abstracts$type),]
abstracts_poster   <- abstracts[grepl("Poster:", abstracts$type),]
abstracts_software <- abstracts[grepl("Software Demonstration", abstracts$type),]

abstracts_oral_nolbs <- abstracts_oral[!(abstracts_oral$`_id` %in% lbs_id),]

readr::write_excel_csv(abstracts, "C:/Occams/Local/General/PAGE/2022/abstracts.csv")
readr::write_excel_csv(abstracts_lbs, "C:/Occams/Local/General/PAGE/2022/abstracts_lbs.csv")
readr::write_excel_csv(abstracts_oral, "C:/Occams/Local/General/PAGE/2022/abstracts_oral.csv")
readr::write_excel_csv(abstracts_oral_nolbs, "C:/Occams/Local/General/PAGE/2022/abstracts_oral_nolbs.csv")
readr::write_excel_csv(abstracts_poster, "C:/Occams/Local/General/PAGE/2022/abstracts_poster.csv")
readr::write_excel_csv(abstracts_software, "C:/Occams/Local/General/PAGE/2022/abstracts_software.csv")

try(xlsx::write.xlsx(abstracts, file="C:/Occams/Local/General/PAGE/2022/abstracts.xlsx",
                     sheetName="All Abstracts", append=F))
try(xlsx::write.xlsx(abstracts_lbs, file="C:/Occams/Local/General/PAGE/2022/abstracts.xlsx",
                     sheetName="LBS Abstracts", append=T))
try(xlsx::write.xlsx(abstracts_oral, file="C:/Occams/Local/General/PAGE/2022/abstracts.xlsx",
                     sheetName="Oral Abstracts", append=T))
try(xlsx::write.xlsx(abstracts_oral_nolbs, file="C:/Occams/Local/General/PAGE/2022/abstracts.xlsx",
                     sheetName="Non-LBS Oral Abstracts", append=T))
try(xlsx::write.xlsx(abstracts_poster, file="C:/Occams/Local/General/PAGE/2022/abstracts.xlsx",
                     sheetName="Poster Abstracts", append=T))
try(xlsx::write.xlsx(abstracts_software, file="C:/Occams/Local/General/PAGE/2022/abstracts.xlsx",
                     sheetName="Software Demonstrations", append=T))

