#PREPROCESSING
#Melakukan pengolahan terhadap data yang baru saja didapatkan agar dapat digunakan dalam proses analisa

library(tidyverse)
library(plotly)
library(readxl)

# Preprocessing 1
# Data mengenai luasan es laut pada kutub utara

df_es = read_csv("raw_data/arctic-sea-ice_fig-1.csv")

luas_es = df_es %>% 
          `colnames<-`(.[6, ]) %>% 
          .[-c(1:6),-4 ] %>% 
          transform(March = as.numeric(March), September = as.numeric(September))

write.csv(luas_es,"clean_data/ice_extend_clean.csv", row.names = TRUE)




# Preprocessing 2

df_laut = read_csv("raw_data/sea-level-rise.csv")

level_laut = df_laut %>%
              select(c(3,4))

write.csv(level_laut,"clean_data/slr_year_clean.csv", row.names = TRUE)


#Preprocess 3

df_country = read_excel("raw_data/slr-impacts_nov2010.xls")

area_dampak = df_country  %>% 
              `colnames<-`(c("code","country","country_area","1m_area","2m_area","3m_area","4m_area","5m_area","1m_percent","2m_percent","3m_percent","4m_percent","5m_percent")) %>% 
              .[-c(1:10,36:39,53:56,86:89,103:106), ] %>% 
              mutate_at(c(4:13), as.numeric) %>%
              mutate(across(9:13, round, 2))

write.csv(area_dampak,"clean_data/slr_country_clean.csv", row.names = TRUE)
