## Render all documents

## Orals

#rmarkdown::render("PAGE2022_Oral_All.Rmd")  # All orals 
#rmarkdown::render("PAGE2022_Oral_General.Rmd")  # All non-LBS orals 
#rmarkdown::render("PAGE2022_Oral_LBS.Rmd")  # Anonymized LBS orals 

source("data.R")

## Orals 

lines <- readLines('PAGE2022_Orals.template')

for (a in sort(unique(abstracts_oral$type))) {
  aa <- stringr::str_replace_all(a, "\u0096", "-")
  out <- str_replace_all(lines, "zzzsectionzzz", aa)
  writeLines(out, paste("PAGE2022_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
  rmarkdown::render(paste("PAGE2022_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
}


## Posters

lines <- readLines('PAGE2022_Posters.template')

abstracts_poster <- rbind(abstracts_poster, abstracts_software)
abstracts_poster$type <- gsub("\u0096", "-", abstracts_poster$type)
abstracts_poster$title <- gsub("\u0096", "-", abstracts_poster$title)

for (a in sort(unique(abstracts_poster$type))) {
  aa <- stringr::str_replace_all(a, "\u0096", "-")
  out <- str_replace_all(lines, "zzzsectionzzz", aa)
  writeLines(out, paste("PAGE2022_Posters_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
  rmarkdown::render(paste("PAGE2022_Posters_", gsub("[: /&]", replacement = "_", x = aa), ".Rmd", sep=""))
}

