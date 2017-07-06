Exercise 2
================

1. Understanding and Fixing Code
--------------------------------

### Fix the part of the code that shows the cold months in Baltimore (Lecture02/02-PrimitiveTypes) so we know which are those months.

``` r
tempLo <- c(23.5,26.1,33.6,42.0,51.8,60.8,65.8,63.9,56.6,43.7,34.7,27.3)
months <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
names(tempLo) <- months
tempLo
```

    ##  Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec 
    ## 23.5 26.1 33.6 42.0 51.8 60.8 65.8 63.9 56.6 43.7 34.7 27.3

### What would happen if we still had a NA on the vector for the temperatures in SJC? (Lecture02/05-Factors)?

``` r
tempLo2 <- tempLo
tempLo2[2] <- NA
tempLo2
```

    ##  Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec 
    ## 23.5   NA 33.6 42.0 51.8 60.8 65.8 63.9 56.6 43.7 34.7 27.3

``` r
factor(tempLo2)
```

    ##  Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec 
    ## 23.5 <NA> 33.6   42 51.8 60.8 65.8 63.9 56.6 43.7 34.7 27.3 
    ## Levels: 23.5 27.3 33.6 34.7 42 43.7 51.8 56.6 60.8 63.9 65.8

``` r
cut(tempLo2,
   breaks=c(-Inf,18,20, Inf),
   labels=c("Cool","Mild","Hot"))
```

    ##  [1] Hot  <NA> Hot  Hot  Hot  Hot  Hot  Hot  Hot  Hot  Hot  Hot 
    ## Levels: Cool Mild Hot

O Valor **NA** continua existindo no vetor quando ele é convertido (ou produzido) para **factor**.

### What happens if we try to run sjcTemps\["Jan":"Jul",c(1,3)\]? Why? (see Lecture02/06-DataFrames).

Não é possível acessar os dados desta forma, pois *"Jan":"Jul"* não é válido no **R**.

``` r
maxTempSJC <- c(29.7,30.1,29.5,27.3,25.1,24.3,24.1,26.2,27.2,27.3,28,28.7)
avgTempSJC <- c(22.2,22.4,21.6,19.6,17,16.1,15.6,17.1,18.8,19.4,20.3,21.4)
minTempSJC <- c(16.2,16.5,15.7,13.2,10.1,8.9,8.2,9.9,11.9,13.4,14.2,15.3)
months <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
sjcTemps <- data.frame(Max=maxTempSJC,Avg=avgTempSJC,Min=minTempSJC,row.names = months)
sjcTemps["Jan":"Jul",c(1,3)]
```

    ## Warning in `[.data.frame`(sjcTemps, "Jan":"Jul", c(1, 3)): NAs introduced
    ## by coercion

    ## Warning in `[.data.frame`(sjcTemps, "Jan":"Jul", c(1, 3)): NAs introduced
    ## by coercion

    ## Error in "Jan":"Jul": NA/NaN argument

O correto seria passar os meses Jan e Jul como uma lista.

``` r
sjcTemps[c("Jan","Jul"),c(1,3)]
```

    ##      Max  Min
    ## Jan 29.7 16.2
    ## Jul 24.1  8.2

### We can change Data Frames with sjcTemps3\["Aug",\] &lt;- c(1,2,3) and sjcTemps3\["Jul",\] &lt;- sjcTemps3\["Jul",\]+c(3,4) but we cannot change with sjcTemps3\["Jul",\] &lt;- c(3,4). Why? (see Lecture02/06-DataFrames)

Aparentemente, regra de reciclagem (*Recycling Rule*) é aplicada na operação entre os vetores e não na operação de atribuição.

``` r
sjcTemps3 <- sjcTemps
sjcTemps3["Aug",]   <-  c(1,2,3)
sjcTemps3["Jul",]   <-  sjcTemps3["Jul",]+c(3,4)
sjcTemps3["Jul",]   <-  c(3,4)
```

    ## Error in `[<-.data.frame`(`*tmp*`, "Jul", , value = c(3, 4)): replacement has 2 items, need 3

### Run some examples that show that the recycling rule reuses the smaller (shorter) vector

``` r
vec <- c(0,1,2,3,4,5,6,7,8,9)
ex1 <- vec + c(1,2)
ex1-vec
```

    ##  [1] 1 2 1 2 1 2 1 2 1 2

``` r
ex2 <- vec + c(1,2,3,4,5)
ex2-vec
```

    ##  [1] 1 2 3 4 5 1 2 3 4 5

``` r
ex3 <- vec + c(1,2,3)
```

    ## Warning in vec + c(1, 2, 3): longer object length is not a multiple of
    ## shorter object length

``` r
ex3-vec
```

    ##  [1] 1 2 3 1 2 3 1 2 3 1

### What does stringsAsFactors=FALSE in read.csv() do? Why do we need it? (see Lecture02/06-DataFrames).

Este atributo indica que as colunas do tipo *string* não devem ser convertidas para o tipo **factor**. Para evitar que as strings sejam convertidas para **factor**, o que pode gerar situações não desejadas, como a mudança na ordenação dos dados.

2. Baltimore Rainfall
---------------------

The average monthly rainfall in Baltimore is, in inches:

``` r
baltimoreRainfall_in <- c(3.47, 3.02, 3.93, 3.00, 3.89, 3.43, 3.85, 3.74, 3.98, 3.16, 3.12, 3.35)
```

The average monthly rainfallin Baltimore is, in millimeters:

``` r
baltimoreRainfall_mm <- baltimoreRainfall_in*25.4
baltimoreRainfall_mm
```

    ##  [1]  88.138  76.708  99.822  76.200  98.806  87.122  97.790  94.996
    ##  [9] 101.092  80.264  79.248  85.090

Labeled values:

``` r
months <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
names(baltimoreRainfall_mm) <- months
baltimoreRainfall_mm
```

    ##     Jan     Feb     Mar     Apr     May     Jun     Jul     Aug     Sep 
    ##  88.138  76.708  99.822  76.200  98.806  87.122  97.790  94.996 101.092 
    ##     Oct     Nov     Dec 
    ##  80.264  79.248  85.090

Average, Minimum and Maximum:

``` r
statsBaltimoreRaionFall <- data.frame(
        Average=mean(baltimoreRainfall_mm),
        Minimum=min(baltimoreRainfall_mm),
        Maximum=max(baltimoreRainfall_mm))
statsBaltimoreRaionFall
```

    ##   Average Minimum Maximum
    ## 1  88.773    76.2 101.092
