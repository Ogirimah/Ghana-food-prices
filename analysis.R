#!/usr/bin/X11/Rscript
library(tidyverse)
df <- read_csv("ghana-food-prices-1.csv", show_col_types = FALSE)

dfRiceOnly <- df %>%
              filter(cmname %in% c("Rice (local) - Wholesale",
                "Rice (imported) - Wholesale")) %>%
                filter(unit %in% "50 KG")
                
x <- dfRiceOnly$cmname
y <- as.numeric(dfRiceOnly$price)


wilcox.test(y ~ x)
