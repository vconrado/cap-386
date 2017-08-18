Covtype Exercise
================

``` r
covtype <- read.csv(file="Data/covtype.data", header=FALSE, sep=",", stringsAsFactors=FALSE)
head(covtype,n = 2)
```

    ##     V1 V2 V3  V4 V5  V6  V7  V8  V9  V10 V11 V12 V13 V14 V15 V16 V17 V18
    ## 1 2596 51  3 258  0 510 221 232 148 6279   1   0   0   0   0   0   0   0
    ## 2 2590 56  2 212 -6 390 220 235 151 6225   1   0   0   0   0   0   0   0
    ##   V19 V20 V21 V22 V23 V24 V25 V26 V27 V28 V29 V30 V31 V32 V33 V34 V35 V36
    ## 1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
    ## 2   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
    ##   V37 V38 V39 V40 V41 V42 V43 V44 V45 V46 V47 V48 V49 V50 V51 V52 V53 V54
    ## 1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0
    ## 2   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0
    ##   V55
    ## 1   5
    ## 2   5

``` r
# "Fixed" attributes' names
names <- c("Elevation","Aspect","Slope","HorDistToHydro","VertDistToHydro",
           "HorDistRoad","Hillshade09","Hillshade12","Hillshade15",
           "HorDistFire")
# Four binary attributes for wilderness areas:
names <- c(names,"WA_RWA","WA_NWA","WA_CPWA","WA_CLPWA")
# 40 (!) binary attributes for soil types:
names <- c(names,sprintf("ST%02d",1:40))
# The cover type
names <- c(names,"Class")
# Assign these names to the attributes
names(covtype) <- names
# Let's also assign labels to the coverage types.
covtype$Class <- as.factor(covtype$Class)
levels(covtype$Class) <- c("Spruce/Fir", "Lodgepole Pine",
                           "Ponderosa Pine","Cottonwood/Willow","Aspen",
                           "Douglas-fir","Krummholz")
# How does it looks like?
str(covtype)
```

    ## 'data.frame':    581012 obs. of  55 variables:
    ##  $ Elevation      : int  2596 2590 2804 2785 2595 2579 2606 2605 2617 2612 ...
    ##  $ Aspect         : int  51 56 139 155 45 132 45 49 45 59 ...
    ##  $ Slope          : int  3 2 9 18 2 6 7 4 9 10 ...
    ##  $ HorDistToHydro : int  258 212 268 242 153 300 270 234 240 247 ...
    ##  $ VertDistToHydro: int  0 -6 65 118 -1 -15 5 7 56 11 ...
    ##  $ HorDistRoad    : int  510 390 3180 3090 391 67 633 573 666 636 ...
    ##  $ Hillshade09    : int  221 220 234 238 220 230 222 222 223 228 ...
    ##  $ Hillshade12    : int  232 235 238 238 234 237 225 230 221 219 ...
    ##  $ Hillshade15    : int  148 151 135 122 150 140 138 144 133 124 ...
    ##  $ HorDistFire    : int  6279 6225 6121 6211 6172 6031 6256 6228 6244 6230 ...
    ##  $ WA_RWA         : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ WA_NWA         : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ WA_CPWA        : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ WA_CLPWA       : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST01           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST02           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST03           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST04           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST05           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST06           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST07           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST08           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST09           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST10           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST11           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST12           : int  0 0 1 0 0 0 0 0 0 0 ...
    ##  $ ST13           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST14           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST15           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST16           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST17           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST18           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST19           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST20           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST21           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST22           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST23           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST24           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST25           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST26           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST27           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST28           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST29           : int  1 1 0 0 1 1 1 1 1 1 ...
    ##  $ ST30           : int  0 0 0 1 0 0 0 0 0 0 ...
    ##  $ ST31           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST32           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST33           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST34           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST35           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST36           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST37           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST38           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST39           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ ST40           : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ Class          : Factor w/ 7 levels "Spruce/Fir","Lodgepole Pine",..: 5 5 2 2 5 2 5 5 5 5 ...

``` r
# Which are the columns we want to consider?
searchOn <- c("WA_RWA","WA_NWA","WA_CPWA","WA_CLPWA")
# Get the index of each WA_
indexOfWA <- apply(covtype[,searchOn], 1, function(x) which(x == 1))
# Convert it to a factor with the column names we used.
factorOfWA <- factor(indexOfWA,labels = searchOn)
# Add it to the data frame
covtype$WildArea <- factorOfWA
# Drop the binary variables we don't need anymore
covtype[searchOn] <- list(NULL)
```

