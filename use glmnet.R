library(glmnet)

# load data and filter it suitable for regression

matchdata <- read.csv("c:/Users/tatli/OneDrive/Documents/2017 match data.csv")
ts <- xtabs( Result ~ Date + Player, matchdata, sparse=T)
ts <- ts[ ,-which(dimnames(ts)[[2]]=="Other")]  # ignore unnamed players
ts <- ts[-which( abs(rowSums(ts))>1 ), ]        # ignore two dates' unbalanced teams
ts <- cbind(ts, missing = -rowSums(ts))         # add column for down one player
ts <- ts[ ,-which(colSums(abs(ts))<5)]          # remove players with under five games
ws <- matrix(1, nrow(ts))

# perform penalised regression with 80% ridge and 20% lasso , force "intercept" = F, so no constant bias win/lose can occur
s <- NULL
for(i in 1:10){
 plr <- cv.glmnet(rbind(ts,-ts), rbind(ws,-ws), nfolds=5, alpha=0.2, family="binomial", intercept = F )
 strength <- sort( plr$glmnet.fit$beta[, which( plr$lambda == plr$lambda.1se ) ] , decreasing = T)
 s <- rbind( s , cbind( strength[strength!=0], 1:sum(strength!=0) ) )
}
