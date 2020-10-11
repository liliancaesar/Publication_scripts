### ApoLp
### input
attach(APOLP_total)

### normality test
shapiro.test(ApoLp)
#Shapiro-Wilk normality test

# data:  ApoLp
# W = 0.98454, p-value = 0.2297

### homogeneity test
bartlett.test(ApoLp ~ Locality)
#Bartlett test of homogeneity of variances

# data:  ApoLp by Locality
# Bartlett's K-squared = 1.6898, df = 1, p-value = 0.1936





### ANOVA
anova = aov(ApoLp ~ Month+Colony+Month*Colony)
summary(anova)
# Df Sum Sq Mean Sq F value  Pr(>F)   
# Month         3  0.675  0.2250   2.048   0.1131    
# Colony        5  1.858  0.3716   3.383   0.0077 ** 
# Month:Colony 15  6.126  0.4084   3.717 5.08e-05 ***
# Residuals    87  9.559  0.1099                 
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

library(laercio)
require(laercio)
LTukey(anova)
# TUKEY TEST TO COMPARE MEANS 

# Confidence level:  0.95 
# Dependent variable:  ApoLp
# Variation Coefficient:  26.94788 % 

# Independent variable:  Colony 
# Factors Means               
# BP1     1.38797061981169  a 
# PA2     1.35598238112677  a 
# PA3     1.247466565856    ab
# BP3     1.23127712513797  ab
# PA1     1.17986641785433  ab
# BP2     0.990895208033538  b




### ANOVA
anova = aov(ApoLp ~ Month*Health_in_March+Month*Intensity+Month*Mother_Daughter)
summary(anova)
# Df Sum Sq Mean Sq F value  Pr(>F)   
# Month                  3  0.675  0.2250   1.701 0.17208   
# Health_in_March        1  0.175  0.1754   1.326 0.25245   
# Intensity              1  0.641  0.6407   4.844 0.03016 * 
# Mother_Daughter        1  0.074  0.0741   0.560 0.45609   
# Month:Health_in_March  3  2.278  0.7594   5.741 0.00118 **
# Month:Intensity        3  1.508  0.5025   3.799 0.01274 * 
# Month:Mother_Daughter  3  0.301  0.1004   0.759 0.51990   
# Residuals             95 12.566  0.1323                   
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1




### t-test on especific month
# only in january
attach(APOLP_jan)

t.test(ApoLp ~ Health_in_March, var.equal=T)
# Two Sample t-test

# data:  ApoLp by Health_in_March
# t = -3.2051, df = 26, p-value = 0.003557