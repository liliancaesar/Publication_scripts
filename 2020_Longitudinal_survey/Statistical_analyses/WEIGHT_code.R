### Weight
### input
attach(Weight_total)

### normality test  
shapiro.test(Weight)
#Shapiro-Wilk normality test

# data:  Weight
# W = 0.99243, p-value = 0.4722

### homogeneity test
bartlett.test(Weight ~ Locality)
#Bartlett test of homogeneity of variances

# data:  Weight by Locality
# Bartlett's K-squared = 0.7977, df = 1, p-value = 0.3718





### ANOVA
anova = aov(Weight ~ Month)
summary(anova)
# Df Sum Sq Mean Sq F value  Pr(>F)   
# Month         5 0.002292 0.0004584   10.04 1.84e-08 ***
# Residuals   174 0.007943 0.0000456                     
# ---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

library(laercio)
require(laercio)
LTukey(anova)
#TUKEY TEST TO COMPARE MEANS 

# Confidence level:  0.95 
# Dependent variable:  Weight
# Variation Coefficient:  9.879561 % 

# Independent variable:  Month 
# Factors Means                  
# JAN     0.07346            a   
# FEB     0.0719066666666667 ab  
# DEC     0.0684533333333333 abc 
# MAY     0.0681533333333333  bc 
# APR     0.06533              cd
# MAR     0.0630133333333333    d


