## data processing

library(httr)
library(rvest)
library(RSelenium)
library(tidyverse)

PAGE_name <- "PAGE2022"
data_loc  <- "abstracts.xls"

abstracts <- read_html(data_loc) %>%
  html_table(header = T) %>% .[[1]]

## add Healy abstract by hand

# healy <- tibble(
#   `_id` = 99999,
#   author = "Paul Healy(1), Karel Allegeart(2) and Oscar Della Pasqua(1)",
#   title = "In silico evaluation of the effect of CYP2D6 and OCT1 genotype variants on the pharmacokinetics and clinical safety of tramadol in infants, children and adolescents.",
#   type = "Poster: Drug/Disease Modelling - Paediatrics",
#   content="<p><strong>Introduction: </strong></p>\r\n<p>In adults, tramadol is approved for use in moderate to severepain, usually in combination with non-opioid analgesics [1]. In paediatric patients, codeine and tramadol are commonly used off-label for this condition, even though in the EU it is approved in children above 3 years of age for moderate to severe nociceptive pain [2]. Nevertheless, the dose rationale for this group of patients has not been determined considering the contribution of genetic variation in drug disposition, which ultimately affect the overall exposure to tramadol. Using pharmacokinetic (PK) data from a clinical study in neonates we examine the metabolic effects of polymorphisms in hepatic cytochrome P450 2D6 (CYP2D6) enzyme and organic cation transporter 1 (OCT1) using a nonlinear mixed effects modelling approach.</p>
# <p><strong>Objectives: </strong></p>\r\n<p>Our investigation aimed to characterise the PK of tramadol and its metabolite, O-desmethyltramadol (M1) in paediatric patients and assess the effects of demographic, clinical and genetic factors on the disposition properties of both moieties. Focus was given to the impact of CYP2D6 and OCT1 polymorphisms on the exposure to tramadol and implications for dose recommendations for the treatment of paediatric patients from 3 months to 18 years old in acute and chronic neuropathic pain.</p>\r\n
# <p><strong>Methods: </strong>Data from a clinical study including neonatal patients (n=41) was used for the purposes of this analysis. Tramadol was administered intravenously at an average loading dose of 2.1 mg/kg over 30 minutes, followed by continuous infusion of 0.35 mg/kg/h. Plasma concentrations were collected (n=452) at various time points over 24 hours after first dose and analysed in an integrated manner, including parent drug and M1. Based on a previously published model [3], we were able to further describe tramadol PK by incorporating genotype information, splitting the population into 3 ascending cohorts of activity scores (AS) for CYP2D6 (1,2,3) and OCT1 (0,1,2). The disposition of both moieties was characterised by a two-compartment model for tramadol with two additional compartments for M1, according to a zero-order input and first order elimination process. Clearance and volume parameters for tramadol and M1 were standardized to a body weight of 70 kg using an allometric model. Age-related changes in the formation clearance of M1 (CLPM), residual tramadol clearance (CLPO) and M1 clearance (CLMO) were described by a sigmoid maturation model, with CYP2D6 as a covariate on CLPM and CLPO, and OCT1 on CLMO. Goodness-of-fit plots and VPCs were used as visually diagnostic tools to assess model performance, and complemented by external validation procedures [4].
# Final model parameters along with the estimated covariate effects and prevalence data on CYP2D6 and OCT1 polymorphisms were used to explore the clinical implications of genotype, age and weight-related changes in the disposition of tramadol and M1. Clinical trial simulations were implemented using a virtual patient population across a wide age range (3 months to 18 years ). Baseline demographic characteristics were obtained from paediatric data available from the NHANES) [5] and CALIPER [6] databases. To disentangle the effect of different covariates, each patient was simulated assuming every possible combination of CYP2D6 and OCT1 genotype. Specific simulations focussed on two genetic combinations of clinical concern and prevalence; CYP 2D6 AS3 /OCT1 AS 0 and CYP 2D6 AS 2/OCT 1 AS 0, respectively. Secondary parameters describing the overall systemic exposure to tramadol and M1 were also derived (i.e. AUC and Cmax). Patients were stratified by weight and genotype pairs and results were summarised as medians and 90% confidence intervals. </strong></p>\r\n
# <p><strong>Results: </strong>We estimated differences in CLPM in CYP2D6 groupings of 2.86 L/h, 5.69 L/h, 8.11 L/h, CLPO of 28.8 L/h, 34.7 L/h, 43.3 L/h and CLMO of 29 L/h, 36.1. L/h and 34 L/h. Additionally, PK simulations of all CYP2D6 and OCT1 combinations revealed that for over 25% of subjects, M1 plasma concentrations following a dose of 2mg/kg are above a range considered to be analgesic (200-300ng/mL). This is highlighted by the population median Cmax of tramadol at 48 hours being 737.4 ng/mL when administered at 2mg/kg in three divided doses. This indicates that commonplace dosing at a higher level may lead to undesired effects</p>\r\n
# <p><strong>Conclusion: </strong>Although interindividual variability in the PK of tramadol in very young patients is high, CYP2D6 and OCT1 polymorphisms play significant roles in the variation in exposure observed in paediatric patients. The interaction between maturation, developmental growth and genetic factors results in clinically relevant differences in exposure to tramadol and its metabolite, even after dosing regimens based on mg/kg. Moreover, currently prescribed doses result in concentrations which are above the anticipated target levels for analgesia, explaining some of the observed unwanted adverse effects in children. Consequently, in the absence of genotyping data, a lower starting dose of tramadol (0.5 mg/kg) should be considered, followed by stepwise titration to the desired effect.</p><p><p><strong>References:</strong> <br />1.	Allegaert K, Rochette A & Veyckemans F. Developmental pharmacology of tramadol during infancy: ontogeny, pharmacogenetics and elimination clearance. Pediatric Anesthesia 21 (2011) 266-273.<br />
# 2.	Gong Li, Stamer Ulrike M, Tzvetkov Mladen V, Altman Russ B, and Klein Teri E. Pharm GKB summary: tramadol pathway Pharmacogenetics and genomics.2014.<br />
# 3.	Allegaert K, Holford N, Anderson BJ, Holford S, Stuber F et al. Tramadol and O-Desmethyl Tramadol Clearance Maturation and Disposition in Humans: A Pooled Pharmacokinetic Study. 2015, Clin Pharmacokinet (2015) 54:167-178.<br />
# 4.	Garrido MJ, Habre W, Rombout F, Troc?niz IF. Population pharmacokinetic/pharmacodynamic modelling of the analgesic effects of tramadol in pediatrics. Pharm Res. 2006 Sep;23(9):2014-23.<br />
# 5.	National Health and Nutrition Examination Survey Data. Hyattsville, MD: U.S. Department of Health and Human Services, Centers for Disease Control and Prevention, [2017-2018] [https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx?Component=Demographics&CycleBeginYear=2017].<br />
# 6.	Centers for Disease Control and Prevention. Clinical Growth Charts. 2009; Available from: http://www.cdc.gov/growthcharts/clinical_charts.htm
# </p></p>",
#   length=0,
#   affiliation="(1) Clinical Pharmacology & Therapeutics Group, University College London, (2) Department of Development and Regeneration, KU Leuven, Leuven, Belgium",
#   Number=NA,
#   Grp=NA,
#   Etime=NA,
#   firstname="Paul",
#   lastname="Healy",
#   fullname = "Paul Healy",
#   email1="paul.healy.13@ucl.ac.uk",
#   pdf=""
# )
# 
# abstracts <- rbind(abstracts, healy)


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

