print("FIT hicks study")
hicks.law.data<-read.table("all_data.txt", sep="\t", header = T);
#mean(hicks.law.data$partiID);
#class(hicks.law.data$partiID);
#order(factor(hicks.law.data$partiID))
#help(order)
#plot(hicks.law.data$tEnd.ms.);
#filter (use bool as index and choose non-zero)
hicks.law.data <- hicks.law.data[hicks.law.data$tEnd.ms.!=0,];
hicks.law.data <- hicks.law.data[hicks.law.data$tEnd.ms.>200,];
hicks.law.data <- hicks.law.data[hicks.law.data$tEnd.ms.<2000,];
plot(hicks.law.data$tEnd.ms.)


# check normality using histogram
hist(hicks.law.data$tEnd.ms.)
lines(density(hicks.law.data$tEnd.ms.))


#group for plotting
hicks.law.data$plot.group <- paste(hicks.law.data$fNmb, hicks.law.data$gesture, hicks.law.data$gestureSet);
library(lattice);
histogram(~tEnd.ms. | partiID*plot.group, nint=30, data=hicks.law.data)


#log scale t1End.ms.
hicks.law.data$log_time <-log(hicks.law.data$tEnd.ms.);
hicks.law.data <- hicks.law.data[hicks.law.data$log_time>5,];
histogram(~log_time | partiID*plot.group, nint=30, data=hicks.law.data)


#plot mean and stde
install.packages("gplots")
library(gplots);
plotmeans(log_time~condiID, data=hicks.law.data,
          xlab="Condition ID",
          ylab="Logarithm of Reponse Time",
          main="Mean Plot\nwith 95% CI"
);

plotmeans(log_time~fNmb, data=hicks.law.data,
          xlab="fNmb",
          ylab="Logarithm of Reponse Time",
          main="Mean Plot\nwith 95% CI"
);

plotmeans(log_time~gesture, data=hicks.law.data,
          xlab="fNmb",
          ylab="Logarithm of Reponse Time",
          main="Mean Plot\nwith 95% CI"
);
plotmeans(log_time~paste( hicks.law.data$gestureSet,
                          hicks.law.data$gesture,
                          hicks.law.data$fNmb), data=hicks.law.data,
          xlab="fNmb",
          ylab="Logarithm of Reponse Time",
          main="Mean Plot\nwith 95% CI"
);

#interaction plot
interaction.plot(response = hicks.law.data$log_time,
                 x.factor=hicks.law.data$gestureSet,
                 trace.factor=paste(hicks.law.data$gesture,
                                    hicks.law.data$fNmb),
                 ylab="Logarithm of Response Time",
                 xlab="Gesture Set",
                 main="Interaction Plots");

#fit ANOVA
fit <- aov(log_time ~ gestureSet*gesture*fNmb + partiID,
           data = hicks.law.data);

#use TYPE III and F Tests
install.packages("sjstats")
library(sjstats)
drop1(fit, ~., test="F");
anova_stats(fit)


# Bonferroni corrected multiple comparison
pairwise.t.test(
  hicks.law.data$log_time,
  paste( hicks.law.data$gestureSet,
         hicks.law.data$gesture,
         hicks.law.data$fNmb),
  alternative = "two.sided",
  p.adjust.method = "bonf")
)
