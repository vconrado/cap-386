ggplot
================

Com o R Base

``` r
library(datasets)
anscombe1 <- data.frame(anscombe$x1,anscombe$y1)
names(anscombe1) <- c("x","y")
anscombe2 <- data.frame(anscombe$x2,anscombe$y2)
names(anscombe2) <- c("x","y")
anscombe3 <- data.frame(anscombe$x3,anscombe$y3)
names(anscombe3) <- c("x","y")
anscombe4 <- data.frame(anscombe$x4,anscombe$y4)
names(anscombe4) <- c("x","y")
par(mfrow=c(2, 2))
plot(anscombe1,main="Anscombe's #1",xlim=c(4,19),ylim=c(4,13),cex=1.5,pch=19)
abline(lm(anscombe1$y~anscombe1$x),col="red",lwd=2)
plot(anscombe2,main="Anscombe's #2",xlim=c(4,19),ylim=c(4,13),cex=1.5,pch=19)
abline(lm(anscombe2$y~anscombe2$x),col="red",lwd=2)
plot(anscombe3,main="Anscombe's #3",xlim=c(4,19),ylim=c(4,13),cex=1.5,pch=19)
abline(lm(anscombe3$y~anscombe3$x),col="red",lwd=2)
plot(anscombe4,main="Anscombe's #4",xlim=c(4,19),ylim=c(4,13),cex=1.5,pch=19)
abline(lm(anscombe4$y~anscombe4$x),col="red",lwd=2)
```

![](ggplot_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-1.png)

Com ggplot

``` r
# install.package("ggplot2")
library(ggplot2)
library(datasets)



anscombe1df = data.frame(x=anscombe$x1, y=anscombe$y1, grupo=rep("Anscombe 1",11))
anscombe2df = data.frame(x=anscombe$x2, y=anscombe$y2, grupo=rep("Anscombe 2",11))
anscombe3df = data.frame(x=anscombe$x3, y=anscombe$y3, grupo=rep("Anscombe 3",11))
anscombe4df = data.frame(x=anscombe$x4, y=anscombe$y4, grupo=rep("Anscombe 4",11))

anscombedf = rbind(anscombe1df, anscombe2df, anscombe3df, anscombe4df)

ggplot(anscombedf, aes(x=x,y=y)) + 
  geom_point() +
  geom_smooth(method='lm',color="red",lwd = 2, fill=NA) +
  facet_wrap(~grupo)
```

![](ggplot_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)
