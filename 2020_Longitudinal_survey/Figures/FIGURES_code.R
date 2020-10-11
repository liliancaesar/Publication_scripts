#### FIGURE 1
## BARPLOT GO TERMS
library(ggplot2)

# input
expr <- read.csv("go_term_updown.csv", header=T)

# organize
expr$Hierachy <- factor(expr$Hierarchy, levels=c("BP", "MF", "CC"))

expr$Expression <- factor(expr$Expression, levels=c("up", "down"))

# plot
ggplot (data = expr, aes(x = GO_term, y = DEGs, fill = Expression))+
  geom_col(width = 0.73)+
  theme_light()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1, colour = "black"), axis.text.y = element_text(colour = "black"))+
  scale_fill_manual(values = c("#a7163b", "#e5933f"))+
  facet_grid(. ~ Hierachy, scales="free_x", space = "free")

# print
png("go_terms.png", height=1500, width=1800, res = 300)
ggplot (data = expr, aes(x = GO_term, y = DEGs, fill = Expression))+
  geom_col(width = 0.73)+
  theme_light()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1, colour = "black"), axis.text.y = element_text(colour = "black"))+
  scale_fill_manual(values = c("#a7163b", "#e5933f"))+
  facet_grid(. ~ Hierachy, scales="free_x", space = "free")

dev.off()


## BARPLOT RELATIVE EXPRESSION
library(ggplot2)

# input
expr <- read.csv("CYP450_health.csv", header=T) #the same for "PO_health.csv" and "ApoLp_health.csv"

# organize
expr$Month <- factor(expr$Month, levels=c("JAN", "FEB", "MAR", "APR"))

expr$Health <- factor(expr$Health, levels=c("H", "U"))

# plot
ggplot (data = expr, aes(x = Month, y = CNRQ, fill = Health))+
  geom_col(position = "dodge", width = 0.73)+ylim(0,2.1)+
  scale_fill_manual(values = c("#5a945a", "#4e2e5b"))+
  theme_light()+theme(axis.text.x = element_text(angle = 0, hjust = 0.5, colour = "black"), axis.text.y = element_text(colour = "black"))+ 
  geom_errorbar(aes(ymin= CNRQ-erro, ymax= CNRQ + erro), size=.5, width=.2, position=position_dodge(0.73))


# print
png("CYP450.png", height=800, width=950, res = 300) #change name for different inputs
ggplot (data = expr, aes(x = Month, y = CNRQ, fill = Health))+
  geom_col(position = "dodge", width = 0.73)+ylim(0,2.1)+
  scale_fill_manual(values = c("#5a945a", "#4e2e5b"))+
  theme_light()+theme(axis.text.x = element_text(angle = 0, hjust = 0.5, colour = "black"), axis.text.y = element_text(colour = "black"))+ 
  geom_errorbar(aes(ymin= CNRQ-erro, ymax= CNRQ + erro), size=.5, width=.2, position=position_dodge(0.73))

dev.off()







#### FIGURE 2
## WEIGHT
library(ggplot2)

# input
df <- read.csv("weight.csv", header=T)

# organize
df$Month <- factor(df$Month, levels=c("DEC", "JAN", "FEB","MAR","APR","MAY"))

# plot 
ggplot(data = df, aes(x=Month, y=Weight))+
  geom_boxplot(aes(fill=Month), show.legend = FALSE)+
  scale_fill_manual(values=c("#e5933f", "#e5933f","#e5933f","#e5933f","#e5933f","#e5933f"))+
  theme_light()+
  theme(axis.text.x = element_text(colour = "black"), axis.text.y = element_text(colour = "black"))+
  labs(x = "Month", y = "Grams (g)")

# print
png("weight.png", height=800, width=850, res = 300)
ggplot(data = df, aes(x=Month, y=Weight))+
  geom_boxplot(aes(fill=Month), show.legend = FALSE)+
  scale_fill_manual(values=c("#e5933f", "#e5933f","#e5933f","#e5933f","#e5933f","#e5933f"))+
  theme_light()+
  theme(axis.text.x = element_text(colour = "black"), axis.text.y = element_text(colour = "black"))+
  labs(x = "Month", y = "Grams (g)")

dev.off()


## POLLEN
library(ggplot2)