``` r
# Which are the columns we want to consider?
searchOn <- sprintf("ST%02d",1:40)

# Get the index of 1 in ST01..ST40
indexOfST <- apply(covtype[,searchOn], 1, function(x) which(x == 1))
# Convert it to a factor with the column names we used.
factorOfST <- factor(indexOfST,labels = searchOn)
# Add it to the data frame
covtype$SoilType <- factorOfST
# Drop the binary variables we don't need anymore
covtype[searchOn] <- list(NULL)
str(covtype)
```

    ## 'data.frame':    581012 obs. of  13 variables:
    ##  $ Elevation      : int  2596 2590 2804 2785 2595 2579 2606 2605 2617 2612 ...
    ##  $ Aspect         : int  51 56 139 155 45 132 45 49 45 59 ...
    ##  $ Slope          : int  3 2 9 18 2 6 7 4 9 10 ...
    ##  $ HorDistToHydro : int  258 212 268 242 153 300 270 234 240 247 ...
    ##  $ VertDistToHydro: int  0 -6 65 118 -1 -15 5 7 56 11 ...
    ##  $ HorDistRoad    : int  510 390 3180 3090 391 67 633 573 666 636 ...
    ##  $ Hillshade09    : int  221 220 234 238 220 230 222 222 223 228 ...
    ##  $ Hillshade12    : int  232 235 238 238 234 237 225 230 221 219 ...
    ##  $ Hillshade15    : int  148 151 135 122 150 140 138 144 133 124 ...
    ##  $ HorDistFire    : int  6279 6225 6121 6211 6172 6031 6256 6228 6244 6230 ...
    ##  $ Class          : Factor w/ 7 levels "Spruce/Fir","Lodgepole Pine",..: 5 5 2 2 5 2 5 5 5 5 ...
    ##  $ WildArea       : Factor w/ 4 levels "WA_RWA","WA_NWA",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ SoilType       : Factor w/ 40 levels "ST01","ST02",..: 29 29 12 30 29 29 29 29 29 29 ...

