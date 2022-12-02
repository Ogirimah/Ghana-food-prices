library(tidyverse)

# Load Dataset
df <- read_csv("ghana-food-prices-1.csv")

# Filter the Dataframe to get the 
dfRiceOnly <- df %>% filter(cmname %in% c("Rice (local) - Wholesale", "Rice (imported) - Wholesale"))

pdf("visualization.pdf")

# Box Plot
####################

x <- dfRiceOnly$cmname
y <- as.numeric(dfRiceOnly$price)


boxplot(y ~ x,
        main = "Boxplot of Commodity Name against Price",
        xlab = "Commodity Name",
        ylab = "Price"
        )

# Histogram
####################

yMin <- min(y)
yMax <- max(y)
yMean <- mean(y)
ySd <- sd(y)

h <- hist(
  y, breaks = 5, density = 10 # Change the value of 'breaks' to get a better histogram
)

w <- seq(yMin, yMax, 1)
z <- dnorm(w, mean = yMean, sd = ySd)

z1 <- z * diff(h$mid[1:2]) * length(y)

lines(w, z1, col = "green")

dev.off()

# To do
# Add fill to the points in the boxplot
# Color the boxes
# Change the orientation of the xlab value points
# Colour and beautify the histogram lines
# Make sure the overlayed line goes from edge to edge by making sure all NA values are removed from the dataset while calculating ymin and ymax