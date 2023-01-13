library(tidyverse)

# Load Dataset
df <- read_csv("ghana-food-prices-1.csv", show_col_types = FALSE)

# Filter the Dataframe to get the prices of 50KG local and imported rice in Ghana
dfRiceOnly <- df %>%
              filter(cmname %in% c("Rice (local) - Wholesale",
                "Rice (imported) - Wholesale")) %>%
                filter(unit %in% "50 KG")

pdf("visualization.pdf")

# Box Plot
####################
#png(filename = "Boxplot-of-rice-against-price.png")
x <- dfRiceOnly$cmname
y <- as.numeric(dfRiceOnly$price)


boxplot(y ~ x,
        main = "Boxplot of cmname against Price",
        xlab = "cmname - Commodity Name",
        ylab = "Price",
        boxlty = 5,
        boxfill = c("beige", "azure2"),
        boxcol = "cadetblue1",
        whiskcol = "cadetblue1",
        yaxt = "n"
        )

        axis(side = 2, las = 2, labels = names(x))
        
#dev.off()


# Histogram
####################
        
Rice.50KG.Local <- df %>%
          filter(cmname %in% c("Rice (local) - Wholesale")) %>%
          filter(unit %in% "50 KG")
        
Rice.50KG.Imported <- df %>%
          filter(cmname %in% c("Rice (imported) - Wholesale")) %>%
          filter(unit %in% "50 KG")

y1 <- as.numeric(Rice.50KG.Local$price)
x1 <- Rice.50KG.Local$cmname
y1Min <- min(y1)
y1Max <- max(y1)
y1Mean <- mean(y1)
y1Sd <- sd(y1)

y2 <- as.numeric(Rice.50KG.Imported$price)
x2 <- Rice.50KG.Imported$cmname
y2Min <- min(y2)
y2Max <- max(y2)
y2Mean <- mean(y2)
y2Sd <- sd(y2)

#png(filename = "Histogram-of-local-rice.png")
# Histogram of price of local rice
h <- hist(
  y1, density = 10, breaks = 10,
  freq = TRUE,
  border = "blue",
  col = "aquamarine",
  main = "Histogram of Price of Local Rice",
  xlab = "Price of local rice",
  yaxt = "n"
  )

  axis(side = 2, las = 2, labels = names(x))

w <- seq(y1Min, y1Max, 1)
z <- dnorm(w, mean = y1Mean, sd = y1Sd)

z1 <- z * diff(h$mid[1:2]) * length(y1)

lines(w, z1, col = "darkorange4")
#dev.off()

#png(filename = "Histogram-of-imported-rice.png")
# Histogram of price of imported rice
h <- hist(
  y2, density = 10, breaks = 10,
  freq = TRUE,
  border = "blue",
  col = "aquamarine",
  main = "Histogram of Price of Imported Rice",
  xlab = "Price of imported rice",
  yaxt = "n"
)

axis(side = 2, las = 2, labels = names(x))

w <- seq(y2Min, y2Max, 1)
z <- dnorm(w, mean = y2Mean, sd = y2Sd)

z1 <- z * diff(h$mid[1:2]) * length(y2)

lines(w, z1, col = "darkorange4")


dev.off()