As descrições de tipo de solo podem ser encontradas [aqui](https://archive.ics.uci.edu/ml/machine-learning-databases/covtype/covtype.info). A tabela com esses dados foi extraída e convertida em um csv. A primeira coluna indica o SoilType e a segunda coluna o *USFS ELU Code*. No *USFS ELU Code*, o primeiro digito representa a zona climática e o segundo a zona geológica. Esses dados também estão aqui [aqui](https://archive.ics.uci.edu/ml/machine-learning-databases/covtype/covtype.info) e foram extraídos para dois arquivos climatic\_zone.csv e geologic\_zone.csv, respectivamente.

``` r
soilTypeDesc <- read.csv(file="Data/Soil_Types_Description.csv", header=FALSE, sep=",", stringsAsFactors=FALSE)
names(soilTypeDesc) <- c("SoilType","USFS_ELU_CODE")
head(soilTypeDesc, n=5)
```

    ##   SoilType USFS_ELU_CODE
    ## 1        1          2702
    ## 2        2          2703
    ## 3        3          2704
    ## 4        4          2705
    ## 5        5          2706

``` r
climaticZones  <- read.csv(file="Data/climatic_zones.csv", header=FALSE, sep=",", stringsAsFactors=TRUE)
names(climaticZones) <- c("Digit","ClimaticZone")
head(climaticZones, n=5)
```

    ##   Digit             ClimaticZone
    ## 1     1        lower montane dry
    ## 2     2            lower montane
    ## 3     3              montane dry
    ## 4     4                  montane
    ## 5     5  montane dry and montane

``` r
geologicZones  <- read.csv(file="Data/geologic_zones.csv", header=FALSE, sep=",", stringsAsFactors=TRUE)
names(geologicZones) <- c("Digit","GeologicZone")
head(geologicZones, n=5)
```

    ##   Digit       GeologicZone
    ## 1     1           alluvium
    ## 2     2            glacial
    ## 3     3              shale
    ## 4     4          sandstone
    ## 5     5  mixed sedimentary

``` r
soilTypeDesc$ClimateZone <- climaticZones$ClimaticZone[as.integer(soilTypeDesc$USFS_ELU_CODE/1000)]
soilTypeDesc$GeologicZone <- geologicZones$GeologicZone[as.integer((soilTypeDesc$USFS_ELU_CODE - as.integer(soilTypeDesc$USFS_ELU_CODE/1000)*1000)/100)
]

head(soilTypeDesc, n=5)
```

    ##   SoilType USFS_ELU_CODE    ClimateZone             GeologicZone
    ## 1        1          2702  lower montane  igneous and metamorphic
    ## 2        2          2703  lower montane  igneous and metamorphic
    ## 3        3          2704  lower montane  igneous and metamorphic
    ## 4        4          2705  lower montane  igneous and metamorphic
    ## 5        5          2706  lower montane  igneous and metamorphic

``` r
covtype$ClimateZone <- soilTypeDesc$ClimateZone[as.integer(covtype$SoilType)]

covtype$GeologicZone <- soilTypeDesc$GeologicZone[as.integer(covtype$SoilType)]

head(covtype[c(13,14,15)], n=5)
```

    ##   SoilType ClimateZone             GeologicZone
    ## 1     ST29   subalpine  igneous and metamorphic
    ## 2     ST29   subalpine  igneous and metamorphic
    ## 3     ST12     montane  igneous and metamorphic
    ## 4     ST30   subalpine  igneous and metamorphic
    ## 5     ST29   subalpine  igneous and metamorphic

``` r
str(covtype)
```

    ## 'data.frame':    581012 obs. of  15 variables:
    ##  $ Elevation      : int  2596 2590 2804 2785 2595 2579 2606 2605 2617 2612 ...
    ##  $ Aspect         : int  51 56 139 155 45 132 45 49 45 59 ...
    ##  $ Slope          : int  3 2 9 18 2 6 7 4 9 10 ...
    ##  $ HorDistToHydro : int  258 212 268 242 153 300 270 234 240 247 ...
    ##  $ VertDistToHydro: int  0 -6 65 118 -1 -15 5 7 56 11 ...
    ##  $ HorDistRoad    : int  510 390 3180 3090 391 67 633 573 666 636 ...
    ##  $ Hillshade09    : int  221 220 234 238 220 230 222 222 223 228 ...
    ##  $ Hillshade12    : int  232 235 238 238 234 237 225 230 221 219 ...
    ##  $ Hillshade15    : int  148 151 135 122 150 140 138 144 133 124 ...
    ##  $ HorDistFire    : int  6279 6225 6121 6211 6172 6031 6256 6228 6244 6230 ...
    ##  $ Class          : Factor w/ 7 levels "Spruce/Fir","Lodgepole Pine",..: 5 5 2 2 5 2 5 5 5 5 ...
    ##  $ WildArea       : Factor w/ 4 levels "WA_RWA","WA_NWA",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ SoilType       : Factor w/ 40 levels "ST01","ST02",..: 29 29 12 30 29 29 29 29 29 29 ...
    ##  $ ClimateZone    : Factor w/ 8 levels " alpine"," lower montane",..: 8 8 4 8 8 8 8 8 8 8 ...
    ##  $ GeologicZone   : Factor w/ 8 levels " alluvium"," glacial",..: 3 3 3 3 3 3 3 3 3 3 ...

Olhando os dados:

``` r
library(xtable)
tabCZ <- table(covtype$ClimateZone,covtype$WildArea)
print(xtable(tabCZ), type="html")
```

<!-- html table generated in R 3.4.1 by xtable 1.8-2 package -->
<!-- Fri Aug 18 10:55:08 2017 -->
<table border="1">
<tr>
<th>
</th>
<th>
WA\_RWA
</th>
<th>
WA\_NWA
</th>
<th>
WA\_CPWA
</th>
<th>
WA\_CLPWA
</th>
</tr>
<tr>
<td align="right">
alpine
</td>
<td align="right">
19502
</td>
<td align="right">
5599
</td>
<td align="right">
15336
</td>
<td align="right">
0
</td>
</tr>
<tr>
<td align="right">
lower montane
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
<td align="right">
18907
</td>
<td align="right">
17040
</td>
</tr>
<tr>
<td align="right">
lower montane dry
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
</tr>
<tr>
<td align="right">
montane
</td>
<td align="right">
31118
</td>
<td align="right">
255
</td>
<td align="right">
43710
</td>
<td align="right">
18510
</td>
</tr>
<tr>
<td align="right">
montane and subalpine
</td>
<td align="right">
3969
</td>
<td align="right">
187
</td>
<td align="right">
2954
</td>
<td align="right">
1056
</td>
</tr>
<tr>
<td align="right">
montane dry
</td>
<td align="right">
284
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
</tr>
<tr>
<td align="right">
montane dry and montane
</td>
<td align="right">
0
</td>
<td align="right">
0
</td>
<td align="right">
240
</td>
<td align="right">
362
</td>
</tr>
<tr>
<td align="right">
subalpine
</td>
<td align="right">
205923
</td>
<td align="right">
23843
</td>
<td align="right">
172217
</td>
<td align="right">
0
</td>
</tr>
</table>