# input
pollen <- read.csv("pollen.csv", header=T)

# organize according to month
pollen$Month <- factor(pollen$Month, levels=c("Sep", "Oct", "Nov", "Jan", "Feb", "Mar"))

#order plant family
pollen$Plant_family <- factor(pollen$Plant_family, levels=c("Asteraceae", "Begoniaceae", "Fabaceae", "Melastomataceae", "Moraceae", "Myrtaceae", "Salicaceae", "Solanaceae", "Others"))

# plot
ggplot() + geom_bar(aes(y = Percentage, x = Colony, fill = Plant_family), data = pollen, stat="identity")+
  facet_grid(. ~ Month, scales="free_x", space = "free")+
  theme_light()+
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),axis.ticks.x=element_blank(), axis.text.y = element_text(colour = "black") )+
  scale_fill_manual(values = c("#98bc98", "#2d6d2d", "#5a945a", "#ffff99", "#e5933f","#a7163b", "#4e2e5b", "#824D99", "#b2b2ff"))+
  labs(y = "Percentage of pollen grains (%)")

# print
png("pollen.png", height=900, width=1900, res = 300)
ggplot() + geom_bar(aes(y = Percentage, x = Colony, fill = Plant_family), data = pollen, stat="identity")+
  facet_grid(. ~ Month, scales="free_x", space = "free")+
  theme_light()+
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(),axis.ticks.x=element_blank(), axis.text.y = element_text(colour = "black") )+
  scale_fill_manual(values = c("#98bc98", "#2d6d2d", "#5a945a", "#ffff99", "#e5933f","#a7163b", "#4e2e5b", "#824D99", "#b2b2ff"))+
  labs(y = "Percentage of pollen grains (%)")

dev.off() 


## TEMPERATURE AND HUMIDITY
library(ggplot2)

#input
charts.data <- read.csv("temp_humid_march.csv")

# organize
charts.data$Colony <- factor(charts.data$Colony, levels=c("BP1", "BP2", "BP4", "PA1", "PA2", "PA5"))

# plot
ggplot(data= charts.data, aes(x = as.Date(Day), y = t, group= Colony)) +
  geom_line(aes(color= Colony))+
  theme_light()+
  theme(axis.text.x = element_text(angle = 45,hjust = 1, colour = "black"), axis.text.y = element_text(colour = "black"), legend.position="bottom", legend.box="horizontal")+
  scale_x_date(date_breaks = "5 days", date_labels = "%x")+
  scale_colour_manual(values=c("#2d6d2d", "#af8cbd", "#5a945a", "#98bc98", "#4e2e5b", "#824D99"))+
  labs(x = "Day in March", y = "Celsius degrees (°C)")+
  guides(colour = guide_legend(nrow = 1))

# print, for temperature
png("temp_mar.png", height=1100, width=1600, res = 300)
ggplot(data= charts.data, aes(x = as.Date(Day), y = t, group= Colony)) +
  geom_line(aes(color= Colony))+
  theme_light()+
  theme(axis.text.x = element_text(angle = 45,hjust = 1, colour = "black"), axis.text.y = element_text(colour = "black"), legend.position="bottom", legend.box="horizontal")+
  scale_x_date(date_breaks = "5 days", date_labels = "%x")+
  scale_colour_manual(values=c("#2d6d2d", "#af8cbd", "#5a945a", "#98bc98", "#4e2e5b", "#824D99"))+
  labs(x = "Day in March", y = "Celsius degrees (°C)")+
  guides(colour = guide_legend(nrow = 1))

dev.off()
dev.off()

# print, for humidity
png("humid_mar.png", height=1100, width=1600, res = 300)
ggplot(data= charts.data, aes(x = as.Date(Day), y = h, group= Colony)) +
  geom_line(aes(color= Colony))+
  theme_light()+
  theme(axis.text.x = element_text(angle = 45,hjust = 1, colour = "black"), axis.text.y = element_text(colour = "black"), legend.position="bottom", legend.box="horizontal")+
  scale_x_date(date_breaks = "5 days", date_labels = "%x")+
  scale_colour_manual(values=c("#2d6d2d", "#af8cbd", "#5a945a", "#98bc98", "#4e2e5b", "#824D99"))+
  labs(x = "Day in March", y = "Humidity (%)")+
  guides(colour = guide_legend(nrow = 1))

