library(tidyverse)

# Load Dataset
df <- read_csv("ghana-food-prices-1.csv", show_col_types = FALSE)

# Filter the Dataframe to get the 
dfRiceOnly <- df %>%
              filter(cmname %in% c("Rice (local) - Wholesale",
                "Rice (imported) - Wholesale")) %>%
                filter(unit %in% "50 KG")

pdf("visualization.pdf")

# Box Plot
####################

x <- dfRiceOnly$cmname
y <- as.numeric(dfRiceOnly$price)


boxplot(y ~ x,
        main = "Boxplot of Commodity Name against Price",
        xlab = "Commodity Name",
        ylab = "Price",
        boxlty = 5,
        boxfill = c("beige", "azure2"),
        boxcol = "cadetblue1",
        whiskcol = "cadetblue1",
        yaxt = "n"
        )

        axis(side = 2, las = 2, labels = names(x))

# Histogram
####################

yMin <- min(y)
yMax <- max(y)
yMean <- mean(y)
ySd <- sd(y)

h <- hist(
  y, density = 10, breaks = 10,
  freq = TRUE,
  border = "blue",
  col = "aquamarine",
  main = "Histogram of Price",
  xlab = "Price",
  yaxt = "n"
  )

  axis(side = 2, las = 2, labels = names(x))

w <- seq(yMin, yMax, 1)
z <- dnorm(w, mean = yMean, sd = ySd)

z1 <- z * diff(h$mid[1:2]) * length(y)

lines(w, z1, col = "darkorange4")

dev.off()
