## Render all documents

## Orals

#rmarkdown::render("PAGE2022_Oral_All.Rmd")  # All orals 
#rmarkdown::render("PAGE2022_Oral_General.Rmd")  # All non-LBS orals 
#rmarkdown::render("PAGE2022_Oral_LBS.Rmd")  # Anonymized LBS orals 

source("data.R")

sel <- read_csv("abstracts selected.csv")
sel <- subset(sel, selected_nextround=="selected")

abstracts_selected <- abstracts_oral[abstracts_oral$`_id` %in% sel$`_id`,]

abstracts_selected <- abstracts_selected[order(abstracts_selected$type,abstracts_selected$lastname),]

lines <- readLines('PAGE_Orals.template')

for (a in sort(unique(abstracts_oral$type))) {
  aa <- stringr::str_replace_all(a, "\u0096", "-")
  out <- str_replace_all(lines, "zzzsectionzzz", aa)
  writeLines(out, paste("PAGE2022_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
  rmarkdown::render(paste("PAGE2022_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
}


## Posters

lines <- readLines('PAGE_Posters.template')

abstracts_poster <- rbind(abstracts_poster, abstracts_software)
abstracts_poster$type <- gsub("\u0096", "-", abstracts_poster$type)
abstracts_poster$title <- gsub("\u0096", "-", abstracts_poster$title)

for (a in sort(unique(abstracts_poster$type))) {
  aa <- stringr::str_replace_all(a, "\u0096", "-")
  out <- str_replace_all(lines, "zzzsectionzzz", aa)
  writeLines(out, paste("PAGE2022_Posters_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
  rmarkdown::render(paste("PAGE2022_Posters_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
}

