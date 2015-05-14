# TODO: Add comment
# 
# Author: Atri
###############################################################################

#dev.new(width=5, height=4)
png(file="mygraphic.png",width=400,height=350)


#cost.gain <- c((541-545)/545, (68274 - 10768)/68274, (521-231)/521, (1176-1642)/1176, (6924-6339)/6924, (2750-903)/2750)
#cost.prog <- c(60.28, 86.67, 35.5, 12.63, 25.17, 28.07)
#cost.proj <- c(61, 11.20, 32.8, 9.46, 18.28, 21.21)

cost.prog <- c(100-7.44,100-98,100-3.92,100-3.35,100-1.76,100-7.05)
cost.proj <- c(100-7.44,100-12.5,100-2.78,100-3.3,100-0.89,100-4.27)

data <- matrix(c(cost.prog,cost.proj), nrow = 6, ncol = 2,byrow = FALSE)
dimnames(data) <- list(c("Apache\n","Berk. C\n","Berk.Java\n","LLVM\n","SQLLite\n","x264\n"), c("Progressive","Projective"))

barplot(t(data),beside = TRUE,xpd = FALSE,ylim=c(85,100),cex.names=0.75,col=c("gray","black"),ylab=expression(paste("Real Accuracy at n*")) ,axes=F)
axis(side=2, at=seq(from=85, to=100, by=2), cex.axis=0.75)
axis(1,at=mp,labels=rownames(data))
legend("topleft",bty="n",legend = c("Progressive", "Projective"),fill = c("gray", "black"),cex=0.75)
#text(2, 65, expression(paste("(x10"^"1",")")),cex=0.8)
#text(6, 85, expression(paste("(x10"^"3",")")),cex=0.8)
#text(8, 40, expression(paste("(x10"^"1",")")),cex=0.8)
#text(11, 21, expression(paste("(x10"^"2",")")),cex=0.8)
#text(14, 31, expression(paste("(x10"^"2",")")),cex=0.8)
#text(17, 35, expression(paste("(x10"^"2",")")),cex=0.8)

#dev.copy(png,filename="cost_comp.png",height=4, width=5);
dev.off ();