dev.off()


## DELTA TEMPERATURE
# input
expr <- read.csv("delta_temperature.csv")

# organize
expr$Month <- factor(expr$Month, levels=c("DEC", "JAN", "FEB", "MAR", "APR", "MAY"))

# plot
ggplot (data = expr, aes(x = Month, y = ?t, fill = Month))+
  geom_col(position = "dodge", width = 0.73, show.legend = FALSE)+
  scale_fill_manual(values = c("#e5933f", "#e5933f","#e5933f","#e5933f","#e5933f","#e5933f"))+
  theme_light()+
  ylim(0,10)+
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5, colour = "black"), axis.text.y = element_text(colour = "black"))+ 
  geom_errorbar(aes(ymin= ?t-erro, ymax= ?t+erro), size=.5, width=.2, position=position_dodge(0.73))

# print
png("delta_temp.png", height=800, width=850, res = 300)
ggplot (data = expr, aes(x = Month, y = ?t, fill = Month))+
  geom_col(position = "dodge", width = 0.73, show.legend = FALSE)+
  scale_fill_manual(values = c("#e5933f", "#e5933f","#e5933f","#e5933f","#e5933f","#e5933f"))+
  theme_light()+
  ylim(0,10)+
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5, colour = "black"), axis.text.y = element_text(colour = "black"))+ 
  geom_errorbar(aes(ymin= ?t-erro, ymax= ?t+erro), size=.5, width=.2, position=position_dodge(0.73))

dev.off()


## DELTA HUMIDITY
# input
expr <- read.csv("delta_humidity.csv")

# organize
expr$Month <- factor(expr$Month, levels=c("DEC", "JAN", "FEB", "MAR", "APR", "MAY"))

# plot
ggplot (data = expr, aes(x = Month, y = ?h, fill = Month))+
  geom_col(position = "dodge", width = 0.73, show.legend = FALSE)+
  scale_fill_manual(values = c("#e5933f", "#e5933f","#e5933f","#e5933f","#e5933f","#e5933f"))+
  theme_light()+
  ylim(0,12)+
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5, colour = "black"), axis.text.y = element_text(colour = "black"))+ 
  geom_errorbar(aes(ymin= ?h-erro, ymax= ?h+erro), size=.5, width=.2, position=position_dodge(0.73))

# print
png("delta_humid.png", height=800, width=850, res = 300)
ggplot (data = expr, aes(x = Month, y = ?h, fill = Month))+
  geom_col(position = "dodge", width = 0.73, show.legend = FALSE)+
  scale_fill_manual(values = c("#e5933f", "#e5933f","#e5933f","#e5933f","#e5933f","#e5933f"))+
  theme_light()+
  ylim(0,12)+
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5, colour = "black"), axis.text.y = element_text(colour = "black"))+ 
  geom_errorbar(aes(ymin= ?h-erro, ymax= ?h+erro), size=.5, width=.2, position=position_dodge(0.73))

dev.off()







#### FIGURE S1
# input
my_data <- read.csv("correlation.csv", header = TRUE, row.names = 1)

# print the first 6 rows
head(my_data, 6)

#Compute correlation matrix
res <- cor(my_data)
round(res, 2)

cor(my_data, use = "complete.obs")


#Correlation matrix with significance levels (p-value)
library("Hmisc")

res2 <- rcorr(as.matrix(my_data))
res2

# Extract the correlation coefficients
res2$r
# Extract p-values
res2$P

# ++++++++++++++++++++++++++++
# flattenCorrMatrix
# ++++++++++++++++++++++++++++
# cormat : matrix of the correlation coefficients
# pmat : matrix of the correlation p-values
flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}


res2<-rcorr(as.matrix(my_data[, 1:8]))
flattenCorrMatrix(res2$r, res2$P)

# plot results
library(corrplot)

corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)

#shows only significant result
corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.05, insig = "blank")

# print
png("corr.png", height=1200, width=1200, res = 300)
corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.05, insig = "blank")

dev.off()

# histogram
library("PerformanceAnalytics")

# print
png("corr2.png", height=1200, width=1200, res = 300)
chart.Correlation(my_data, histogram=TRUE, pch=19)

dev.off()