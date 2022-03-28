library(ggplot2)
library(tidyverse)
library(dplyr)
library(ggthemes)
library(extrafont)
library(data.table)
library(formattable)
library(tidyr)

bluebold = "#4287f5"
bluesea = "#00BFC4"
yellowline = "#dec954"


luas_es = read_csv('clean_data/ice_extend_clean.csv')

luas_es %>% 
  gather(Bulan,Luas, c(March, September)) %>% 
  ggplot(aes(x=Year, y=Luas, color=Bulan)) +
  geom_line(size=1.2) +
  labs(title = "Luas Es Pada Kutub Utara Waktu ke Waktu",
       subtitle = "Bagaimana Perubahan Luas Es Pada Kutub Utara Setiap Puncak Musimnya ?",
       x="Tahun",
       y="Luas Es Dalam Kuadrat Mil (Sqr Miles)",
       color="Puncak Musim (Bulan)") +
  theme_fivethirtyeight() +
  theme(axis.title = element_text()) +
  scale_color_manual(values=c( "#00BFC4","#F8766D"))


level_laut = read_csv('clean_data/slr_year_clean.csv')

level_laut %>% 
  ggplot(aes(x=Day, y=sea_level_rise_average, color="")) +
  geom_line(size=1.2) +
  labs(title = "Ketinggian Air Laut",
       subtitle = "Ketinggian air laut relatif terhadap rata-rata ketinggian pada 1993-2008",
       x="Tahun",
       y="Ketinggian Air Laut (Dalam mm)",
       color="Ketinggian") +
  theme_fivethirtyeight() +
  theme(axis.title = element_text())+
  scale_color_manual(values=c("#4287f5")) +
  geom_smooth(method = "lm", col='#dec954') + 
  geom_hline(yintercept=0)


area_dampak = read_csv('clean_data/slr_country_clean.csv')

area_dampak <- area_dampak %>% arrange(desc(`1m_area`)) %>%
               .[,-c(1,6:9,11:14)] %>% 
                rename(negara = country) %>% 
                rename(luas_area = country_area) %>% 
                rename(area_tenggelam = 4) %>% 
                rename(persen_tenggelam = 5)


formattable(head(area_dampak),
            align =c("l","l","c","c","c"),
            list(`negara` = formatter(
              "span", style = ~ style(color = bluebold, font.weight = "bold")),
              `luas_area`= color_tile(yellowline,yellowline),
              `code` = formatter(
                "span", style = ~ style(color = "grey", font.weight = "bold")),
              `area_tenggelam`= color_bar(bluesea),
              `persen_tenggelam` = formatter(
                "span", style = ~ style(font.weight = "bold"))
            ))
