### CYP450
### input
attach(CYP450_total)

### normality test
shapiro.test(CYP450)
#Shapiro-Wilk normality test

#data:  CYP450
#W = 0.94915, p-value = 0.0005523

### homogeneity test
bartlett.test(CYP450 ~ Locality)
#Bartlett test of homogeneity of variances

#data:  CYP450 by Locality
#Bartlett's K-squared = 0.064098, df = 1, p-value = 0.8001

### transformation
library(MASS)
require(MASS)
boxcox(CYP450 ~ Locality)
locator() #click on the intersection+esc, use the x value
factor_trs = ((CYP450^-0.03953286)-1)/-0.03953286

### normality test
shapiro.test(factor_trs)
#Shapiro-Wilk normality test

#data:  factor_trs
#W = 0.97568, p-value = 0.06150

### homogeneity test
bartlett.test(factor_trs ~ Locality)
#Bartlett test of homogeneity of variances

#data:  factor_trs by Locality
#Bartlett's K-squared = 0.95281, df = 1, p-value = 0.329




### ANOVA
anova = aov(factor_trs ~ Month+Colony+Month*Colony)
summary(anova)
# Df Sum Sq Mean Sq F value  Pr(>F)   
# Month         3  1.351  0.4505   4.121 0.00903 **
# Colony        5  0.814  0.1628   1.490 0.20251   
# Month:Colony 15  3.710  0.2473   2.262 0.01030 * 
# Residuals    80  8.746  0.1093                   
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

library(laercio)
require(laercio)
LTukey(anova)
#TUKEY TEST TO COMPARE MEANS 

# Confidence level:  0.95 
# Dependent variable:  factor_trs
# Variation Coefficient:  -1164.217 % 

# Independent variable:  Month 
# Factors Means                 
# MAR     0.154831183599385   a 
# FEB     -0.0265903232426882 ab
# APR     -0.0865471182767651 ab
# JAN     -0.164196615238786   b




### ANOVA
anova = aov(factor_trs ~ Month*Health_in_March+Month*Intensity+Month*Mother_Daughter)
summary(anova)
# Df Sum Sq Mean Sq F value Pr(>F)  
# Month                  3  1.351  0.4505   3.983 0.0104 *
# Health_in_March        1  0.324  0.3244   2.868 0.0939 .
# Intensity              1  0.012  0.0121   0.107 0.7444  
# Mother_Daughter        1  0.028  0.0281   0.248 0.6195  
# Month:Health_in_March  3  0.856  0.2855   2.524 0.0628 .
# Month:Intensity        3  1.160  0.3868   3.420 0.0207 *
# Month:Mother_Daughter  3  0.937  0.3124   2.762 0.0468 *
# Residuals             88  9.952  0.1131                   
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1




### t-test on especific month
# only in january
attach(CYP450_jan)

factor_trs = ((CYP450^-0.03953286)-1)/-0.03953286

t.test(factor_trs ~ Health_in_March, var.equal=T)
#Two Sample t-test

#data:  factor_trs by Health_in_March
#t = -2.2356, df = 21, p-value = 0.03636