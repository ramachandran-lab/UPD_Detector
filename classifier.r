#!/usr/bin/Rscript

options(scipen=999)
args <- commandArgs(TRUE)

model = read.table(args[1], as.is=T, sep = ',', header = T)
#model = read.table("./NE_classifier_parameters.txt", as.is=T, sep = ',', header = T)

for (chr in 1:23) {
  data = read.table(paste0(args[2], chr), as.is = T, header=T)
  colnames(data) <- c('ids', 'totclen', 'secondmax')
  newdata = as.data.frame(newdata)
  m2 = model[chr,2] + model[chr,3]*newdata$totclen + model[chr,4]*newdata$secondmax + model[chr,5]*newdata$totclen*newdata$secondmax
  newdata$status = exp(m2)/(1+exp(m2))
  write.table(cbind(randindices$Indiv_ID, newdata$status), file = paste0(args[3],'.chr',chr,'.predictions.txt'), quote = F, col.names = F, row.names=F)
}

chrs = c()
thres = c(0.8433333, 0.8133333, 0.7900000, 0.8100000, 0.7933333, 0.7766667, 0.8066667, 0.7466667, 0.6933333, 0.7933333, 0.6933333, 0.7366667, 0.6433333, 0.7000000, 0.6333333, 0.6800000, 0.6700000, 0.6933333, 0.6200000, 0.6500000, 0.6066667, 0.5233333, 0.7233333)

for (i in 1:23) {
  pred = read.table(paste0(args[3],'.chr',chr,'.predictions.txt'), as.is = T, header =F)
  ids = pred$V1[which(pred$V2>=thres[i])]
  probs = pred$V2[which(pred$V2>=thres[i])]
  if (i==1) {out = rbind(ids, rep(i, length(ids)), probs)}
  else {out =  cbind(out, rbind(ids, rep(i, length(ids)), probs))}
  chrs = c(chrs, length(ids))
}
#filter duplicates
toremove = out[1,which(duplicated(out[1,])==T)]
newout = out[,which(!(out[1,] %in% toremove))]
newout = newout[,which(newout[3,]>=0.9)]
test = barplot(table(newout[2,]))
setzero = setdiff(1:23, unique(newout[2,]))
dummy = rep(0, length(setzero))
names(dummy)<-setzero
counts= c(table(newout[2,]), dummy)
counts = counts[order(as.numeric(names(counts)))]

## write out putative UPD ids and chromosomes
write.table(t(newout[1:2,]), file = args[4], quote = F, col.names = F, row.names = F)
