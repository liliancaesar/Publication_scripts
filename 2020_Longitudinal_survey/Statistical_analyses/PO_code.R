### PO
### input
attach(PO_total)

### normality test
shapiro.test(PO)
#Shapiro-Wilk normality test

#data:  PO
#W = 0.93103, p-value = 3.178e-05

### homogeneity test
bartlett.test(PO ~ Locality)
#Bartlett test of homogeneity of variances

#data:  PO by Locality
#Bartlett's K-squared = 3.1117, df = 1, p-value = 0.07773

### transformation
library(MASS)
require(MASS)
boxcox(PO ~ Locality)
locator() #click on the intersection+esc, use the x value
factor_trs = ((PO^0.55346)-1)/0.55346

### normality test
shapiro.test(factor_trs)
#Shapiro-Wilk normality test

#data:  factor_trs
#W = 0.97278, p-value = 0.06686

### homogeneity test
bartlett.test(factor_trs ~ Locality)
#Bartlett test of homogeneity of variances

#data:  factor_trs by Locality
#Bartlett's K-squared = 3.8246, df = 1, p-value = 0.07051




### ANOVA
anova = aov(factor_trs ~ Month+Colony+Month*Colony)
summary(anova)
# Df Sum Sq Mean Sq F value Pr(>F)  
# Month         3  0.871  0.2902   2.075 0.1097  
# Colony        5  1.783  0.3567   2.551 0.0338 *
# Month:Colony 15  4.491  0.2994   2.141 0.0152 *
# Residuals    83 11.607  0.1398                 
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

library(laercio)
require(laercio)
LTukey(anova)
#TUKEY TEST TO COMPARE MEANS 

#Confidence level:  0.95 
#Dependent variable:  factor_trs
#Variation Coefficient:  -393.5594 % 

#Independent variable:  Colony 
#Factors Means                  
#BP3     0.063752557323214    a 
#BP1     0.0137832411087626   ab
#PA2     -0.00854310875942506 ab
#PA1     -0.130219759373611   ab
#PA3     -0.14050504385965    ab
#BP2     -0.331514989569974    b




### ANOVA
anova = aov(factor_trs ~ Month*Health_in_March+Month*Intensity+Month*Mother_Daughter)
summary(anova)
# Df Sum Sq Mean Sq F value  Pr(>F)   
# Month                  3  0.871  0.2902   1.821 0.14882   
# Health_in_March        1  0.093  0.0934   0.586 0.44598   
# Intensity              1  0.083  0.0832   0.522 0.47179   
# Mother_Daughter        1  0.310  0.3098   1.945 0.16657   
# Month:Health_in_March  3  2.068  0.6895   4.327 0.00673 **
# Month:Intensity        3  0.102  0.0341   0.214 0.88642   
# Month:Mother_Daughter  3  0.725  0.2416   1.516 0.21566   
# Residuals             91 14.499  0.1593




### t-test on especific month
# only in january
attach(PO_jan)

factor_trs = ((PO^0.55346)-1)/0.55346

t.test(factor_trs ~ Health_in_March, var.equal=T)
#Two Sample t-test

# data:  factor_trs by Health_in_March
# t = -2.2921, df = 23, p-value = 0.03138