Exercise 3
================

-   [Preparando o ambiente](#preparando-o-ambiente)
-   [Exercicios](#exercicios)
    -   [The “hotdog” variable for the “Hot Dogs in Baltimore” example can be better defined](#the-hotdog-variable-for-the-hot-dogs-in-baltimore-example-can-be-better-defined)
    -   [I prefer Pizza](#i-prefer-pizza)
    -   [Get the name of the town for the “Hot Dogs in Baltimore” example.](#get-the-name-of-the-town-for-the-hot-dogs-in-baltimore-example.)
        -   [Da maneira 'fácil'](#da-maneira-fácil)
        -   [Passo a passo:](#passo-a-passo)
-   [Limpando a casa](#limpando-a-casa)

Preparando o ambiente
=====================

Cria diretorio para guardar dados temporario

``` r
orig <- getwd()
setwd("/home/vconrado/doutorado/disciplinas/CAP-386/vconrado/cap-386/exercises")
if (!file.exists("./TempData")) {
      dir.create("../TempData")  
}
```

    ## Warning in dir.create("../TempData"): '../TempData' already exists

Baixa arquivo de dados de vendedores de Baltimore

``` r
bVendorsURL <- "https://data.baltimorecity.gov/api/views/bqw3-z52q/rows.csv?accessType=DOWNLOAD"
fileName <- "../TempData/bVendors.csv"
if (!file.exists(fileName)) {
  download.file(bVendorsURL,destfile = fileName,method="curl")
  if (file.exists(fileName)) {
    tam <- file.info(fileName)$size
    paste("File downloaded, ",tam," bytes")
  } else {
    "Error downloading file!"
  }
}
```

Carregando os dados do csv para o dataframe e limpanho variaveis não uteis

``` r
bVendors <- read.csv(file=fileName, header=TRUE, sep=",", stringsAsFactors=FALSE)
bVendors$Id <- NULL
bVendors$Cart_Descr <- NULL
bVendors$St <- NULL
names(bVendors)[names(bVendors) == "Location.1"] <- "location"
```

Exercicios
==========

The “hotdog” variable for the “Hot Dogs in Baltimore” example can be better defined
-----------------------------------------------------------------------------------

``` r
searchItem="Hot dog|franks"
bVendors$hotdog <- grepl(searchItem,ignore.case = TRUE, bVendors$ItemsSold)
head(subset(bVendors, select = c(ItemsSold,hotdog)))
```

    ##                                                                  ItemsSold
    ## 1                              Grilled food, pizza slices, gyro sandwiches
    ## 2                          Hot Dogs, Sausage, Snacks, Gum, Candies, Drinks
    ## 3                          Hot dogs, Sausage, drinks, snacks, gum, & candy
    ## 4                           Hot dogs, sausages, chips, snacks, drinks, gum
    ## 5 Large & Small beef franks, soft drinks, water, all types of nuts & chips
    ## 6                                                   Hot dogs, Sodas, Chips
    ##   hotdog
    ## 1  FALSE
    ## 2   TRUE
    ## 3   TRUE
    ## 4   TRUE
    ## 5   TRUE
    ## 6   TRUE

I prefer Pizza
--------------

``` r
searchItem="pizza"
bVendors$pizza <- grepl(searchItem,ignore.case = TRUE, bVendors$ItemsSold)
head(subset(bVendors, select = c(ItemsSold,pizza)))
```

    ##                                                                  ItemsSold
    ## 1                              Grilled food, pizza slices, gyro sandwiches
    ## 2                          Hot Dogs, Sausage, Snacks, Gum, Candies, Drinks
    ## 3                          Hot dogs, Sausage, drinks, snacks, gum, & candy
    ## 4                           Hot dogs, sausages, chips, snacks, drinks, gum
    ## 5 Large & Small beef franks, soft drinks, water, all types of nuts & chips
    ## 6                                                   Hot dogs, Sodas, Chips
    ##   pizza
    ## 1  TRUE
    ## 2 FALSE
    ## 3 FALSE
    ## 4 FALSE
    ## 5 FALSE
    ## 6 FALSE

Get the name of the town for the “Hot Dogs in Baltimore” example.
-----------------------------------------------------------------

### Da maneira 'fácil'

``` r
gsub(".{6}$","",unlist(strsplit(bVendors$location,"\n"))[seq(1,nrow(bVendors),2)])
```

    ##  [1] "Towson"       "Owings Mill"  "Owings Mill"  "Owings Mill" 
    ##  [5] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ##  [9] "Baltimore"    "Baltimore"    "Baltimore"    "Laurel"      
    ## [13] "Randallstown" "Baltimore"    "Baltimore"    "Baltimore"   
    ## [17] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ## [21] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ## [25] "Baltimore"    "Laurel"       "Owings Mill"  "Baltimore"   
    ## [29] "Baltimore"    "Glen Burnie"  "Baltimore"    "Middle River"
    ## [33] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ## [37] "Reisterstown" "Reisterstown" "Baltimore"

### Passo a passo:

Separa os nomes do lat-lon

``` r
splitedBVendors<-unlist(strsplit(bVendors$location,"\n"))
head(splitedBVendors)
```

    ## [1] "Towson 21204"                      "(39.28540000000, -76.62260000000)"
    ## [3] "Owings Mill 21117"                 "(39.29860000000, -76.61280000000)"
    ## [5] "Owings Mill 21117"                 "(39.28920000000, -76.62670000000)"

Pega somente os elementos nas posições ímpares (o formato está "Cidade1" "LatLon1" "Cidade2" "LatLon2" ...)

``` r
splitedBVendors=splitedBVendors[seq(1,nrow(bVendors),2)]
splitedBVendors
```

    ##  [1] "Towson 21204"       "Owings Mill 21117"  "Owings Mill 21117" 
    ##  [4] "Owings Mill 21117"  "Baltimore 21239"    "Baltimore 21244"   
    ##  [7] "Baltimore 21206"    "Baltimore 21236"    "Baltimore 21217"   
    ## [10] "Baltimore 21217"    "Baltimore 21205"    "Laurel 20723"      
    ## [13] "Randallstown 21133" "Baltimore 21224"    "Baltimore 21224"   
    ## [16] "Baltimore 21224"    "Baltimore 21212"    "Baltimore 21237"   
    ## [19] "Baltimore 21218"    "Baltimore 21218"    "Baltimore 21230"   
    ## [22] "Baltimore 21202"    "Baltimore 21202"    "Baltimore 21201"   
    ## [25] "Baltimore 21244"    "Laurel 20723"       "Owings Mill 21117" 
    ## [28] "Baltimore 21217"    "Baltimore 21224"    "Glen Burnie 21060" 
    ## [31] "Baltimore 21218"    "Middle River 21220" "Baltimore 21224"   
    ## [34] "Baltimore 21216"    "Baltimore 21230"    "Baltimore 21201"   
    ## [37] "Reisterstown 21136" "Reisterstown 21136" "Baltimore 21223"

Retira o ZIP code da string (últimos 6 caracteres)

``` r
gsub(".{6}$","",splitedBVendors)
```

    ##  [1] "Towson"       "Owings Mill"  "Owings Mill"  "Owings Mill" 
    ##  [5] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ##  [9] "Baltimore"    "Baltimore"    "Baltimore"    "Laurel"      
    ## [13] "Randallstown" "Baltimore"    "Baltimore"    "Baltimore"   
    ## [17] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ## [21] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ## [25] "Baltimore"    "Laurel"       "Owings Mill"  "Baltimore"   
    ## [29] "Baltimore"    "Glen Burnie"  "Baltimore"    "Middle River"
    ## [33] "Baltimore"    "Baltimore"    "Baltimore"    "Baltimore"   
    ## [37] "Reisterstown" "Reisterstown" "Baltimore"

Limpando a casa
===============

``` r
setwd(orig)
```
