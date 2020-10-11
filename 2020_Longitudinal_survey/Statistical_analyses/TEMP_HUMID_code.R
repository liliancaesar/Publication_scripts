### Temperatue and Humidity
### input
attach(Temp_Humid_March)

### normality test
shapiro.test(Minimum_temperature)
#Shapiro-Wilk normality test

# data:  Minimum_temperature
# W = 0.97045, p-value = 0.0005637

### homogeneity test
bartlett.test(Minimum_temperature ~ Locality)
#Bartlett test of homogeneity of variances

# data:  Minimum_temperature by Locality
# Bartlett's K-squared = 0.041812, df = 1, p-value = 0.838

### transformation
library(MASS)
require(MASS)
boxcox(Minimum_temperature ~ Locality)
locator() #click on the intersection+esc, use the x value
factor_trs = ((Minimum_temperature^1.381767)-1)/1.381767

### normality test
shapiro.test(factor_trs)
#Shapiro-Wilk normality test

# data:  factor_trs
# W = 0.97631, p-value = 0.002988

### homogeneity test
bartlett.test(factor_trs ~ Locality)
#Bartlett test of homogeneity of variances

# data:  factor_trs by Locality
# Bartlett's K-squared = 0.15606, df = 1, p-value = 0.6928

# Mann-Whitney test
wilcox.test(Minimum_temperature ~ Syndrome_days)
# Wilcoxon rank sum test with continuity correction

# data:  Minimum_temperature by Syndrome_days
# W = 2665.5, p-value = 5.993e-05
# alternative hypothesis: true location shift is not equal to 0








### normality test
shapiro.test(Maximum_humidity)
#Shapiro-Wilk normality test

# data:  Maximum_humidity
# W = 0.95333, p-value = 8.393e-06

### homogeneity test
bartlett.test(Maximum_humidity ~ Locality)
#Bartlett test of homogeneity of variances

# data:  Maximum_humidity by Locality
# Bartlett's K-squared = 4.0159, df = 1, p-value = 0.04507

### transformation
library(MASS)
require(MASS)
boxcox(Maximum_humidity ~ Locality)
locator() #click on the intersection+esc, use the x value
factor_trs = ((Minimum_temperature^1.466481)-1)/1.466481

### normality test
shapiro.test(factor_trs)
#Shapiro-Wilk normality test

# data:  factor_trs
# W = 0.97738, p-value = 0.004105

### homogeneity test
bartlett.test(factor_trs ~ Locality)
#Bartlett test of homogeneity of variances

# data:  factor_trs by Locality
# Bartlett's K-squared = 0.19122, df = 1, p-value = 0.6619

# Mann-Whitney test
wilcox.test(Maximum_humidity ~ Syndrome_days)
# Wilcoxon rank sum test with continuity correction

# data:  Maximum_humidity by Syndrome_days
# W = 495, p-value = 1.019e-07
# alternative hypothesis: true location shift is not equal to 0





#### Delta Temperature and Humidity
### input
attach(Delta)

# Kruskal-Wallis test
kruskal.test(Delta_t ~ Month, data = Delta)
#	Kruskal-Wallis rank sum test

#data:  Delta_t by Month
#Kruskal-Wallis chi-squared = 136.19, df = 5, p-value < 2.2e-16

# Nemenyi test
library(PMCMRplus)
kwAllPairsNemenyiTest(Delta_t ~ factor(Month))



# Kruskal-Wallis test
kruskal.test(Delta_h ~ Month, data = Delta)
#	Kruskal-Wallis rank sum test

# data:  Delta_h by Month
# Kruskal-Wallis chi-squared = 154.01, df = 5, p-value < 2.2e-16

# Nemenyi test
library(PMCMRplus)
kwAllPairsNemenyiTest(Delta_h ~ factor(Month))


