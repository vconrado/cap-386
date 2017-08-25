Covtype: Decision Tree
================

-   [Dados do Rafael Santos](#dados-do-rafael-santos)

Lendos os dados:

``` r
load("Data/covtype.RData")
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

Pegando uma amostra dos dados:

``` r
#install.packages("C50")
library(C50)
rows <- nrow(covtype)
covtypeSample <- covtype[sample(rows,rows/100), ]
str(covtypeSample)
```

    ## 'data.frame':    5810 obs. of  15 variables:
    ##  $ Elevation      : int  3270 2999 2208 3243 3072 3115 3055 2789 3132 2991 ...
    ##  $ Aspect         : int  286 13 132 280 221 288 25 313 114 90 ...
    ##  $ Slope          : int  9 13 31 16 35 7 7 9 10 5 ...
    ##  $ HorDistToHydro : int  335 162 216 418 524 30 216 324 210 511 ...
    ##  $ VertDistToHydro: int  86 -7 36 35 135 1 10 12 24 26 ...
    ##  $ HorDistRoad    : int  319 2161 677 1689 3745 450 1050 2160 2167 5167 ...
    ##  $ Hillshade09    : int  195 207 251 173 155 201 217 196 238 228 ...
    ##  $ Hillshade12    : int  240 213 207 240 246 240 225 233 230 231 ...
    ##  $ Hillshade15    : int  184 142 59 206 206 178 145 177 122 137 ...
    ##  $ HorDistFire    : int  1503 1106 696 488 1168 2125 1785 2496 2526 5460 ...
    ##  $ Class          : Factor w/ 7 levels "Spruce/Fir","Lodgepole Pine",..: 1 1 3 1 2 1 2 2 1 2 ...
    ##  $ WildArea       : Factor w/ 4 levels "WA_RWA","WA_NWA",..: 2 1 4 3 3 2 1 1 3 1 ...
    ##  $ SoilType       : Factor w/ 40 levels "ST01","ST02",..: 23 29 6 31 33 22 29 12 32 19 ...
    ##  $ ClimateZone    : Factor w/ 8 levels " alpine"," lower montane",..: 8 8 2 8 8 8 8 4 8 8 ...
    ##  $ GeologicZone   : Factor w/ 8 levels " alluvium"," glacial",..: 2 3 3 3 3 2 3 3 3 1 ...

Primeira árvore de decisão (Tudo):

``` r
modelCT <- C5.0(Class ~ ., data=covtypeSample, control = C5.0Control(noGlobalPruning = TRUE, minCases=1))
#plot(modelCT, main="C5.0 Decision Tree - Unpruned, min=1")
summary(modelCT)
```

    ## 
    ## Call:
    ## C5.0.formula(formula = Class ~ ., data = covtypeSample, control
    ##  = C5.0Control(noGlobalPruning = TRUE, minCases = 1))
    ## 
    ## 
    ## C5.0 [Release 2.07 GPL Edition]      Fri Aug 25 10:42:55 2017
    ## -------------------------------
    ## 
    ## Class specified by attribute `outcome'
    ## 
    ## Read 5810 cases (15 attributes) from undefined.data
    ## 
    ## Decision tree:
    ## 
    ## WildArea = WA_CLPWA:
    ## :...HorDistToHydro <= 0:
    ## :   :...Elevation <= 2384:
    ## :   :   :...HorDistRoad <= 708: Ponderosa Pine (6/2)
    ## :   :   :   HorDistRoad > 708: Cottonwood/Willow (8)
    ## :   :   Elevation > 2384:
    ## :   :   :...HorDistFire <= 967: Lodgepole Pine (3)
    ## :   :       HorDistFire > 967: Douglas-fir (2)
    ## :   HorDistToHydro > 0:
    ## :   :...Elevation > 2468:
    ## :       :...SoilType in {ST01,ST02,ST03,ST04,ST07,ST08,ST09,ST11,ST12,ST13,
    ## :       :   :            ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,ST23,
    ## :       :   :            ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,
    ## :       :   :            ST34,ST35,ST36,ST37,ST38,ST39,
    ## :       :   :            ST40}: Ponderosa Pine (3)
    ## :       :   SoilType = ST05: Douglas-fir (1)
    ## :       :   SoilType = ST06:
    ## :       :   :...HorDistFire > 1144: Ponderosa Pine (4)
    ## :       :   :   HorDistFire <= 1144:
    ## :       :   :   :...Hillshade09 > 233: Ponderosa Pine (2)
    ## :       :   :       Hillshade09 <= 233:
    ## :       :   :       :...HorDistToHydro <= 484: Lodgepole Pine (8)
    ## :       :   :           HorDistToHydro > 484: Ponderosa Pine (1)
    ## :       :   SoilType = ST10:
    ## :       :   :...Aspect <= 320:
    ## :       :       :...HorDistToHydro > 210: Ponderosa Pine (4)
    ## :       :       :   HorDistToHydro <= 210:
    ## :       :       :   :...Hillshade12 <= 192: Ponderosa Pine (1)
    ## :       :       :       Hillshade12 > 192: Lodgepole Pine (3)
    ## :       :       Aspect > 320:
    ## :       :       :...VertDistToHydro > 119: Lodgepole Pine (3)
    ## :       :           VertDistToHydro <= 119:
    ## :       :           :...Hillshade15 <= 162: Ponderosa Pine (2)
    ## :       :               Hillshade15 > 162: Douglas-fir (6)
    ## :       Elevation <= 2468:
    ## :       :...Hillshade09 > 222:
    ## :           :...HorDistFire <= 1296: Ponderosa Pine (80/14)
    ## :           :   HorDistFire > 1296:
    ## :           :   :...Hillshade09 > 249: Cottonwood/Willow (3)
    ## :           :       Hillshade09 <= 249:
    ## :           :       :...HorDistFire <= 1478: Douglas-fir (5/1)
    ## :           :           HorDistFire > 1478: Ponderosa Pine (1)
    ## :           Hillshade09 <= 222: [S1]
    ## WildArea in {WA_RWA,WA_NWA,WA_CPWA}:
    ## :...SoilType in {ST01,ST05,ST06,ST07,ST15}: Lodgepole Pine (0)
    ##     SoilType in {ST02,ST03,ST04,ST10,ST11,ST14,ST17,ST18}:
    ##     :...ClimateZone in {alpine,lower montane dry,montane dry,
    ##     :   :               subalpine}: Lodgepole Pine (0)
    ##     :   ClimateZone = montane dry and montane: Douglas-fir (3)
    ##     :   ClimateZone = lower montane:
    ##     :   :...Elevation > 2656:
    ##     :   :   :...Slope <= 7: Douglas-fir (1)
    ##     :   :   :   Slope > 7:
    ##     :   :   :   :...HorDistFire <= 1846:
    ##     :   :   :       :...Hillshade09 <= 230:
    ##     :   :   :       :   :...HorDistFire <= 582: Ponderosa Pine (1)
    ##     :   :   :       :   :   HorDistFire > 582: Lodgepole Pine (38/2)
    ##     :   :   :       :   Hillshade09 > 230:
    ##     :   :   :       :   :...Elevation <= 2865: Ponderosa Pine (3)
    ##     :   :   :       :       Elevation > 2865: Lodgepole Pine (1)
    ##     :   :   :       HorDistFire > 1846:
    ##     :   :   :       :...HorDistRoad > 2051:
    ##     :   :   :           :...VertDistToHydro <= 152: Ponderosa Pine (5)
    ##     :   :   :           :   VertDistToHydro > 152: Krummholz (1)
    ##     :   :   :           HorDistRoad <= 2051:
    ##     :   :   :           :...HorDistRoad <= 1307: Aspen (2)
    ##     :   :   :               HorDistRoad > 1307:
    ##     :   :   :               :...HorDistFire <= 2584: Lodgepole Pine (4)
    ##     :   :   :                   HorDistFire > 2584: Ponderosa Pine (1)
    ##     :   :   Elevation <= 2656:
    ##     :   :   :...Hillshade09 > 214:
    ##     :   :       :...Elevation <= 2445:
    ##     :   :       :   :...HorDistFire <= 618: Douglas-fir (2)
    ##     :   :       :   :   HorDistFire > 618: Ponderosa Pine (6/2)
    ##     :   :       :   Elevation > 2445:
    ##     :   :       :   :...HorDistToHydro > 42: Ponderosa Pine (51/1)
    ##     :   :       :       HorDistToHydro <= 42:
    ##     :   :       :       :...SoilType in {ST02,ST03,ST10,ST11,ST14,ST17,
    ##     :   :       :           :            ST18}: Ponderosa Pine (3)
    ##     :   :       :           SoilType = ST04:
    ##     :   :       :           :...VertDistToHydro <= 8: Douglas-fir (3)
    ##     :   :       :               VertDistToHydro > 8: Ponderosa Pine (1)
    ##     :   :       Hillshade09 <= 214:
    ##     :   :       :...Aspect > 305: Aspen (2)
    ##     :   :           Aspect <= 305:
    ##     :   :           :...Aspect <= 100:
    ##     :   :               :...HorDistToHydro <= 256: Douglas-fir (1)
    ##     :   :               :   HorDistToHydro > 256: Lodgepole Pine (2)
    ##     :   :               Aspect > 100:
    ##     :   :               :...SoilType in {ST04,ST10,ST11,ST14,ST17,
    ##     :   :                   :            ST18}: Ponderosa Pine (14)
    ##     :   :                   SoilType in {ST02,ST03}:
    ##     :   :                   :...Elevation > 2580: Lodgepole Pine (9/1)
    ##     :   :                       Elevation <= 2580:
    ##     :   :                       :...SoilType = ST03: Ponderosa Pine (6)
    ##     :   :                           SoilType = ST02:
    ##     :   :                           :...HorDistFire <= 949: Ponderosa Pine (2)
    ##     :   :                               HorDistFire > 949: Lodgepole Pine (2)
    ##     :   ClimateZone in {montane,montane and subalpine}:
    ##     :   :...Elevation <= 2556:
    ##     :       :...WildArea = WA_NWA: Douglas-fir (0)
    ##     :       :   WildArea = WA_RWA:
    ##     :       :   :...HorDistFire <= 5112: Lodgepole Pine (14)
    ##     :       :   :   HorDistFire > 5112: Aspen (1)
    ##     :       :   WildArea = WA_CPWA:
    ##     :       :   :...HorDistToHydro > 201:
    ##     :       :       :...SoilType in {ST02,ST03,ST04,ST14,
    ##     :       :       :   :            ST18}: Lodgepole Pine (0)
    ##     :       :       :   SoilType in {ST11,ST17}: Ponderosa Pine (2)
    ##     :       :       :   SoilType = ST10:
    ##     :       :       :   :...Elevation <= 2469: Ponderosa Pine (2)
    ##     :       :       :       Elevation > 2469: Lodgepole Pine (8)
    ##     :       :       HorDistToHydro <= 201:
    ##     :       :       :...Elevation <= 2345:
    ##     :       :           :...Aspect <= 112: Ponderosa Pine (2)
    ##     :       :           :   Aspect > 112: Lodgepole Pine (1)
    ##     :       :           Elevation > 2345:
    ##     :       :           :...HorDistFire > 579: Douglas-fir (47/12)
    ##     :       :               HorDistFire <= 579:
    ##     :       :               :...HorDistRoad <= 1064: Douglas-fir (3)
    ##     :       :                   HorDistRoad > 1064:
    ##     :       :                   :...Hillshade12 <= 235: Ponderosa Pine (4)
    ##     :       :                       Hillshade12 > 235: Douglas-fir (1)
    ##     :       Elevation > 2556:
    ##     :       :...Elevation > 2785: Lodgepole Pine (76/5)
    ##     :           Elevation <= 2785:
    ##     :           :...Elevation > 2727:
    ##     :               :...Hillshade12 > 221:
    ##     :               :   :...VertDistToHydro <= 58: Lodgepole Pine (16/8)
    ##     :               :   :   VertDistToHydro > 58:
    ##     :               :   :   :...HorDistRoad <= 2356: Douglas-fir (3)
    ##     :               :   :       HorDistRoad > 2356: Aspen (2)
    ##     :               :   Hillshade12 <= 221:
    ##     :               :   :...Hillshade09 > 199: Lodgepole Pine (21/5)
    ##     :               :       Hillshade09 <= 199:
    ##     :               :       :...HorDistFire <= 1637: Aspen (1)
    ##     :               :           HorDistFire > 1637:
    ##     :               :           :...VertDistToHydro <= 33: Spruce/Fir (3)
    ##     :               :               VertDistToHydro > 33: Douglas-fir (1)
    ##     :               Elevation <= 2727:
    ##     :               :...HorDistToHydro > 470: Ponderosa Pine (3)
    ##     :                   HorDistToHydro <= 470: [S2]
    ##     SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,ST23,ST24,ST25,
    ##     :            ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,ST34,ST35,ST36,ST37,
    ##     :            ST38,ST39,ST40}:
    ##     :...ClimateZone in {lower montane,lower montane dry,
    ##         :               montane dry and montane}: Lodgepole Pine (0)
    ##         ClimateZone = alpine:
    ##         :...WildArea = WA_RWA:
    ##         :   :...HorDistFire <= 2245:
    ##         :   :   :...Elevation > 3243: Spruce/Fir (80/1)
    ##         :   :   :   Elevation <= 3243:
    ##         :   :   :   :...HorDistRoad <= 4124: Krummholz (3)
    ##         :   :   :       HorDistRoad > 4124:
    ##         :   :   :       :...HorDistRoad <= 5290: Spruce/Fir (9)
    ##         :   :   :           HorDistRoad > 5290: Lodgepole Pine (1)
    ##         :   :   HorDistFire > 2245:
    ##         :   :   :...HorDistToHydro > 424: Spruce/Fir (21)
    ##         :   :       HorDistToHydro <= 424:
    ##         :   :       :...HorDistRoad > 3999: Krummholz (11)
    ##         :   :           HorDistRoad <= 3999:
    ##         :   :           :...SoilType in {ST35,ST37}: Krummholz (2)
    ##         :   :               SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,
    ##         :   :               :            ST21,ST22,ST23,ST24,ST25,ST26,ST27,
    ##         :   :               :            ST28,ST29,ST30,ST31,ST32,ST33,ST34,
    ##         :   :               :            ST36,ST39}: Spruce/Fir (13/1)
    ##         :   :               SoilType = ST40:
    ##         :   :               :...Hillshade09 <= 203: Spruce/Fir (2)
    ##         :   :               :   Hillshade09 > 203: Krummholz (5)
    ##         :   :               SoilType = ST38:
    ##         :   :               :...Elevation > 3311: Krummholz (4)
    ##         :   :                   Elevation <= 3311:
    ##         :   :                   :...HorDistFire <= 3333: Spruce/Fir (4)
    ##         :   :                       HorDistFire > 3333:
    ##         :   :                       :...Hillshade09 <= 189: Spruce/Fir (2)
    ##         :   :                           Hillshade09 > 189: Krummholz (2)
    ##         :   WildArea in {WA_NWA,WA_CPWA}:
    ##         :   :...WildArea = WA_NWA:
    ##         :       :...HorDistFire > 2698:
    ##         :       :   :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,
    ##         :       :   :   :            ST22,ST23,ST24,ST25,ST26,ST27,ST28,ST29,
    ##         :       :   :   :            ST30,ST31,ST32,ST33,ST34,ST35,ST36,ST37,
    ##         :       :   :   :            ST39,ST40}: Spruce/Fir (12)
    ##         :       :   :   SoilType = ST38:
    ##         :       :   :   :...Slope > 10: Lodgepole Pine (4)
    ##         :       :   :       Slope <= 10:
    ##         :       :   :       :...Slope <= 5: Lodgepole Pine (1)
    ##         :       :   :           Slope > 5: Spruce/Fir (4)
    ##         :       :   HorDistFire <= 2698:
    ##         :       :   :...Elevation <= 3300: Spruce/Fir (7/2)
    ##         :       :       Elevation > 3300:
    ##         :       :       :...Slope <= 3: Lodgepole Pine (1)
    ##         :       :           Slope > 3:
    ##         :       :           :...Hillshade12 > 212: Krummholz (23/2)
    ##         :       :               Hillshade12 <= 212:
    ##         :       :               :...Elevation <= 3435: Spruce/Fir (3)
    ##         :       :                   Elevation > 3435: Krummholz (1)
    ##         :       WildArea = WA_CPWA:
    ##         :       :...Hillshade15 <= 122: Krummholz (38/2)
    ##         :           Hillshade15 > 122:
    ##         :           :...Elevation > 3325:
    ##         :               :...HorDistFire <= 470: Spruce/Fir (5)
    ##         :               :   HorDistFire > 470: Krummholz (64/10)
    ##         :               Elevation <= 3325:
    ##         :               :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,
    ##         :                   :            ST21,ST22,ST23,ST24,ST25,ST26,ST27,
    ##         :                   :            ST28,ST29,ST30,ST31,ST32,ST33,ST34,
    ##         :                   :            ST36,ST37}: Spruce/Fir (0)
    ##         :                   SoilType = ST35: Krummholz (1)
    ##         :                   SoilType = ST40:
    ##         :                   :...Hillshade12 <= 217: Krummholz (2)
    ##         :                   :   Hillshade12 > 217: Spruce/Fir (2/1)
    ##         :                   SoilType = ST38:
    ##         :                   :...Aspect <= 16: Krummholz (2)
    ##         :                   :   Aspect > 16:
    ##         :                   :   :...HorDistRoad <= 1415: Krummholz (1)
    ##         :                   :       HorDistRoad > 1415: Spruce/Fir (8)
    ##         :                   SoilType = ST39:
    ##         :                   :...VertDistToHydro > 119: Krummholz (2)
    ##         :                       VertDistToHydro <= 119:
    ##         :                       :...Aspect > 49: Spruce/Fir (16)
    ##         :                           Aspect <= 49:
    ##         :                           :...Elevation <= 3195: Lodgepole Pine (1)
    ##         :                               Elevation > 3195: [S3]
    ##         ClimateZone in {montane,montane and subalpine,montane dry,subalpine}:
    ##         :...Elevation <= 3015: [S4]
    ##             Elevation > 3015:
    ##             :...VertDistToHydro <= -35:
    ##                 :...HorDistFire <= 1008: Spruce/Fir (3/1)
    ##                 :   HorDistFire > 1008: Lodgepole Pine (32/4)
    ##                 VertDistToHydro > -35:
    ##                 :...HorDistRoad > 5282:
    ##                     :...HorDistFire <= 1224:
    ##                     :   :...VertDistToHydro <= 54: Spruce/Fir (43/4)
    ##                     :   :   VertDistToHydro > 54: Lodgepole Pine (6)
    ##                     :   HorDistFire > 1224:
    ##                     :   :...SoilType in {ST08,ST09,ST13,ST16,ST21,ST23,ST24,
    ##                     :       :            ST25,ST26,ST27,ST28,ST30,ST31,ST32,
    ##                     :       :            ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ##                     :       :            ST40}: Lodgepole Pine (26)
    ##                     :       SoilType in {ST12,ST19,ST20,ST22,ST29}:
    ##                     :       :...HorDistRoad > 6367:
    ##                     :           :...Hillshade12 <= 247: Lodgepole Pine (24)
    ##                     :           :   Hillshade12 > 247: Spruce/Fir (1)
    ##                     :           HorDistRoad <= 6367:
    ##                     :           :...Aspect <= 29: Spruce/Fir (7)
    ##                     :               Aspect > 29: [S5]
    ##                     HorDistRoad <= 5282: [S6]
    ## 
    ## SubTree [S1]
    ## 
    ## GeologicZone in {glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Ponderosa Pine (0)
    ## GeologicZone = alluvium:
    ## :...HorDistToHydro > 42: Cottonwood/Willow (1)
    ## :   HorDistToHydro <= 42:
    ## :   :...Elevation <= 2211: Ponderosa Pine (3)
    ## :       Elevation > 2211: Douglas-fir (2)
    ## GeologicZone = igneous and metamorphic:
    ## :...Elevation <= 2302: Ponderosa Pine (129/33)
    ##     Elevation > 2302:
    ##     :...Hillshade15 <= 111: Lodgepole Pine (2)
    ##         Hillshade15 > 111:
    ##         :...VertDistToHydro > 179: Ponderosa Pine (8)
    ##             VertDistToHydro <= 179:
    ##             :...HorDistRoad <= 518:
    ##                 :...Aspect > 274: Ponderosa Pine (15/1)
    ##                 :   Aspect <= 274: [S7]
    ##                 HorDistRoad > 518:
    ##                 :...HorDistFire <= 1398:
    ##                     :...Slope <= 26: Douglas-fir (34/4)
    ##                     :   Slope > 26: Ponderosa Pine (5/1)
    ##                     HorDistFire > 1398:
    ##                     :...VertDistToHydro <= 55: Lodgepole Pine (3)
    ##                         VertDistToHydro > 55: Douglas-fir (2)
    ## 
    ## SubTree [S2]
    ## 
    ## GeologicZone in {glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone = alluvium:
    ## :...HorDistToHydro > 162:
    ## :   :...HorDistFire <= 1722: Aspen (2)
    ## :   :   HorDistFire > 1722: Spruce/Fir (1)
    ## :   HorDistToHydro <= 162:
    ## :   :...Hillshade09 <= 194: Ponderosa Pine (1)
    ## :       Hillshade09 > 194:
    ## :       :...Slope > 7: Lodgepole Pine (5)
    ## :           Slope <= 7:
    ## :           :...HorDistRoad <= 1034: Lodgepole Pine (1)
    ## :               HorDistRoad > 1034:
    ## :               :...HorDistFire <= 1527: Spruce/Fir (2)
    ## :                   HorDistFire > 1527: Douglas-fir (3)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistFire > 2784:
    ##     :...HorDistRoad <= 2170: Lodgepole Pine (7/1)
    ##     :   HorDistRoad > 2170: Spruce/Fir (2)
    ##     HorDistFire <= 2784:
    ##     :...SoilType in {ST02,ST03,ST04,ST11,ST14,ST17,
    ##         :            ST18}: Lodgepole Pine (49/7)
    ##         SoilType = ST10:
    ##         :...HorDistRoad > 1618:
    ##             :...VertDistToHydro > 32:
    ##             :   :...HorDistRoad <= 2460: Douglas-fir (10/1)
    ##             :   :   HorDistRoad > 2460: Lodgepole Pine (1)
    ##             :   VertDistToHydro <= 32:
    ##             :   :...Elevation > 2628: Lodgepole Pine (11)
    ##             :       Elevation <= 2628:
    ##             :       :...Slope <= 17: Lodgepole Pine (1)
    ##             :           Slope > 17: Douglas-fir (2)
    ##             HorDistRoad <= 1618:
    ##             :...Elevation > 2646: Lodgepole Pine (8)
    ##                 Elevation <= 2646:
    ##                 :...HorDistRoad <= 616:
    ##                     :...Hillshade15 <= 119: Douglas-fir (2)
    ##                     :   Hillshade15 > 119: Ponderosa Pine (1)
    ##                     HorDistRoad > 616:
    ##                     :...HorDistFire <= 757: Ponderosa Pine (3)
    ##                         HorDistFire > 757:
    ##                         :...Hillshade12 <= 205: Lodgepole Pine (7)
    ##                             Hillshade12 > 205:
    ##                             :...HorDistRoad <= 1168: Lodgepole Pine (1)
    ##                                 HorDistRoad > 1168: Ponderosa Pine (2)
    ## 
    ## SubTree [S3]
    ## 
    ## VertDistToHydro <= 24: Krummholz (3)
    ## VertDistToHydro > 24: Spruce/Fir (2)
    ## 
    ## SubTree [S4]
    ## 
    ## GeologicZone in {sandstone,shale,unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone in {alluvium,glacial}:
    ## :...Elevation <= 2704:
    ## :   :...Hillshade12 > 245:
    ## :   :   :...VertDistToHydro <= 16: Douglas-fir (2)
    ## :   :   :   VertDistToHydro > 16: Ponderosa Pine (1)
    ## :   :   Hillshade12 <= 245:
    ## :   :   :...WildArea in {WA_RWA,WA_NWA}: Lodgepole Pine (33/1)
    ## :   :       WildArea = WA_CPWA:
    ## :   :       :...Hillshade12 > 238: Aspen (2)
    ## :   :           Hillshade12 <= 238:
    ## :   :           :...VertDistToHydro <= 2: Lodgepole Pine (6/1)
    ## :   :               VertDistToHydro > 2: Spruce/Fir (2/1)
    ## :   Elevation > 2704:
    ## :   :...HorDistRoad <= 360:
    ## :       :...HorDistFire <= 1831: Spruce/Fir (16)
    ## :       :   HorDistFire > 1831: Lodgepole Pine (1)
    ## :       HorDistRoad > 360:
    ## :       :...SoilType in {ST08,ST09,ST12,ST13,ST24,ST25,ST26,ST27,ST28,ST29,
    ## :           :            ST30,ST31,ST32,ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ## :           :            ST40}: Lodgepole Pine (0)
    ## :           SoilType = ST21: Spruce/Fir (1)
    ## :           SoilType = ST19:
    ## :           :...Slope <= 1: Spruce/Fir (2)
    ## :           :   Slope > 1: Lodgepole Pine (8)
    ## :           SoilType = ST20:
    ## :           :...HorDistRoad <= 1269: Spruce/Fir (5/1)
    ## :           :   HorDistRoad > 1269: Lodgepole Pine (56/22)
    ## :           SoilType = ST16:
    ## :           :...VertDistToHydro > 5: Lodgepole Pine (2)
    ## :           :   VertDistToHydro <= 5:
    ## :           :   :...VertDistToHydro <= -1: Lodgepole Pine (1)
    ## :           :       VertDistToHydro > -1: Spruce/Fir (4)
    ## :           SoilType = ST22:
    ## :           :...WildArea = WA_NWA: Lodgepole Pine (5)
    ## :           :   WildArea in {WA_RWA,WA_CPWA}:
    ## :           :   :...HorDistRoad > 3893: Lodgepole Pine (3)
    ## :           :       HorDistRoad <= 3893:
    ## :           :       :...HorDistFire > 2310: Spruce/Fir (16)
    ## :           :           HorDistFire <= 2310:
    ## :           :           :...HorDistToHydro > 175: Lodgepole Pine (6)
    ## :           :               HorDistToHydro <= 175:
    ## :           :               :...VertDistToHydro <= 4: Spruce/Fir (10)
    ## :           :                   VertDistToHydro > 4:
    ## :           :                   :...HorDistToHydro <= 108: Lodgepole Pine (4)
    ## :           :                       HorDistToHydro > 108: Spruce/Fir (2)
    ## :           SoilType = ST23:
    ## :           :...HorDistToHydro > 30:
    ## :               :...HorDistRoad <= 1950:
    ## :               :   :...Hillshade12 <= 232: Lodgepole Pine (23)
    ## :               :   :   Hillshade12 > 232:
    ## :               :   :   :...HorDistRoad <= 812: Spruce/Fir (3)
    ## :               :   :       HorDistRoad > 812: Lodgepole Pine (14/3)
    ## :               :   HorDistRoad > 1950:
    ## :               :   :...WildArea = WA_NWA: Spruce/Fir (0)
    ## :               :       WildArea = WA_RWA: Lodgepole Pine (36/16)
    ## :               :       WildArea = WA_CPWA:
    ## :               :       :...Hillshade15 <= 144: Spruce/Fir (4)
    ## :               :           Hillshade15 > 144:
    ## :               :           :...VertDistToHydro <= 5: Aspen (2)
    ## :               :               VertDistToHydro > 5: Spruce/Fir (1)
    ## :               HorDistToHydro <= 30:
    ## :               :...HorDistRoad <= 1348:
    ## :                   :...Hillshade15 <= 164: Lodgepole Pine (16/4)
    ## :                   :   Hillshade15 > 164: Spruce/Fir (4)
    ## :                   HorDistRoad > 1348:
    ## :                   :...WildArea = WA_NWA: Spruce/Fir (0)
    ## :                       WildArea = WA_CPWA:
    ## :                       :...Hillshade12 <= 240: Spruce/Fir (13)
    ## :                       :   Hillshade12 > 240: Lodgepole Pine (3/1)
    ## :                       WildArea = WA_RWA:
    ## :                       :...Slope > 8:
    ## :                           :...VertDistToHydro > 4: Spruce/Fir (1)
    ## :                           :   VertDistToHydro <= 4:
    ## :                           :   :...Aspect <= 19: Spruce/Fir (1)
    ## :                           :       Aspect > 19: Lodgepole Pine (8)
    ## :                           Slope <= 8:
    ## :                           :...HorDistToHydro <= 0:
    ## :                               :...HorDistFire > 3454: Lodgepole Pine (1)
    ## :                               :   HorDistFire <= 3454:
    ## :                               :   :...HorDistRoad <= 2296: Lodgepole Pine (1)
    ## :                               :       HorDistRoad > 2296: Spruce/Fir (11)
    ## :                               HorDistToHydro > 0:
    ## :                               :...Aspect > 296: Lodgepole Pine (3)
    ## :                                   Aspect <= 296:
    ## :                                   :...HorDistFire <= 1624: Lodgepole Pine (1)
    ## :                                       HorDistFire > 1624: Spruce/Fir (9)
    ## GeologicZone in {igneous and metamorphic,mixed sedimentary}:
    ## :...HorDistRoad <= 655:
    ##     :...Elevation <= 2834:
    ##     :   :...VertDistToHydro <= -36: Spruce/Fir (2)
    ##     :   :   VertDistToHydro > -36:
    ##     :   :   :...Hillshade09 <= 234: Lodgepole Pine (46/5)
    ##     :   :       Hillshade09 > 234:
    ##     :   :       :...ClimateZone in {montane and subalpine,
    ##     :   :           :               montane dry}: Aspen (0)
    ##     :   :           ClimateZone = montane: Lodgepole Pine (4)
    ##     :   :           ClimateZone = subalpine:
    ##     :   :           :...Elevation <= 2608: Lodgepole Pine (1)
    ##     :   :               Elevation > 2608:
    ##     :   :               :...Elevation > 2800: Lodgepole Pine (1)
    ##     :   :                   Elevation <= 2800:
    ##     :   :                   :...HorDistFire <= 2506: Aspen (16)
    ##     :   :                       HorDistFire > 2506: Lodgepole Pine (1)
    ##     :   Elevation > 2834:
    ##     :   :...Aspect > 217:
    ##     :       :...HorDistRoad > 518: Spruce/Fir (8)
    ##     :       :   HorDistRoad <= 518:
    ##     :       :   :...Elevation <= 2904: Spruce/Fir (4)
    ##     :       :       Elevation > 2904: Lodgepole Pine (10/2)
    ##     :       Aspect <= 217:
    ##     :       :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,ST23,
    ##     :           :            ST25,ST26,ST27,ST28,ST31,ST34,ST35,ST36,ST37,ST38,
    ##     :           :            ST39,ST40}: Lodgepole Pine (4)
    ##     :           SoilType = ST32:
    ##     :           :...VertDistToHydro <= 40: Lodgepole Pine (5)
    ##     :           :   VertDistToHydro > 40: Spruce/Fir (2/1)
    ##     :           SoilType = ST24:
    ##     :           :...WildArea = WA_NWA: Lodgepole Pine (0)
    ##     :           :   WildArea = WA_RWA: Aspen (1)
    ##     :           :   WildArea = WA_CPWA:
    ##     :           :   :...Slope <= 17: Spruce/Fir (3)
    ##     :           :       Slope > 17: Lodgepole Pine (4)
    ##     :           SoilType = ST30:
    ##     :           :...VertDistToHydro > 160: Aspen (1)
    ##     :           :   VertDistToHydro <= 160:
    ##     :           :   :...HorDistToHydro <= 67: Spruce/Fir (1)
    ##     :           :       HorDistToHydro > 67: Lodgepole Pine (8)
    ##     :           SoilType = ST33:
    ##     :           :...HorDistToHydro <= 324: Lodgepole Pine (5)
    ##     :           :   HorDistToHydro > 324:
    ##     :           :   :...HorDistFire <= 1377: Spruce/Fir (3)
    ##     :           :       HorDistFire > 1377: Lodgepole Pine (1)
    ##     :           SoilType = ST29:
    ##     :           :...Slope <= 18:
    ##     :               :...HorDistFire <= 649: Spruce/Fir (4/1)
    ##     :               :   HorDistFire > 649:
    ##     :               :   :...Aspect <= 115: Lodgepole Pine (18)
    ##     :               :       Aspect > 115: Spruce/Fir (1)
    ##     :               Slope > 18:
    ##     :               :...Hillshade15 <= 22: Lodgepole Pine (1)
    ##     :                   Hillshade15 > 22:
    ##     :                   :...VertDistToHydro <= 56: Spruce/Fir (17/1)
    ##     :                       VertDistToHydro > 56:
    ##     :                       :...HorDistToHydro <= 240: Lodgepole Pine (4)
    ##     :                           HorDistToHydro > 240: Spruce/Fir (5/1)
    ##     HorDistRoad > 655:
    ##     :...WildArea = WA_NWA: Lodgepole Pine (0)
    ##         WildArea = WA_RWA:
    ##         :...Elevation <= 2712: Lodgepole Pine (133/1)
    ##         :   Elevation > 2712:
    ##         :   :...VertDistToHydro <= 9:
    ##         :       :...Hillshade09 > 188: Lodgepole Pine (187/49)
    ##         :       :   Hillshade09 <= 188:
    ##         :       :   :...Slope <= 19: Spruce/Fir (6/1)
    ##         :       :       Slope > 19: Lodgepole Pine (1)
    ##         :       VertDistToHydro > 9: [S8]
    ##         WildArea = WA_CPWA:
    ##         :...Elevation <= 2798:
    ##             :...SoilType in {ST08,ST09,ST12,ST16,ST19,ST20,ST21,ST22,ST23,ST25,
    ##             :   :            ST27,ST29,ST30,ST34,ST35,ST36,ST37,ST38,ST39,
    ##             :   :            ST40}: Lodgepole Pine (0)
    ##             :   SoilType = ST32:
    ##             :   :...VertDistToHydro > 61:
    ##             :   :   :...Elevation <= 2749: Aspen (2)
    ##             :   :   :   Elevation > 2749: Lodgepole Pine (3)
    ##             :   :   VertDistToHydro <= 61:
    ##             :   :   :...Hillshade09 <= 225: Douglas-fir (4)
    ##             :   :       Hillshade09 > 225:
    ##             :   :       :...Hillshade09 <= 233: Ponderosa Pine (2)
    ##             :   :           Hillshade09 > 233: Douglas-fir (1)
    ##             :   SoilType in {ST13,ST24,ST26,ST28,ST31,ST33}:
    ##             :   :...HorDistToHydro > 90: Lodgepole Pine (83/11)
    ##             :       HorDistToHydro <= 90: [S9]
    ##             Elevation > 2798:
    ##             :...HorDistFire > 2903:
    ##                 :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,
    ##                 :   :            ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST34,
    ##                 :   :            ST35,ST36,ST37,ST38,ST39,
    ##                 :   :            ST40}: Spruce/Fir (10)
    ##                 :   SoilType in {ST31,ST32,ST33}:
    ##                 :   :...Hillshade15 > 131: Spruce/Fir (4)
    ##                 :       Hillshade15 <= 131:
    ##                 :       :...Hillshade15 <= 70: Spruce/Fir (1)
    ##                 :           Hillshade15 > 70: Lodgepole Pine (10)
    ##                 HorDistFire <= 2903:
    ##                 :...Hillshade12 > 233:
    ##                     :...HorDistRoad <= 997:
    ##                     :   :...HorDistFire <= 1699: Lodgepole Pine (8)
    ##                     :   :   HorDistFire > 1699: [S10]
    ##                     :   HorDistRoad > 997: [S11]
    ##                     Hillshade12 <= 233:
    ##                     :...VertDistToHydro <= 0:
    ##                         :...Hillshade12 <= 228: Spruce/Fir (29/9)
    ##                         :   Hillshade12 > 228: Lodgepole Pine (3)
    ##                         VertDistToHydro > 0: [S12]
    ## 
    ## SubTree [S5]
    ## 
    ## SoilType in {ST19,ST29}: Lodgepole Pine (92/25)
    ## SoilType = ST20: Spruce/Fir (2)
    ## SoilType = ST12:
    ## :...Aspect <= 83: Spruce/Fir (2)
    ## :   Aspect > 83: Lodgepole Pine (4)
    ## SoilType = ST22:
    ## :...Elevation <= 3198: Lodgepole Pine (11)
    ##     Elevation > 3198: Spruce/Fir (8)
    ## 
    ## SubTree [S6]
    ## 
    ## ClimateZone = montane dry: Spruce/Fir (0)
    ## ClimateZone = montane and subalpine: Lodgepole Pine (3)
    ## ClimateZone = montane:
    ## :...HorDistFire <= 979: Lodgepole Pine (11)
    ## :   HorDistFire > 979: Spruce/Fir (25/11)
    ## ClimateZone = subalpine:
    ## :...Elevation > 3177:
    ##     :...Elevation > 3297:
    ##     :   :...WildArea = WA_NWA:
    ##     :   :   :...HorDistFire <= 1902: Spruce/Fir (25)
    ##     :   :   :   HorDistFire > 1902:
    ##     :   :   :   :...VertDistToHydro <= 12: Spruce/Fir (8)
    ##     :   :   :       VertDistToHydro > 12:
    ##     :   :   :       :...Elevation > 3388: Spruce/Fir (1)
    ##     :   :   :           Elevation <= 3388:
    ##     :   :   :           :...Hillshade09 <= 188: Spruce/Fir (1)
    ##     :   :   :               Hillshade09 > 188: Lodgepole Pine (13)
    ##     :   :   WildArea in {WA_RWA,WA_CPWA}:
    ##     :   :   :...HorDistFire > 3129:
    ##     :   :       :...Elevation <= 3308: Spruce/Fir (2/1)
    ##     :   :       :   Elevation > 3308: Krummholz (8)
    ##     :   :       HorDistFire <= 3129:
    ##     :   :       :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,
    ##     :   :           :            ST24,ST25,ST26,ST27,ST28,ST30,ST34,ST35,ST36,
    ##     :   :           :            ST37,ST38,ST39,ST40}: Spruce/Fir (8)
    ##     :   :           SoilType = ST23:
    ##     :   :           :...HorDistToHydro <= 170: Krummholz (2)
    ##     :   :           :   HorDistToHydro > 170:
    ##     :   :           :   :...VertDistToHydro <= 101: Spruce/Fir (3)
    ##     :   :           :       VertDistToHydro > 101: Lodgepole Pine (1)
    ##     :   :           SoilType = ST31:
    ##     :   :           :...Slope > 18: Lodgepole Pine (1)
    ##     :   :           :   Slope <= 18:
    ##     :   :           :   :...Aspect <= 196: Krummholz (5)
    ##     :   :           :       Aspect > 196: Spruce/Fir (5)
    ##     :   :           SoilType = ST29:
    ##     :   :           :...Slope > 12:
    ##     :   :           :   :...HorDistToHydro <= 127: Krummholz (1)
    ##     :   :           :   :   HorDistToHydro > 127: Spruce/Fir (7)
    ##     :   :           :   Slope <= 12:
    ##     :   :           :   :...Hillshade12 <= 225: Krummholz (2)
    ##     :   :           :       Hillshade12 > 225:
    ##     :   :           :       :...Elevation <= 3318: Lodgepole Pine (4)
    ##     :   :           :           Elevation > 3318: Spruce/Fir (1)
    ##     :   :           SoilType = ST33:
    ##     :   :           :...Elevation > 3408: Krummholz (1)
    ##     :   :           :   Elevation <= 3408:
    ##     :   :           :   :...Aspect > 270: Lodgepole Pine (1)
    ##     :   :           :       Aspect <= 270:
    ##     :   :           :       :...Slope <= 14: Lodgepole Pine (1)
    ##     :   :           :           Slope > 14: Spruce/Fir (13)
    ##     :   :           SoilType = ST32:
    ##     :   :           :...HorDistRoad <= 942: Krummholz (3)
    ##     :   :               HorDistRoad > 942:
    ##     :   :               :...Slope > 19:
    ##     :   :                   :...Hillshade15 <= 174: Lodgepole Pine (2)
    ##     :   :                   :   Hillshade15 > 174: Spruce/Fir (2)
    ##     :   :                   Slope <= 19:
    ##     :   :                   :...VertDistToHydro <= 131: Spruce/Fir (39)
    ##     :   :                       VertDistToHydro > 131:
    ##     :   :                       :...Aspect <= 130: Krummholz (2)
    ##     :   :                           Aspect > 130: Spruce/Fir (4)
    ##     :   Elevation <= 3297:
    ##     :   :...HorDistToHydro <= 258:
    ##     :       :...HorDistFire <= 2374: Spruce/Fir (181/26)
    ##     :       :   HorDistFire > 2374:
    ##     :       :   :...HorDistRoad <= 1341:
    ##     :       :       :...WildArea = WA_NWA: Lodgepole Pine (5)
    ##     :       :       :   WildArea = WA_RWA:
    ##     :       :       :   :...VertDistToHydro <= 35: Spruce/Fir (3)
    ##     :       :       :   :   VertDistToHydro > 35: Lodgepole Pine (1)
    ##     :       :       :   WildArea = WA_CPWA:
    ##     :       :       :   :...Hillshade09 <= 210: Spruce/Fir (1)
    ##     :       :       :       Hillshade09 > 210: Lodgepole Pine (2)
    ##     :       :       HorDistRoad > 1341:
    ##     :       :       :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,
    ##     :       :           :            ST25,ST26,ST27,ST28,ST31,ST32,ST33,ST34,
    ##     :       :           :            ST35,ST36,ST37,ST38,ST39,
    ##     :       :           :            ST40}: Spruce/Fir (10/1)
    ##     :       :           SoilType = ST24:
    ##     :       :           :...HorDistFire <= 2938: Spruce/Fir (5)
    ##     :       :           :   HorDistFire > 2938: Lodgepole Pine (5)
    ##     :       :           SoilType = ST30:
    ##     :       :           :...Slope <= 15: Spruce/Fir (4)
    ##     :       :           :   Slope > 15: Lodgepole Pine (2/1)
    ##     :       :           SoilType = ST22:
    ##     :       :           :...HorDistToHydro > 0: Spruce/Fir (19)
    ##     :       :           :   HorDistToHydro <= 0:
    ##     :       :           :   :...WildArea = WA_RWA: Spruce/Fir (1)
    ##     :       :           :       WildArea in {WA_NWA,WA_CPWA}: Krummholz (2)
    ##     :       :           SoilType = ST23:
    ##     :       :           :...HorDistRoad <= 1819: Lodgepole Pine (1)
    ##     :       :           :   HorDistRoad > 1819:
    ##     :       :           :   :...Hillshade09 <= 210: Krummholz (4/1)
    ##     :       :           :       Hillshade09 > 210: Spruce/Fir (15)
    ##     :       :           SoilType = ST29:
    ##     :       :           :...Hillshade12 > 246:
    ##     :       :               :...Hillshade09 <= 192: Spruce/Fir (1)
    ##     :       :               :   Hillshade09 > 192: Krummholz (4)
    ##     :       :               Hillshade12 <= 246:
    ##     :       :               :...HorDistToHydro > 60: Spruce/Fir (20)
    ##     :       :                   HorDistToHydro <= 60:
    ##     :       :                   :...Slope > 12: Spruce/Fir (3)
    ##     :       :                       Slope <= 12:
    ##     :       :                       :...HorDistRoad <= 2537: Lodgepole Pine (2)
    ##     :       :                           HorDistRoad > 2537: Krummholz (2)
    ##     :       HorDistToHydro > 258:
    ##     :       :...Hillshade15 <= 61:
    ##     :           :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,
    ##     :           :   :            ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST31,ST32,
    ##     :           :   :            ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ##     :           :   :            ST40}: Spruce/Fir (6)
    ##     :           :   SoilType = ST30:
    ##     :           :   :...HorDistFire <= 1897: Spruce/Fir (1)
    ##     :           :       HorDistFire > 1897: Krummholz (2)
    ##     :           Hillshade15 > 61:
    ##     :           :...Hillshade09 > 233:
    ##     :               :...HorDistFire > 4924: Spruce/Fir (4)
    ##     :               :   HorDistFire <= 4924:
    ##     :               :   :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,
    ##     :               :       :            ST21,ST24,ST26,ST27,ST28,ST30,ST34,
    ##     :               :       :            ST35,ST36,ST37,ST38,ST39,
    ##     :               :       :            ST40}: Lodgepole Pine (1)
    ##     :               :       SoilType = ST31: Spruce/Fir (1)
    ##     :               :       SoilType = ST22:
    ##     :               :       :...Hillshade09 <= 237: Spruce/Fir (1)
    ##     :               :       :   Hillshade09 > 237: Lodgepole Pine (5)
    ##     :               :       SoilType = ST23:
    ##     :               :       :...HorDistFire <= 2467: Lodgepole Pine (5)
    ##     :               :       :   HorDistFire > 2467: Spruce/Fir (1)
    ##     :               :       SoilType = ST25:
    ##     :               :       :...HorDistFire <= 3660: Spruce/Fir (1)
    ##     :               :       :   HorDistFire > 3660: Lodgepole Pine (2)
    ##     :               :       SoilType = ST32:
    ##     :               :       :...Hillshade09 <= 236: Spruce/Fir (2)
    ##     :               :       :   Hillshade09 > 236: Lodgepole Pine (10)
    ##     :               :       SoilType = ST29:
    ##     :               :       :...VertDistToHydro > 124: Lodgepole Pine (3)
    ##     :               :       :   VertDistToHydro <= 124:
    ##     :               :       :   :...Aspect <= 149: Spruce/Fir (8)
    ##     :               :       :       Aspect > 149: Lodgepole Pine (1)
    ##     :               :       SoilType = ST33:
    ##     :               :       :...Elevation <= 3218: Lodgepole Pine (3)
    ##     :               :           Elevation > 3218:
    ##     :               :           :...Elevation > 3282: Lodgepole Pine (2)
    ##     :               :               Elevation <= 3282: [S13]
    ##     :               Hillshade09 <= 233:
    ##     :               :...HorDistFire <= 582: Spruce/Fir (23)
    ##     :                   HorDistFire > 582:
    ##     :                   :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,
    ##     :                       :            ST21,ST25,ST26,ST28,ST30,ST31,ST34,
    ##     :                       :            ST35,ST36,ST37,ST38,ST39,
    ##     :                       :            ST40}: Spruce/Fir (54/8)
    ##     :                       SoilType = ST27: Lodgepole Pine (3/1)
    ##     :                       SoilType = ST22:
    ##     :                       :...HorDistRoad <= 4839: Spruce/Fir (22)
    ##     :                       :   HorDistRoad > 4839: Lodgepole Pine (2)
    ##     :                       SoilType = ST32:
    ##     :                       :...Hillshade12 <= 195: Krummholz (1)
    ##     :                       :   Hillshade12 > 195: Spruce/Fir (56/28)
    ##     :                       SoilType = ST24:
    ##     :                       :...WildArea = WA_RWA: Spruce/Fir (0)
    ##     :                       :   WildArea = WA_NWA: Lodgepole Pine (1)
    ##     :                       :   WildArea = WA_CPWA:
    ##     :                       :   :...HorDistFire <= 2635: Spruce/Fir (18)
    ##     :                       :       HorDistFire > 2635:
    ##     :                       :       :...Hillshade09 <= 169: Spruce/Fir (3)
    ##     :                       :           Hillshade09 > 169: Lodgepole Pine (3)
    ##     :                       SoilType = ST23:
    ##     :                       :...VertDistToHydro <= 2: Lodgepole Pine (5)
    ##     :                       :   VertDistToHydro > 2:
    ##     :                       :   :...Aspect <= 21:
    ##     :                       :       :...HorDistRoad <= 2624: Lodgepole Pine (5)
    ##     :                       :       :   HorDistRoad > 2624: Spruce/Fir (3)
    ##     :                       :       Aspect > 21:
    ##     :                       :       :...Hillshade12 <= 196: Lodgepole Pine (1)
    ##     :                       :           Hillshade12 > 196:
    ##     :                       :           :...Hillshade12 <= 250: Spruce/Fir (27)
    ##     :                       :               Hillshade12 > 250: Krummholz (1)
    ##     :                       SoilType = ST33:
    ##     :                       :...Hillshade15 <= 124: Spruce/Fir (9)
    ##     :                       :   Hillshade15 > 124:
    ##     :                       :   :...Slope > 23: Spruce/Fir (6)
    ##     :                       :       Slope <= 23:
    ##     :                       :       :...VertDistToHydro <= 56: Spruce/Fir (6)
    ##     :                       :           VertDistToHydro > 56: [S14]
    ##     :                       SoilType = ST29:
    ##     :                       :...HorDistFire > 2385: Spruce/Fir (19/1)
    ##     :                           HorDistFire <= 2385:
    ##     :                           :...HorDistToHydro > 558: Spruce/Fir (5)
    ##     :                               HorDistToHydro <= 558:
    ##     :                               :...Elevation > 3240: Lodgepole Pine (7)
    ##     :                                   Elevation <= 3240: [S15]
    ##     Elevation <= 3177:
    ##     :...HorDistToHydro <= 60:
    ##         :...Hillshade12 <= 245: Spruce/Fir (171/21)
    ##         :   Hillshade12 > 245:
    ##         :   :...HorDistRoad <= 2103: Spruce/Fir (2)
    ##         :       HorDistRoad > 2103: [S16]
    ##         HorDistToHydro > 60:
    ##         :...HorDistToHydro > 957: Lodgepole Pine (17)
    ##             HorDistToHydro <= 957:
    ##             :...Hillshade12 <= 196: Spruce/Fir (83/14)
    ##                 Hillshade12 > 196: [S17]
    ## 
    ## SubTree [S7]
    ## 
    ## ClimateZone = lower montane: Lodgepole Pine (2/1)
    ## ClimateZone in {alpine,lower montane dry,montane,montane and subalpine,
    ##                 montane dry,montane dry and montane,
    ##                 subalpine}: Douglas-fir (4)
    ## 
    ## SubTree [S8]
    ## 
    ## ClimateZone in {montane and subalpine,montane dry}: Lodgepole Pine (0)
    ## ClimateZone = montane:
    ## :...HorDistFire <= 6514: Lodgepole Pine (196/10)
    ## :   HorDistFire > 6514:
    ## :   :...Aspect <= 171: Spruce/Fir (3)
    ## :       Aspect > 171: Lodgepole Pine (1)
    ## ClimateZone = subalpine:
    ## :...Aspect > 42: Lodgepole Pine (395/38)
    ##     Aspect <= 42:
    ##     :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,ST23,ST24,
    ##         :            ST25,ST26,ST27,ST28,ST31,ST32,ST33,ST34,ST35,ST36,ST37,
    ##         :            ST38,ST39,ST40}: Lodgepole Pine (2)
    ##         SoilType = ST30: Spruce/Fir (1)
    ##         SoilType = ST29:
    ##         :...HorDistFire <= 2822:
    ##             :...VertDistToHydro <= 16: Spruce/Fir (2)
    ##             :   VertDistToHydro > 16: Lodgepole Pine (43/3)
    ##             HorDistFire > 2822:
    ##             :...Elevation <= 2877:
    ##                 :...Elevation <= 2771: Spruce/Fir (1)
    ##                 :   Elevation > 2771: Lodgepole Pine (11)
    ##                 Elevation > 2877:
    ##                 :...Hillshade15 <= 147: Spruce/Fir (13)
    ##                     Hillshade15 > 147: Lodgepole Pine (8/2)
    ## 
    ## SubTree [S9]
    ## 
    ## ClimateZone in {montane and subalpine,montane dry}: Lodgepole Pine (0)
    ## ClimateZone = montane:
    ## :...Aspect > 250: Spruce/Fir (3)
    ## :   Aspect <= 250:
    ## :   :...Aspect <= 38: Douglas-fir (1)
    ## :       Aspect > 38: Lodgepole Pine (12/1)
    ## ClimateZone = subalpine:
    ## :...Elevation > 2785:
    ##     :...SoilType = ST24: Lodgepole Pine (1)
    ##     :   SoilType in {ST13,ST26,ST28,ST31,ST33}: Aspen (4)
    ##     Elevation <= 2785:
    ##     :...Hillshade12 <= 238: Lodgepole Pine (38/13)
    ##         Hillshade12 > 238:
    ##         :...VertDistToHydro <= 10: Aspen (3)
    ##             VertDistToHydro > 10: Lodgepole Pine (3)
    ## 
    ## SubTree [S10]
    ## 
    ## ClimateZone in {montane and subalpine,montane dry}: Aspen (0)
    ## ClimateZone = montane: Spruce/Fir (3/1)
    ## ClimateZone = subalpine:
    ## :...Hillshade12 <= 240: Lodgepole Pine (2)
    ##     Hillshade12 > 240: Aspen (3)
    ## 
    ## SubTree [S11]
    ## 
    ## ClimateZone in {montane and subalpine,montane dry}: Lodgepole Pine (0)
    ## ClimateZone = subalpine:
    ## :...Elevation <= 2822: Spruce/Fir (1)
    ## :   Elevation > 2822: Lodgepole Pine (106/4)
    ## ClimateZone = montane:
    ## :...Hillshade15 <= 124: Aspen (1)
    ##     Hillshade15 > 124:
    ##     :...Elevation <= 2961: Lodgepole Pine (37/1)
    ##         Elevation > 2961:
    ##         :...Hillshade12 <= 249: Spruce/Fir (7/2)
    ##             Hillshade12 > 249: Lodgepole Pine (5)
    ## 
    ## SubTree [S12]
    ## 
    ## ClimateZone in {montane,montane and subalpine,
    ## :               montane dry}: Lodgepole Pine (24/4)
    ## ClimateZone = subalpine:
    ## :...Hillshade09 <= 148:
    ##     :...HorDistFire > 2210: Lodgepole Pine (3)
    ##     :   HorDistFire <= 2210:
    ##     :   :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,ST23,
    ##     :       :            ST24,ST25,ST26,ST27,ST29,ST30,ST31,ST32,ST34,ST35,
    ##     :       :            ST36,ST37,ST38,ST39,ST40}: Spruce/Fir (0)
    ##     :       SoilType = ST28: Lodgepole Pine (1)
    ##     :       SoilType = ST33:
    ##     :       :...HorDistToHydro <= 108: Lodgepole Pine (2)
    ##     :           HorDistToHydro > 108: Spruce/Fir (14/2)
    ##     Hillshade09 > 148:
    ##     :...HorDistRoad <= 2075: Lodgepole Pine (175/23)
    ##         HorDistRoad > 2075:
    ##         :...Hillshade15 <= 98:
    ##             :...Hillshade12 <= 206: Spruce/Fir (8)
    ##             :   Hillshade12 > 206: Lodgepole Pine (1)
    ##             Hillshade15 > 98:
    ##             :...HorDistToHydro > 175: Lodgepole Pine (58/9)
    ##                 HorDistToHydro <= 175:
    ##                 :...HorDistFire <= 1252: Lodgepole Pine (5)
    ##                     HorDistFire > 1252: Spruce/Fir (20/6)
    ## 
    ## SubTree [S13]
    ## 
    ## VertDistToHydro <= 69: Lodgepole Pine (1)
    ## VertDistToHydro > 69: Spruce/Fir (6)
    ## 
    ## SubTree [S14]
    ## 
    ## HorDistToHydro > 404: Lodgepole Pine (15)
    ## HorDistToHydro <= 404:
    ## :...Hillshade12 <= 240: Lodgepole Pine (3)
    ##     Hillshade12 > 240: Spruce/Fir (3)
    ## 
    ## SubTree [S15]
    ## 
    ## VertDistToHydro <= 20: Lodgepole Pine (6)
    ## VertDistToHydro > 20:
    ## :...Hillshade12 > 227: Spruce/Fir (7)
    ##     Hillshade12 <= 227:
    ##     :...HorDistToHydro <= 324: Spruce/Fir (3)
    ##         HorDistToHydro > 324: Lodgepole Pine (3)
    ## 
    ## SubTree [S16]
    ## 
    ## GeologicZone in {alluvium,glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (4)
    ## GeologicZone = igneous and metamorphic: Spruce/Fir (2/1)
    ## 
    ## SubTree [S17]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Spruce/Fir (0)
    ## GeologicZone in {alluvium,glacial}:
    ## :...HorDistRoad > 1101: Spruce/Fir (154/18)
    ## :   HorDistRoad <= 1101:
    ## :   :...HorDistToHydro > 450: Lodgepole Pine (10)
    ## :       HorDistToHydro <= 450:
    ## :       :...WildArea = WA_RWA:
    ## :           :...Hillshade12 <= 223: Lodgepole Pine (9)
    ## :           :   Hillshade12 > 223:
    ## :           :   :...Hillshade09 <= 242: Spruce/Fir (23)
    ## :           :       Hillshade09 > 242: Lodgepole Pine (3)
    ## :           WildArea = WA_CPWA:
    ## :           :...HorDistRoad > 875: Spruce/Fir (6)
    ## :           :   HorDistRoad <= 875:
    ## :           :   :...Aspect <= 292: Lodgepole Pine (14)
    ## :           :       Aspect > 292: Spruce/Fir (3)
    ## :           WildArea = WA_NWA:
    ## :           :...Elevation <= 3070: Lodgepole Pine (9)
    ## :               Elevation > 3070:
    ## :               :...Hillshade09 > 239: Lodgepole Pine (4)
    ## :                   Hillshade09 <= 239:
    ## :                   :...Hillshade12 > 239: Lodgepole Pine (3)
    ## :                       Hillshade12 <= 239:
    ## :                       :...Elevation <= 3170: Spruce/Fir (22)
    ## :                           Elevation > 3170:
    ## :                           :...Hillshade09 <= 223: Lodgepole Pine (2)
    ## :                               Hillshade09 > 223: Spruce/Fir (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistFire > 3104:
    ##     :...Elevation > 3056: Spruce/Fir (70/9)
    ##     :   Elevation <= 3056:
    ##     :   :...Slope <= 11:
    ##     :       :...WildArea in {WA_RWA,WA_NWA}: Spruce/Fir (9)
    ##     :       :   WildArea = WA_CPWA: Lodgepole Pine (1)
    ##     :       Slope > 11:
    ##     :       :...HorDistRoad <= 4267: Lodgepole Pine (10)
    ##     :           HorDistRoad > 4267: Spruce/Fir (2)
    ##     HorDistFire <= 3104:
    ##     :...Elevation <= 3053:
    ##         :...Hillshade09 <= 163: Spruce/Fir (3)
    ##         :   Hillshade09 > 163: Lodgepole Pine (123/31)
    ##         Elevation > 3053:
    ##         :...SoilType in {ST08,ST09,ST12,ST13,ST16,ST19,ST20,ST21,ST22,ST23,
    ##             :            ST25,ST26,ST28,ST34,ST35,ST36,ST37,ST38,ST39,
    ##             :            ST40}: Lodgepole Pine (0)
    ##             SoilType = ST27:
    ##             :...HorDistRoad <= 1559: Lodgepole Pine (2)
    ##             :   HorDistRoad > 1559: Spruce/Fir (4)
    ##             SoilType = ST31:
    ##             :...HorDistRoad <= 395: Lodgepole Pine (4)
    ##             :   HorDistRoad > 395:
    ##             :   :...Hillshade12 <= 244: Spruce/Fir (26/3)
    ##             :       Hillshade12 > 244:
    ##             :       :...VertDistToHydro <= 4: Spruce/Fir (1)
    ##             :           VertDistToHydro > 4: Lodgepole Pine (5)
    ##             SoilType = ST32:
    ##             :...HorDistFire <= 2236: Lodgepole Pine (101/32)
    ##             :   HorDistFire > 2236:
    ##             :   :...VertDistToHydro <= 23: Lodgepole Pine (8)
    ##             :       VertDistToHydro > 23:
    ##             :       :...HorDistFire <= 2785: Spruce/Fir (26)
    ##             :           HorDistFire > 2785: Lodgepole Pine (4)
    ##             SoilType = ST24:
    ##             :...HorDistRoad <= 990: Lodgepole Pine (6)
    ##             :   HorDistRoad > 990:
    ##             :   :...HorDistRoad <= 2558: Spruce/Fir (18/3)
    ##             :       HorDistRoad > 2558:
    ##             :       :...HorDistToHydro > 451: Lodgepole Pine (4)
    ##             :           HorDistToHydro <= 451:
    ##             :           :...Hillshade09 <= 237: Spruce/Fir (8)
    ##             :               Hillshade09 > 237: Lodgepole Pine (1)
    ##             SoilType = ST30:
    ##             :...HorDistFire <= 579: Lodgepole Pine (5)
    ##             :   HorDistFire > 579:
    ##             :   :...VertDistToHydro > 95: Lodgepole Pine (2)
    ##             :       VertDistToHydro <= 95:
    ##             :       :...HorDistFire > 1452: Spruce/Fir (15)
    ##             :           HorDistFire <= 1452:
    ##             :           :...HorDistRoad <= 4657: Lodgepole Pine (3)
    ##             :               HorDistRoad > 4657: Spruce/Fir (4)
    ##             SoilType = ST33:
    ##             :...Elevation <= 3064: Spruce/Fir (8)
    ##             :   Elevation > 3064:
    ##             :   :...HorDistFire > 2195:
    ##             :       :...Hillshade12 <= 207: Lodgepole Pine (2)
    ##             :       :   Hillshade12 > 207:
    ##             :       :   :...Elevation <= 3162: Spruce/Fir (10)
    ##             :       :       Elevation > 3162: Lodgepole Pine (1)
    ##             :       HorDistFire <= 2195:
    ##             :       :...HorDistFire > 1574: Lodgepole Pine (16)
    ##             :           HorDistFire <= 1574:
    ##             :           :...Hillshade12 <= 212: Spruce/Fir (4)
    ##             :               Hillshade12 > 212:
    ##             :               :...HorDistToHydro > 218: Lodgepole Pine (11)
    ##             :                   HorDistToHydro <= 218:
    ##             :                   :...HorDistRoad <= 1754: Lodgepole Pine (2)
    ##             :                       HorDistRoad > 1754: Spruce/Fir (3)
    ##             SoilType = ST29:
    ##             :...Aspect <= 128:
    ##                 :...Elevation <= 3156:
    ##                 :   :...HorDistRoad <= 895: Spruce/Fir (4)
    ##                 :   :   HorDistRoad > 895: Lodgepole Pine (83/24)
    ##                 :   Elevation > 3156:
    ##                 :   :...Hillshade15 <= 83: Lodgepole Pine (1)
    ##                 :       Hillshade15 > 83:
    ##                 :       :...HorDistFire <= 1075: Lodgepole Pine (1)
    ##                 :           HorDistFire > 1075: Spruce/Fir (13)
    ##                 Aspect > 128:
    ##                 :...HorDistFire > 2661:
    ##                     :...Elevation <= 3119: Lodgepole Pine (4)
    ##                     :   Elevation > 3119:
    ##                     :   :...Hillshade09 <= 198: Spruce/Fir (1)
    ##                     :       Hillshade09 > 198: Krummholz (2)
    ##                     HorDistFire <= 2661:
    ##                     :...Aspect <= 240: Spruce/Fir (19/2)
    ##                         Aspect > 240:
    ##                         :...Aspect <= 296: Lodgepole Pine (5)
    ##                             Aspect > 296:
    ##                             :...VertDistToHydro <= 21: Spruce/Fir (8)
    ##                                 VertDistToHydro > 21:
    ##                                 :...Hillshade09 > 198: Lodgepole Pine (5)
    ##                                     Hillshade09 <= 198:
    ##                                     :...HorDistFire <= 819: Lodgepole Pine (3)
    ##                                         HorDistFire > 819: Spruce/Fir (9)
    ## 
    ## 
    ## Evaluation on training data (5810 cases):
    ## 
    ##      Decision Tree   
    ##    ----------------  
    ##    Size      Errors  
    ## 
    ##     456  643(11.1%)   <<
    ## 
    ## 
    ##     (a)   (b)   (c)   (d)   (e)   (f)   (g)    <-classified as
    ##    ----  ----  ----  ----  ----  ----  ----
    ##    1795   326                            14    (a): class Spruce/Fir
    ##     174  2669     2                11     1    (b): class Lodgepole Pine
    ##            10   326                 7          (c): class Ponderosa Pine
    ##                  10    12                      (d): class Cottonwood/Willow
    ##       2    25                45                (e): class Aspen
    ##       2    10    42               128          (f): class Douglas-fir
    ##       6     1                           192    (g): class Krummholz
    ## 
    ## 
    ##  Attribute usage:
    ## 
    ##  100.00% WildArea
    ##   98.00% Elevation
    ##   94.53% SoilType
    ##   93.98% ClimateZone
    ##   81.76% HorDistRoad
    ##   67.59% VertDistToHydro
    ##   60.40% GeologicZone
    ##   59.41% HorDistFire
    ##   52.39% HorDistToHydro
    ##   36.71% Hillshade12
    ##   29.16% Hillshade09
    ##   19.28% Aspect
    ##   14.97% Hillshade15
    ##    7.13% Slope
    ## 
    ## 
    ## Time: 0.1 secs

Sem o SoilType:

``` r
covtypeSampleWithoutSoilType <- covtypeSample
covtypeSampleWithoutSoilType$SoilType <- NULL
modelCT <- C5.0(Class ~ ., data=covtypeSampleWithoutSoilType, control = C5.0Control(noGlobalPruning = TRUE, minCases=1))
#plot(modelCT50, main="C5.0 Decision Tree - Unpruned, min=1")
summary(modelCT)
```

    ## 
    ## Call:
    ## C5.0.formula(formula = Class ~ ., data =
    ##  covtypeSampleWithoutSoilType, control = C5.0Control(noGlobalPruning
    ##  = TRUE, minCases = 1))
    ## 
    ## 
    ## C5.0 [Release 2.07 GPL Edition]      Fri Aug 25 10:42:56 2017
    ## -------------------------------
    ## 
    ## Class specified by attribute `outcome'
    ## 
    ## Read 5810 cases (14 attributes) from undefined.data
    ## 
    ## Decision tree:
    ## 
    ## WildArea = WA_CLPWA:
    ## :...HorDistToHydro <= 0:
    ## :   :...Elevation > 2384:
    ## :   :   :...HorDistFire <= 967: Lodgepole Pine (3)
    ## :   :   :   HorDistFire > 967: Douglas-fir (2)
    ## :   :   Elevation <= 2384:
    ## :   :   :...HorDistRoad > 708: Cottonwood/Willow (8)
    ## :   :       HorDistRoad <= 708: [S1]
    ## :   HorDistToHydro > 0:
    ## :   :...Elevation > 2468:
    ## :       :...Hillshade09 <= 169:
    ## :       :   :...Hillshade15 <= 190: Douglas-fir (4)
    ## :       :   :   Hillshade15 > 190: Lodgepole Pine (2)
    ## :       :   Hillshade09 > 169:
    ## :       :   :...HorDistFire > 1537:
    ## :       :       :...HorDistFire <= 1764: Douglas-fir (3)
    ## :       :       :   HorDistFire > 1764: Ponderosa Pine (5)
    ## :       :       HorDistFire <= 1537:
    ## :       :       :...HorDistToHydro > 421: Ponderosa Pine (6)
    ## :       :           HorDistToHydro <= 421:
    ## :       :           :...Hillshade15 <= 104: Ponderosa Pine (4)
    ## :       :               Hillshade15 > 104:
    ## :       :               :...Hillshade09 > 180: Lodgepole Pine (11)
    ## :       :                   Hillshade09 <= 180: [S2]
    ## :       Elevation <= 2468:
    ## :       :...Hillshade09 > 222:
    ## :           :...HorDistFire <= 1296:
    ## :           :   :...Elevation > 2302: Ponderosa Pine (43/2)
    ## :           :   :   Elevation <= 2302:
    ## :           :   :   :...HorDistFire <= 934: Ponderosa Pine (33/8)
    ## :           :   :       HorDistFire > 934:
    ## :           :   :       :...Hillshade12 <= 210: Douglas-fir (2)
    ## :           :   :           Hillshade12 > 210: Cottonwood/Willow (2)
    ## :           :   HorDistFire > 1296:
    ## :           :   :...Hillshade09 > 249: Cottonwood/Willow (3)
    ## :           :       Hillshade09 <= 249:
    ## :           :       :...Aspect > 104: Douglas-fir (3)
    ## :           :           Aspect <= 104:
    ## :           :           :...Elevation <= 2433: Ponderosa Pine (2)
    ## :           :               Elevation > 2433: Douglas-fir (1)
    ## :           Hillshade09 <= 222: [S3]
    ## WildArea in {WA_RWA,WA_NWA,WA_CPWA}:
    ## :...ClimateZone = lower montane dry: Lodgepole Pine (0)
    ##     ClimateZone = lower montane:
    ##     :...Elevation <= 2656:
    ##     :   :...Hillshade09 > 214: Ponderosa Pine (66/8)
    ##     :   :   Hillshade09 <= 214:
    ##     :   :   :...Aspect > 305: Aspen (2)
    ##     :   :       Aspect <= 305:
    ##     :   :       :...Aspect <= 100:
    ##     :   :           :...HorDistToHydro <= 256: Douglas-fir (1)
    ##     :   :           :   HorDistToHydro > 256: Lodgepole Pine (2)
    ##     :   :           Aspect > 100:
    ##     :   :           :...HorDistRoad <= 582: Lodgepole Pine (4)
    ##     :   :               HorDistRoad > 582:
    ##     :   :               :...HorDistFire <= 1403: Ponderosa Pine (26/3)
    ##     :   :                   HorDistFire > 1403: Lodgepole Pine (3)
    ##     :   Elevation > 2656:
    ##     :   :...Slope <= 7: Douglas-fir (1)
    ##     :       Slope > 7:
    ##     :       :...HorDistFire <= 1846:
    ##     :           :...Hillshade09 <= 230:
    ##     :           :   :...HorDistFire <= 582: Ponderosa Pine (1)
    ##     :           :   :   HorDistFire > 582: Lodgepole Pine (38/2)
    ##     :           :   Hillshade09 > 230:
    ##     :           :   :...Elevation <= 2865: Ponderosa Pine (3)
    ##     :           :       Elevation > 2865: Lodgepole Pine (1)
    ##     :           HorDistFire > 1846:
    ##     :           :...HorDistRoad > 2051:
    ##     :               :...VertDistToHydro <= 152: Ponderosa Pine (5)
    ##     :               :   VertDistToHydro > 152: Krummholz (1)
    ##     :               HorDistRoad <= 2051:
    ##     :               :...HorDistRoad <= 1307: Aspen (2)
    ##     :                   HorDistRoad > 1307:
    ##     :                   :...HorDistFire <= 2584: Lodgepole Pine (4)
    ##     :                       HorDistFire > 2584: Ponderosa Pine (1)
    ##     ClimateZone = alpine:
    ##     :...WildArea = WA_RWA:
    ##     :   :...HorDistFire <= 2245:
    ##     :   :   :...Elevation > 3243: Spruce/Fir (80/1)
    ##     :   :   :   Elevation <= 3243:
    ##     :   :   :   :...HorDistRoad <= 4124: Krummholz (3)
    ##     :   :   :       HorDistRoad > 4124:
    ##     :   :   :       :...HorDistRoad <= 5290: Spruce/Fir (9)
    ##     :   :   :           HorDistRoad > 5290: Lodgepole Pine (1)
    ##     :   :   HorDistFire > 2245:
    ##     :   :   :...HorDistToHydro > 424: Spruce/Fir (21)
    ##     :   :       HorDistToHydro <= 424:
    ##     :   :       :...HorDistRoad > 3999: Krummholz (11)
    ##     :   :           HorDistRoad <= 3999:
    ##     :   :           :...Elevation <= 3318:
    ##     :   :               :...HorDistFire <= 3333: Spruce/Fir (15/1)
    ##     :   :               :   HorDistFire > 3333:
    ##     :   :               :   :...Hillshade09 <= 189: Spruce/Fir (2)
    ##     :   :               :       Hillshade09 > 189: Krummholz (2)
    ##     :   :               Elevation > 3318:
    ##     :   :               :...Hillshade09 <= 187: Spruce/Fir (3)
    ##     :   :                   Hillshade09 > 187:
    ##     :   :                   :...HorDistRoad <= 1795: Spruce/Fir (1)
    ##     :   :                       HorDistRoad > 1795: Krummholz (11)
    ##     :   WildArea in {WA_NWA,WA_CPWA}:
    ##     :   :...WildArea = WA_NWA:
    ##     :       :...HorDistFire > 2698: Spruce/Fir (21/5)
    ##     :       :   HorDistFire <= 2698:
    ##     :       :   :...Elevation <= 3300: Spruce/Fir (7/2)
    ##     :       :       Elevation > 3300:
    ##     :       :       :...Slope <= 3: Lodgepole Pine (1)
    ##     :       :           Slope > 3:
    ##     :       :           :...Hillshade12 > 212: Krummholz (23/2)
    ##     :       :               Hillshade12 <= 212:
    ##     :       :               :...Elevation <= 3435: Spruce/Fir (3)
    ##     :       :                   Elevation > 3435: Krummholz (1)
    ##     :       WildArea = WA_CPWA:
    ##     :       :...Hillshade15 <= 122: Krummholz (38/2)
    ##     :           Hillshade15 > 122:
    ##     :           :...Elevation <= 3325:
    ##     :               :...VertDistToHydro > 122:
    ##     :               :   :...Hillshade12 <= 225: Krummholz (6)
    ##     :               :   :   Hillshade12 > 225: Spruce/Fir (2)
    ##     :               :   VertDistToHydro <= 122:
    ##     :               :   :...HorDistFire <= 525: Krummholz (2)
    ##     :               :       HorDistFire > 525:
    ##     :               :       :...VertDistToHydro <= 6: Krummholz (5/2)
    ##     :               :           VertDistToHydro > 6: Spruce/Fir (25/2)
    ##     :               Elevation > 3325:
    ##     :               :...HorDistFire <= 470: Spruce/Fir (5)
    ##     :                   HorDistFire > 470:
    ##     :                   :...Slope <= 13: Krummholz (45/3)
    ##     :                       Slope > 13:
    ##     :                       :...Hillshade09 <= 207: Krummholz (15/3)
    ##     :                           Hillshade09 > 207:
    ##     :                           :...HorDistRoad <= 2068: Lodgepole Pine (1)
    ##     :                               HorDistRoad > 2068: Spruce/Fir (3)
    ##     ClimateZone in {montane,montane and subalpine,montane dry,
    ##     :               montane dry and montane}:
    ##     :...Elevation <= 2665:
    ##     :   :...WildArea in {WA_RWA,WA_NWA}: Lodgepole Pine (63/2)
    ##     :   :   WildArea = WA_CPWA:
    ##     :   :   :...ClimateZone = montane dry: Lodgepole Pine (0)
    ##     :   :       ClimateZone = montane dry and montane: Douglas-fir (3)
    ##     :   :       ClimateZone = montane and subalpine:
    ##     :   :       :...VertDistToHydro > 14:
    ##     :   :       :   :...Aspect <= 69: Aspen (1)
    ##     :   :       :   :   Aspect > 69: Ponderosa Pine (3)
    ##     :   :       :   VertDistToHydro <= 14:
    ##     :   :       :   :...HorDistToHydro > 150: Spruce/Fir (2/1)
    ##     :   :       :       HorDistToHydro <= 150:
    ##     :   :       :       :...VertDistToHydro <= -10: Ponderosa Pine (1)
    ##     :   :       :           VertDistToHydro > -10:
    ##     :   :       :           :...Hillshade12 <= 216: Lodgepole Pine (2)
    ##     :   :       :               Hillshade12 > 216:
    ##     :   :       :               :...Elevation <= 2574: Douglas-fir (7)
    ##     :   :       :                   Elevation > 2574:
    ##     :   :       :                   :...HorDistFire <= 1426: Spruce/Fir (2)
    ##     :   :       :                       HorDistFire > 1426:
    ##     :   :       :                       :...Slope <= 5: Douglas-fir (2)
    ##     :   :       :                           Slope > 5: Lodgepole Pine (2)
    ##     :   :       ClimateZone = montane:
    ##     :   :       :...HorDistRoad > 2155:
    ##     :   :           :...HorDistToHydro > 335: Spruce/Fir (2)
    ##     :   :           :   HorDistToHydro <= 335:
    ##     :   :           :   :...HorDistFire > 1554: Lodgepole Pine (11)
    ##     :   :           :       HorDistFire <= 1554:
    ##     :   :           :       :...VertDistToHydro <= 18: Douglas-fir (2)
    ##     :   :           :           VertDistToHydro > 18: Lodgepole Pine (1)
    ##     :   :           HorDistRoad <= 2155:
    ##     :   :           :...Elevation <= 2537:
    ##     :   :               :...HorDistToHydro > 201: Lodgepole Pine (8/3)
    ##     :   :               :   HorDistToHydro <= 201:
    ##     :   :               :   :...HorDistRoad > 1871: Ponderosa Pine (2)
    ##     :   :               :       HorDistRoad <= 1871:
    ##     :   :               :       :...Elevation > 2345: Douglas-fir (39/9)
    ##     :   :               :           Elevation <= 2345:
    ##     :   :               :           :...Aspect <= 112: Ponderosa Pine (2)
    ##     :   :               :               Aspect > 112: Lodgepole Pine (1)
    ##     :   :               Elevation > 2537:
    ##     :   :               :...HorDistRoad > 1640:
    ##     :   :                   :...Slope > 19: Douglas-fir (8)
    ##     :   :                   :   Slope <= 19:
    ##     :   :                   :   :...HorDistRoad <= 2068: Lodgepole Pine (9/2)
    ##     :   :                   :       HorDistRoad > 2068: Ponderosa Pine (1)
    ##     :   :                   HorDistRoad <= 1640:
    ##     :   :                   :...HorDistFire <= 1015:
    ##     :   :                       :...VertDistToHydro <= 122: Ponderosa Pine (15/4)
    ##     :   :                       :   VertDistToHydro > 122: Lodgepole Pine (3)
    ##     :   :                       HorDistFire > 1015:
    ##     :   :                       :...VertDistToHydro <= 32:
    ##     :   :                           :...HorDistRoad <= 742: [S4]
    ##     :   :                           :   HorDistRoad > 742: [S5]
    ##     :   :                           VertDistToHydro > 32:
    ##     :   :                           :...HorDistToHydro <= 127: Aspen (1)
    ##     :   :                               HorDistToHydro > 127: [S6]
    ##     :   Elevation > 2665:
    ##     :   :...WildArea = WA_NWA:
    ##     :       :...ClimateZone = montane: Spruce/Fir (1)
    ##     :       :   ClimateZone in {montane and subalpine,montane dry,
    ##     :       :                   montane dry and montane}: Lodgepole Pine (3)
    ##     :       WildArea = WA_RWA:
    ##     :       :...HorDistFire > 6514: Spruce/Fir (6/2)
    ##     :       :   HorDistFire <= 6514:
    ##     :       :   :...HorDistRoad <= 5330: Lodgepole Pine (270/16)
    ##     :       :       HorDistRoad > 5330:
    ##     :       :       :...Aspect <= 89: Spruce/Fir (5)
    ##     :       :           Aspect > 89: Lodgepole Pine (5)
    ##     :       WildArea = WA_CPWA:
    ##     :       :...Elevation <= 2764:
    ##     :           :...Aspect <= 311: Lodgepole Pine (83/20)
    ##     :           :   Aspect > 311:
    ##     :           :   :...VertDistToHydro <= 26: Lodgepole Pine (2)
    ##     :           :       VertDistToHydro > 26:
    ##     :           :       :...HorDistRoad <= 1610: Aspen (1)
    ##     :           :           HorDistRoad > 1610: Douglas-fir (6)
    ##     :           Elevation > 2764:
    ##     :           :...Elevation > 2962: Lodgepole Pine (53/19)
    ##     :               Elevation <= 2962:
    ##     :               :...Slope > 23: Lodgepole Pine (41/1)
    ##     :                   Slope <= 23:
    ##     :                   :...Hillshade15 > 206: Spruce/Fir (4)
    ##     :                       Hillshade15 <= 206:
    ##     :                       :...HorDistRoad <= 2165: Lodgepole Pine (85/8)
    ##     :                           HorDistRoad > 2165:
    ##     :                           :...Elevation <= 2774: Spruce/Fir (3)
    ##     :                               Elevation > 2774:
    ##     :                               :...HorDistFire > 735: Lodgepole Pine (24/2)
    ##     :                                   HorDistFire <= 735:
    ##     :                                   :...Aspect <= 70: Lodgepole Pine (5)
    ##     :                                       Aspect > 70: [S7]
    ##     ClimateZone = subalpine:
    ##     :...Elevation <= 3015:
    ##         :...Elevation <= 2809:
    ##         :   :...HorDistRoad <= 638:
    ##         :   :   :...VertDistToHydro <= -36: Spruce/Fir (3)
    ##         :   :   :   VertDistToHydro > -36:
    ##         :   :   :   :...Hillshade09 <= 234: Lodgepole Pine (31/6)
    ##         :   :   :       Hillshade09 > 234: [S8]
    ##         :   :   HorDistRoad > 638:
    ##         :   :   :...WildArea = WA_NWA: Lodgepole Pine (0)
    ##         :   :       WildArea = WA_RWA:
    ##         :   :       :...HorDistRoad > 3247:
    ##         :   :       :   :...Hillshade15 <= 145: Lodgepole Pine (6/1)
    ##         :   :       :   :   Hillshade15 > 145: Spruce/Fir (6)
    ##         :   :       :   HorDistRoad <= 3247: [S9]
    ##         :   :       WildArea = WA_CPWA:
    ##         :   :       :...HorDistToHydro <= 60:
    ##         :   :           :...Hillshade12 > 238:
    ##         :   :           :   :...HorDistFire <= 459: Lodgepole Pine (1)
    ##         :   :           :   :   HorDistFire > 459:
    ##         :   :           :   :   :...Slope <= 23: Aspen (5)
    ##         :   :           :   :       Slope > 23: Spruce/Fir (1)
    ##         :   :           :   Hillshade12 <= 238:
    ##         :   :           :   :...Elevation > 2784:
    ##         :   :           :       :...HorDistToHydro <= 42: Lodgepole Pine (2)
    ##         :   :           :       :   HorDistToHydro > 42: Aspen (3)
    ##         :   :           :       Elevation <= 2784: [S10]
    ##         :   :           HorDistToHydro > 60:
    ##         :   :           :...Slope <= 12:
    ##         :   :               :...Elevation <= 2737:
    ##         :   :               :   :...HorDistFire <= 1036: Spruce/Fir (2)
    ##         :   :               :   :   HorDistFire > 1036: Douglas-fir (5)
    ##         :   :               :   Elevation > 2737:
    ##         :   :               :   :...Elevation <= 2749: Aspen (2)
    ##         :   :               :       Elevation > 2749: Lodgepole Pine (7/2)
    ##         :   :               Slope > 12:
    ##         :   :               :...HorDistFire > 566: Lodgepole Pine (72/5)
    ##         :   :                   HorDistFire <= 566:
    ##         :   :                   :...Slope > 22: Douglas-fir (3/1)
    ##         :   :                       Slope <= 22: [S11]
    ##         :   Elevation > 2809: [S12]
    ##         Elevation > 3015:
    ##         :...VertDistToHydro <= -35:
    ##             :...HorDistFire <= 1008:
    ##             :   :...VertDistToHydro <= -45: Spruce/Fir (2)
    ##             :   :   VertDistToHydro > -45: Lodgepole Pine (1)
    ##             :   HorDistFire > 1008:
    ##             :   :...Aspect <= 47: Spruce/Fir (2)
    ##             :       Aspect > 47: Lodgepole Pine (30/2)
    ##             VertDistToHydro > -35:
    ##             :...HorDistRoad > 5282:
    ##                 :...HorDistFire <= 1224:
    ##                 :   :...VertDistToHydro > 54: Lodgepole Pine (6)
    ##                 :   :   VertDistToHydro <= 54:
    ##                 :   :   :...Hillshade09 <= 226: Spruce/Fir (31)
    ##                 :   :       Hillshade09 > 226: [S13]
    ##                 :   HorDistFire > 1224:
    ##                 :   :...HorDistRoad > 6367:
    ##                 :       :...Hillshade12 <= 247: Lodgepole Pine (25)
    ##                 :       :   Hillshade12 > 247: Spruce/Fir (1)
    ##                 :       HorDistRoad <= 6367:
    ##                 :       :...Aspect <= 29:
    ##                 :           :...Hillshade09 <= 212: Lodgepole Pine (1)
    ##                 :           :   Hillshade09 > 212: Spruce/Fir (6)
    ##                 :           Aspect > 29: [S14]
    ##                 HorDistRoad <= 5282:
    ##                 :...Elevation <= 3177:
    ##                     :...HorDistToHydro <= 60:
    ##                     :   :...Hillshade12 <= 245:
    ##                     :   :   :...HorDistRoad > 2011: Spruce/Fir (107/6)
    ##                     :   :   :   HorDistRoad <= 2011:
    ##                     :   :   :   :...HorDistRoad <= 1790: Spruce/Fir (59/11)
    ##                     :   :   :       HorDistRoad > 1790:
    ##                     :   :   :       :...HorDistFire <= 1084: Spruce/Fir (1)
    ##                     :   :   :           HorDistFire > 1084: Lodgepole Pine (4)
    ##                     :   :   Hillshade12 > 245:
    ##                     :   :   :...WildArea = WA_NWA: Lodgepole Pine (0)
    ##                     :   :       WildArea = WA_RWA: Krummholz (1)
    ##                     :   :       WildArea = WA_CPWA:
    ##                     :   :       :...HorDistRoad <= 2103: Spruce/Fir (2)
    ##                     :   :           HorDistRoad > 2103: [S15]
    ##                     :   HorDistToHydro > 60:
    ##                     :   :...Hillshade12 <= 196:
    ##                     :       :...HorDistToHydro <= 270: Spruce/Fir (29)
    ##                     :       :   HorDistToHydro > 270:
    ##                     :       :   :...WildArea = WA_NWA: Spruce/Fir (0)
    ##                     :       :       WildArea = WA_RWA:
    ##                     :       :       :...Hillshade15 <= 56: Lodgepole Pine (2)
    ##                     :       :       :   Hillshade15 > 56:
    ##                     :       :       :   :...Elevation <= 3170: Spruce/Fir (14/1)
    ##                     :       :       :       Elevation > 3170: Krummholz (1)
    ##                     :       :       WildArea = WA_CPWA:
    ##                     :       :       :...Elevation > 3108: Spruce/Fir (14)
    ##                     :       :           Elevation <= 3108:
    ##                     :       :           :...Hillshade09 > 227: [S16]
    ##                     :       :               Hillshade09 <= 227: [S17]
    ##                     :       Hillshade12 > 196: [S18]
    ##                     Elevation > 3177:
    ##                     :...Elevation > 3297:
    ##                         :...WildArea = WA_NWA:
    ##                         :   :...HorDistFire <= 1902: Spruce/Fir (25)
    ##                         :   :   HorDistFire > 1902:
    ##                         :   :   :...VertDistToHydro <= 12: Spruce/Fir (8)
    ##                         :   :       VertDistToHydro > 12:
    ##                         :   :       :...Elevation > 3388: Spruce/Fir (1)
    ##                         :   :           Elevation <= 3388: [S19]
    ##                         :   WildArea in {WA_RWA,WA_CPWA}:
    ##                         :   :...HorDistFire > 3129:
    ##                         :       :...Elevation <= 3308: Spruce/Fir (2/1)
    ##                         :       :   Elevation > 3308: Krummholz (8)
    ##                         :       HorDistFire <= 3129:
    ##                         :       :...HorDistRoad <= 942:
    ##                         :           :...WildArea = WA_RWA: Spruce/Fir (1)
    ##                         :           :   WildArea = WA_CPWA: Krummholz (4)
    ##                         :           HorDistRoad > 942:
    ##                         :           :...WildArea = WA_CPWA: [S20]
    ##                         :               WildArea = WA_RWA:
    ##                         :               :...Slope > 12: [S21]
    ##                         :                   Slope <= 12: [S22]
    ##                         Elevation <= 3297:
    ##                         :...HorDistToHydro <= 258:
    ##                             :...HorDistFire > 2374:
    ##                             :   :...HorDistRoad <= 1341: [S23]
    ##                             :   :   HorDistRoad > 1341:
    ##                             :   :   :...Hillshade12 <= 246: Spruce/Fir (87/16)
    ##                             :   :       Hillshade12 > 246:
    ##                             :   :       :...HorDistFire <= 2916: Krummholz (6)
    ##                             :   :           HorDistFire > 2916: Spruce/Fir (7)
    ##                             :   HorDistFire <= 2374: [S24]
    ##                             HorDistToHydro > 258:
    ##                             :...Hillshade15 <= 61: Spruce/Fir (9/2)
    ##                                 Hillshade15 > 61:
    ##                                 :...Hillshade09 > 233:
    ##                                     :...HorDistFire > 4924: Spruce/Fir (4)
    ##                                     :   HorDistFire <= 4924: [S25]
    ##                                     Hillshade09 <= 233:
    ##                                     :...HorDistFire <= 582: Spruce/Fir (23)
    ##                                         HorDistFire > 582: [S26]
    ## 
    ## SubTree [S1]
    ## 
    ## GeologicZone in {glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Ponderosa Pine (0)
    ## GeologicZone = alluvium: Cottonwood/Willow (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistFire <= 277: Cottonwood/Willow (1)
    ##     HorDistFire > 277: Ponderosa Pine (4)
    ## 
    ## SubTree [S2]
    ## 
    ## ClimateZone = lower montane: Lodgepole Pine (1)
    ## ClimateZone in {alpine,lower montane dry,montane,montane and subalpine,
    ##                 montane dry,montane dry and montane,
    ##                 subalpine}: Ponderosa Pine (2)
    ## 
    ## SubTree [S3]
    ## 
    ## GeologicZone in {glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Ponderosa Pine (0)
    ## GeologicZone = alluvium:
    ## :...HorDistToHydro > 42: Cottonwood/Willow (1)
    ## :   HorDistToHydro <= 42:
    ## :   :...Elevation <= 2211: Ponderosa Pine (3)
    ## :       Elevation > 2211: Douglas-fir (2)
    ## GeologicZone = igneous and metamorphic:
    ## :...Elevation <= 2302: Ponderosa Pine (129/33)
    ##     Elevation > 2302:
    ##     :...Hillshade15 <= 111: Lodgepole Pine (2)
    ##         Hillshade15 > 111:
    ##         :...VertDistToHydro > 179: Ponderosa Pine (8)
    ##             VertDistToHydro <= 179:
    ##             :...HorDistRoad <= 518:
    ##                 :...Aspect > 274: Ponderosa Pine (15/1)
    ##                 :   Aspect <= 274: [S27]
    ##                 HorDistRoad > 518:
    ##                 :...HorDistFire <= 1398:
    ##                     :...Slope <= 26: Douglas-fir (34/4)
    ##                     :   Slope > 26: Ponderosa Pine (5/1)
    ##                     HorDistFire > 1398:
    ##                     :...VertDistToHydro <= 55: Lodgepole Pine (3)
    ##                         VertDistToHydro > 55: Douglas-fir (2)
    ## 
    ## SubTree [S4]
    ## 
    ## Elevation <= 2601: Douglas-fir (3)
    ## Elevation > 2601: Lodgepole Pine (1)
    ## 
    ## SubTree [S5]
    ## 
    ## Hillshade09 <= 169: Douglas-fir (1)
    ## Hillshade09 > 169: Lodgepole Pine (20/1)
    ## 
    ## SubTree [S6]
    ## 
    ## Elevation <= 2582: Lodgepole Pine (7)
    ## Elevation > 2582:
    ## :...Hillshade12 <= 205: Lodgepole Pine (2)
    ##     Hillshade12 > 205: Ponderosa Pine (2)
    ## 
    ## SubTree [S7]
    ## 
    ## Elevation <= 2856: Lodgepole Pine (1)
    ## Elevation > 2856: Spruce/Fir (4)
    ## 
    ## SubTree [S8]
    ## 
    ## GeologicZone in {alluvium,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,volcanic}: Aspen (0)
    ## GeologicZone = glacial: Lodgepole Pine (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...Elevation <= 2608: Lodgepole Pine (1)
    ##     Elevation > 2608: Aspen (18/2)
    ## 
    ## SubTree [S9]
    ## 
    ## GeologicZone in {glacial,igneous and metamorphic,mixed sedimentary,sandstone,
    ## :                shale,unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (189/9)
    ## GeologicZone = alluvium:
    ## :...Hillshade09 <= 198: Spruce/Fir (3)
    ##     Hillshade09 > 198:
    ##     :...HorDistToHydro <= 108: Lodgepole Pine (13/2)
    ##         HorDistToHydro > 108: Spruce/Fir (1)
    ## 
    ## SubTree [S10]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone = alluvium:
    ## :...HorDistRoad <= 1165: Douglas-fir (2)
    ## :   HorDistRoad > 1165: Lodgepole Pine (7/3)
    ## GeologicZone = glacial:
    ## :...HorDistRoad <= 1699: Lodgepole Pine (1)
    ## :   HorDistRoad > 1699: Spruce/Fir (3)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistFire <= 1637: Spruce/Fir (18/8)
    ##     HorDistFire > 1637: Lodgepole Pine (8/1)
    ## 
    ## SubTree [S11]
    ## 
    ## HorDistToHydro > 192: Lodgepole Pine (3)
    ## HorDistToHydro <= 192:
    ## :...Hillshade12 <= 229: Spruce/Fir (3)
    ##     Hillshade12 > 229: Lodgepole Pine (1)
    ## 
    ## SubTree [S12]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone in {alluvium,glacial}:
    ## :...HorDistRoad <= 360:
    ## :   :...HorDistFire <= 1831: Spruce/Fir (15)
    ## :   :   HorDistFire > 1831: Lodgepole Pine (1)
    ## :   HorDistRoad > 360:
    ## :   :...HorDistToHydro <= 30:
    ## :       :...WildArea = WA_NWA: Spruce/Fir (2)
    ## :       :   WildArea = WA_RWA:
    ## :       :   :...GeologicZone = alluvium: Lodgepole Pine (16/3)
    ## :       :   :   GeologicZone = glacial: Spruce/Fir (35/11)
    ## :       :   WildArea = WA_CPWA:
    ## :       :   :...HorDistRoad > 2259: Spruce/Fir (22/2)
    ## :       :       HorDistRoad <= 2259:
    ## :       :       :...GeologicZone = alluvium:
    ## :       :           :...Elevation <= 2878: Lodgepole Pine (1)
    ## :       :           :   Elevation > 2878: Spruce/Fir (4)
    ## :       :           GeologicZone = glacial:
    ## :       :           :...HorDistFire <= 1699: Lodgepole Pine (10/2)
    ## :       :               HorDistFire > 1699: Spruce/Fir (3)
    ## :       HorDistToHydro > 30:
    ## :       :...HorDistFire <= 2106:
    ## :           :...HorDistToHydro > 67: Lodgepole Pine (49/12)
    ## :           :   HorDistToHydro <= 67:
    ## :           :   :...HorDistFire <= 1302: Lodgepole Pine (7)
    ## :           :       HorDistFire > 1302:
    ## :           :       :...Elevation > 2964: Spruce/Fir (1)
    ## :           :           Elevation <= 2964:
    ## :           :           :...VertDistToHydro <= 2: Lodgepole Pine (2)
    ## :           :               VertDistToHydro > 2: Aspen (3)
    ## :           HorDistFire > 2106:
    ## :           :...Elevation > 2951:
    ## :               :...Slope > 6: Spruce/Fir (22)
    ## :               :   Slope <= 6:
    ## :               :   :...Hillshade15 <= 148: Lodgepole Pine (3)
    ## :               :       Hillshade15 > 148: Spruce/Fir (6)
    ## :               Elevation <= 2951:
    ## :               :...GeologicZone = alluvium: Lodgepole Pine (12/1)
    ## :                   GeologicZone = glacial:
    ## :                   :...HorDistToHydro <= 150: Spruce/Fir (17/6)
    ## :                       HorDistToHydro > 150:
    ## :                       :...HorDistToHydro <= 474: Lodgepole Pine (15)
    ## :                           HorDistToHydro > 474: Spruce/Fir (2)
    ## GeologicZone = igneous and metamorphic:
    ## :...Hillshade12 > 234: Lodgepole Pine (272/26)
    ##     Hillshade12 <= 234:
    ##     :...VertDistToHydro > 0:
    ##         :...Hillshade12 <= 188:
    ##         :   :...VertDistToHydro > 204: Aspen (1)
    ##         :   :   VertDistToHydro <= 204:
    ##         :   :   :...Elevation > 2957:
    ##         :   :       :...VertDistToHydro <= 127: Spruce/Fir (10)
    ##         :   :       :   VertDistToHydro > 127:
    ##         :   :       :   :...HorDistToHydro <= 324: Lodgepole Pine (3)
    ##         :   :       :       HorDistToHydro > 324: Spruce/Fir (3)
    ##         :   :       Elevation <= 2957:
    ##         :   :       :...HorDistRoad <= 371:
    ##         :   :           :...Slope <= 23: Lodgepole Pine (1)
    ##         :   :           :   Slope > 23: Spruce/Fir (6)
    ##         :   :           HorDistRoad > 371:
    ##         :   :           :...HorDistRoad <= 2005: Lodgepole Pine (13)
    ##         :   :               HorDistRoad > 2005:
    ##         :   :               :...HorDistFire <= 1857:
    ##         :   :                   :...Hillshade09 <= 144: Spruce/Fir (1)
    ##         :   :                   :   Hillshade09 > 144: Lodgepole Pine (9)
    ##         :   :                   HorDistFire > 1857:
    ##         :   :                   :...Aspect <= 60: Spruce/Fir (4)
    ##         :   :                       Aspect > 60: Lodgepole Pine (1)
    ##         :   Hillshade12 > 188:
    ##         :   :...WildArea = WA_NWA: Lodgepole Pine (0)
    ##         :       WildArea = WA_RWA:
    ##         :       :...HorDistToHydro > 201: Lodgepole Pine (187/24)
    ##         :       :   HorDistToHydro <= 201:
    ##         :       :   :...Elevation <= 2909: Lodgepole Pine (77/8)
    ##         :       :       Elevation > 2909:
    ##         :       :       :...HorDistRoad > 2480: Lodgepole Pine (73/22)
    ##         :       :           HorDistRoad <= 2480:
    ##         :       :           :...HorDistFire <= 1084: Lodgepole Pine (2)
    ##         :       :               HorDistFire > 1084:
    ##         :       :               :...HorDistRoad > 1364: Spruce/Fir (11)
    ##         :       :                   HorDistRoad <= 1364:
    ##         :       :                   :...Hillshade09 <= 245: Lodgepole Pine (3)
    ##         :       :                       Hillshade09 > 245: Spruce/Fir (3)
    ##         :       WildArea = WA_CPWA:
    ##         :       :...HorDistFire > 3150:
    ##         :           :...Slope <= 18: Spruce/Fir (5)
    ##         :           :   Slope > 18: Lodgepole Pine (1)
    ##         :           HorDistFire <= 3150:
    ##         :           :...HorDistToHydro > 601: Lodgepole Pine (24)
    ##         :               HorDistToHydro <= 601:
    ##         :               :...Slope <= 23: Lodgepole Pine (252/58)
    ##         :                   Slope > 23:
    ##         :                   :...VertDistToHydro <= 48: Lodgepole Pine (5)
    ##         :                       VertDistToHydro > 48:
    ##         :                       :...Aspect <= 299: Spruce/Fir (7)
    ##         :                           Aspect > 299:
    ##         :                           :...HorDistFire > 1342: Lodgepole Pine (4)
    ##         :                               HorDistFire <= 1342: [S28]
    ##         VertDistToHydro <= 0:
    ##         :...WildArea = WA_NWA: Lodgepole Pine (0)
    ##             WildArea = WA_CPWA: Spruce/Fir (40/14)
    ##             WildArea = WA_RWA:
    ##             :...HorDistToHydro > 543: Lodgepole Pine (2/1)
    ##                 HorDistToHydro <= 543:
    ##                 :...HorDistFire <= 1124:
    ##                     :...Hillshade12 <= 218: Spruce/Fir (10)
    ##                     :   Hillshade12 > 218: Lodgepole Pine (4/1)
    ##                     HorDistFire > 1124:
    ##                     :...HorDistToHydro > 459: Spruce/Fir (3)
    ##                         HorDistToHydro <= 459:
    ##                         :...Hillshade09 <= 189: Spruce/Fir (3)
    ##                             Hillshade09 > 189:
    ##                             :...Elevation <= 2933: Lodgepole Pine (31/2)
    ##                                 Elevation > 2933:
    ##                                 :...Slope <= 11: Lodgepole Pine (14/1)
    ##                                     Slope > 11:
    ##                                     :...HorDistToHydro <= 67: Spruce/Fir (8)
    ##                                         HorDistToHydro > 67: [S29]
    ## 
    ## SubTree [S13]
    ## 
    ## GeologicZone in {alluvium,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,volcanic}: Spruce/Fir (0)
    ## GeologicZone = glacial:
    ## :...HorDistFire <= 837: Spruce/Fir (6)
    ## :   HorDistFire > 837: Lodgepole Pine (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...VertDistToHydro <= 17: Spruce/Fir (2)
    ##     VertDistToHydro > 17: Lodgepole Pine (3)
    ## 
    ## SubTree [S14]
    ## 
    ## GeologicZone in {igneous and metamorphic,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (101/25)
    ## GeologicZone = alluvium:
    ## :...Slope <= 6: Lodgepole Pine (2)
    ## :   Slope > 6: Spruce/Fir (2)
    ## GeologicZone = glacial:
    ## :...Elevation <= 3209: Lodgepole Pine (25/1)
    ##     Elevation > 3209: Spruce/Fir (7)
    ## 
    ## SubTree [S15]
    ## 
    ## GeologicZone in {alluvium,glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (4)
    ## GeologicZone = igneous and metamorphic: Spruce/Fir (1)
    ## 
    ## SubTree [S16]
    ## 
    ## HorDistToHydro <= 366: Spruce/Fir (1)
    ## HorDistToHydro > 366: Lodgepole Pine (5)
    ## 
    ## SubTree [S17]
    ## 
    ## HorDistFire <= 1150: Lodgepole Pine (2)
    ## HorDistFire > 1150:
    ## :...HorDistToHydro <= 306: Lodgepole Pine (2)
    ##     HorDistToHydro > 306: Spruce/Fir (13/1)
    ## 
    ## SubTree [S18]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Spruce/Fir (0)
    ## GeologicZone in {alluvium,glacial}:
    ## :...HorDistRoad > 1101:
    ## :   :...WildArea = WA_RWA: Spruce/Fir (81/5)
    ## :   :   WildArea = WA_CPWA:
    ## :   :   :...Hillshade12 <= 246: Spruce/Fir (63/7)
    ## :   :   :   Hillshade12 > 246: Lodgepole Pine (3)
    ## :   :   WildArea = WA_NWA:
    ## :   :   :...HorDistFire > 2934: Spruce/Fir (3)
    ## :   :       HorDistFire <= 2934:
    ## :   :       :...Hillshade15 <= 150: Lodgepole Pine (3)
    ## :   :           Hillshade15 > 150: Spruce/Fir (1)
    ## :   HorDistRoad <= 1101:
    ## :   :...HorDistToHydro > 450: Lodgepole Pine (10)
    ## :       HorDistToHydro <= 450:
    ## :       :...WildArea = WA_RWA:
    ## :           :...Hillshade12 <= 223: Lodgepole Pine (9)
    ## :           :   Hillshade12 > 223:
    ## :           :   :...Hillshade09 <= 242: Spruce/Fir (23)
    ## :           :       Hillshade09 > 242: Lodgepole Pine (3)
    ## :           WildArea = WA_CPWA:
    ## :           :...HorDistRoad > 875: Spruce/Fir (6)
    ## :           :   HorDistRoad <= 875:
    ## :           :   :...Aspect <= 292: Lodgepole Pine (14)
    ## :           :       Aspect > 292: Spruce/Fir (3)
    ## :           WildArea = WA_NWA:
    ## :           :...Elevation <= 3070: Lodgepole Pine (9)
    ## :               Elevation > 3070:
    ## :               :...Hillshade09 > 239: Lodgepole Pine (4)
    ## :                   Hillshade09 <= 239:
    ## :                   :...Hillshade12 > 239: Lodgepole Pine (3)
    ## :                       Hillshade12 <= 239:
    ## :                       :...Elevation <= 3170: Spruce/Fir (22)
    ## :                           Elevation > 3170:
    ## :                           :...Hillshade09 <= 223: Lodgepole Pine (2)
    ## :                               Hillshade09 > 223: Spruce/Fir (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistFire > 3104:
    ##     :...Elevation > 3056: Spruce/Fir (70/9)
    ##     :   Elevation <= 3056:
    ##     :   :...Slope <= 11:
    ##     :       :...WildArea in {WA_RWA,WA_NWA}: Spruce/Fir (9)
    ##     :       :   WildArea = WA_CPWA: Lodgepole Pine (1)
    ##     :       Slope > 11:
    ##     :       :...HorDistRoad <= 4267: Lodgepole Pine (10)
    ##     :           HorDistRoad > 4267: Spruce/Fir (2)
    ##     HorDistFire <= 3104:
    ##     :...Elevation <= 3053:
    ##         :...Hillshade09 <= 163: Spruce/Fir (3)
    ##         :   Hillshade09 > 163: Lodgepole Pine (126/31)
    ##         Elevation > 3053:
    ##         :...HorDistFire > 2334:
    ##             :...VertDistToHydro <= 32:
    ##             :   :...HorDistToHydro <= 85: Spruce/Fir (5)
    ##             :   :   HorDistToHydro > 85: Lodgepole Pine (50/20)
    ##             :   VertDistToHydro > 32:
    ##             :   :...Hillshade15 > 151: Spruce/Fir (23)
    ##             :       Hillshade15 <= 151:
    ##             :       :...HorDistRoad <= 2621: Spruce/Fir (31/6)
    ##             :           HorDistRoad > 2621:
    ##             :           :...HorDistToHydro > 391: Lodgepole Pine (8)
    ##             :               HorDistToHydro <= 391:
    ##             :               :...HorDistFire <= 2822: Spruce/Fir (6)
    ##             :                   HorDistFire > 2822:
    ##             :                   :...HorDistToHydro <= 192: Spruce/Fir (2)
    ##             :                       HorDistToHydro > 192: Lodgepole Pine (4)
    ##             HorDistFire <= 2334:
    ##             :...WildArea = WA_NWA: Lodgepole Pine (9/4)
    ##                 WildArea = WA_RWA:
    ##                 :...HorDistFire > 1100:
    ##                 :   :...HorDistRoad > 4373: Spruce/Fir (20)
    ##                 :   :   HorDistRoad <= 4373:
    ##                 :   :   :...Aspect > 97:
    ##                 :   :       :...Elevation <= 3132:
    ##                 :   :       :   :...HorDistToHydro <= 95: Lodgepole Pine (1)
    ##                 :   :       :   :   HorDistToHydro > 95: Spruce/Fir (20)
    ##                 :   :       :   Elevation > 3132:
    ##                 :   :       :   :...HorDistRoad <= 1895: Lodgepole Pine (4)
    ##                 :   :       :       HorDistRoad > 1895: Spruce/Fir (2)
    ##                 :   :       Aspect <= 97:
    ##                 :   :       :...Elevation <= 3134: Lodgepole Pine (13)
    ##                 :   :           Elevation > 3134:
    ##                 :   :           :...Aspect <= 71: Spruce/Fir (6)
    ##                 :   :               Aspect > 71:
    ##                 :   :               :...HorDistRoad <= 984: Spruce/Fir (1)
    ##                 :   :                   HorDistRoad > 984: Lodgepole Pine (4)
    ##                 :   HorDistFire <= 1100:
    ##                 :   :...HorDistRoad <= 2458:
    ##                 :       :...Slope <= 20: Spruce/Fir (7)
    ##                 :       :   Slope > 20: Lodgepole Pine (1)
    ##                 :       HorDistRoad > 2458:
    ##                 :       :...HorDistToHydro > 201:
    ##                 :           :...Aspect <= 338: Lodgepole Pine (28)
    ##                 :           :   Aspect > 338: Spruce/Fir (1)
    ##                 :           HorDistToHydro <= 201:
    ##                 :           :...HorDistFire > 930: Lodgepole Pine (5)
    ##                 :               HorDistFire <= 930:
    ##                 :               :...Slope <= 10:
    ##                 :                   :...Elevation <= 3075: Spruce/Fir (1)
    ##                 :                   :   Elevation > 3075: Lodgepole Pine (5)
    ##                 :                   Slope > 10:
    ##                 :                   :...HorDistFire > 674: Spruce/Fir (7)
    ##                 :                       HorDistFire <= 674:
    ##                 :                       :...Aspect <= 120: Spruce/Fir (3)
    ##                 :                           Aspect > 120: Lodgepole Pine (2)
    ##                 WildArea = WA_CPWA:
    ##                 :...Hillshade12 > 249:
    ##                     :...VertDistToHydro <= 4: Spruce/Fir (2)
    ##                     :   VertDistToHydro > 4: Lodgepole Pine (21)
    ##                     Hillshade12 <= 249:
    ##                     :...HorDistFire > 716:
    ##                         :...Hillshade09 <= 186: Spruce/Fir (25/8)
    ##                         :   Hillshade09 > 186:
    ##                         :   :...Hillshade15 <= 101:
    ##                         :       :...VertDistToHydro <= 91: Spruce/Fir (12/2)
    ##                         :       :   VertDistToHydro > 91: Lodgepole Pine (3)
    ##                         :       Hillshade15 > 101:
    ##                         :       :...VertDistToHydro <= 293: Lodgepole Pine (109/24)
    ##                         :           VertDistToHydro > 293: Spruce/Fir (2)
    ##                         HorDistFire <= 716:
    ##                         :...HorDistToHydro <= 95: Lodgepole Pine (4)
    ##                             HorDistToHydro > 95:
    ##                             :...Hillshade09 <= 177: Lodgepole Pine (2)
    ##                                 Hillshade09 > 177:
    ##                                 :...Hillshade15 <= 92: Lodgepole Pine (2)
    ##                                     Hillshade15 > 92:
    ##                                     :...Elevation <= 3154: Spruce/Fir (19)
    ##                                         Elevation > 3154: [S30]
    ## 
    ## SubTree [S19]
    ## 
    ## Hillshade09 <= 188: Spruce/Fir (1)
    ## Hillshade09 > 188: Lodgepole Pine (13)
    ## 
    ## SubTree [S20]
    ## 
    ## GeologicZone in {alluvium,igneous and metamorphic,mixed sedimentary,sandstone,
    ## :                shale,unspecified in the USFS ELU Survey,
    ## :                volcanic}: Spruce/Fir (79/12)
    ## GeologicZone = glacial:
    ## :...HorDistToHydro <= 153: Krummholz (2)
    ##     HorDistToHydro > 153: Spruce/Fir (2)
    ## 
    ## SubTree [S21]
    ## 
    ## HorDistToHydro <= 127: Krummholz (1)
    ## HorDistToHydro > 127: Spruce/Fir (10)
    ## 
    ## SubTree [S22]
    ## 
    ## Hillshade15 <= 133: Krummholz (2)
    ## Hillshade15 > 133:
    ## :...Hillshade12 <= 241: Lodgepole Pine (5)
    ##     Hillshade12 > 241: Spruce/Fir (2)
    ## 
    ## SubTree [S23]
    ## 
    ## WildArea = WA_NWA: Lodgepole Pine (5)
    ## WildArea = WA_RWA:
    ## :...VertDistToHydro <= 35: Spruce/Fir (3)
    ## :   VertDistToHydro > 35: Lodgepole Pine (1)
    ## WildArea = WA_CPWA:
    ## :...Hillshade09 <= 210: Spruce/Fir (1)
    ##     Hillshade09 > 210: Lodgepole Pine (2)
    ## 
    ## SubTree [S24]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Spruce/Fir (0)
    ## GeologicZone = alluvium:
    ## :...Hillshade15 <= 146: Lodgepole Pine (2)
    ## :   Hillshade15 > 146: Spruce/Fir (3)
    ## GeologicZone = glacial:
    ## :...WildArea = WA_RWA: Spruce/Fir (36/1)
    ## :   WildArea = WA_CPWA:
    ## :   :...VertDistToHydro <= 67: Spruce/Fir (24/1)
    ## :   :   VertDistToHydro > 67: Lodgepole Pine (1)
    ## :   WildArea = WA_NWA:
    ## :   :...HorDistRoad > 1860: Lodgepole Pine (3)
    ## :       HorDistRoad <= 1860:
    ## :       :...Hillshade15 <= 225: Spruce/Fir (20)
    ## :           Hillshade15 > 225: Lodgepole Pine (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistToHydro <= 153:
    ##     :...VertDistToHydro > 39: Lodgepole Pine (1)
    ##     :   VertDistToHydro <= 39:
    ##     :   :...HorDistRoad <= 418: Lodgepole Pine (1)
    ##     :       HorDistRoad > 418: Spruce/Fir (48)
    ##     HorDistToHydro > 153:
    ##     :...VertDistToHydro <= 5: Lodgepole Pine (4)
    ##         VertDistToHydro > 5:
    ##         :...WildArea = WA_NWA:
    ##             :...HorDistToHydro <= 228: Lodgepole Pine (2)
    ##             :   HorDistToHydro > 228: Spruce/Fir (2)
    ##             WildArea = WA_CPWA:
    ##             :...HorDistToHydro <= 162: Lodgepole Pine (1)
    ##             :   HorDistToHydro > 162: Spruce/Fir (19/2)
    ##             WildArea = WA_RWA:
    ##             :...VertDistToHydro > 45: Spruce/Fir (6)
    ##                 VertDistToHydro <= 45:
    ##                 :...Hillshade12 <= 221: Spruce/Fir (1)
    ##                     Hillshade12 > 221: Lodgepole Pine (6)
    ## 
    ## SubTree [S25]
    ## 
    ## GeologicZone in {alluvium,glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (12/2)
    ## GeologicZone = igneous and metamorphic:
    ## :...Slope > 20: Lodgepole Pine (6)
    ##     Slope <= 20:
    ##     :...WildArea = WA_NWA:
    ##         :...Hillshade12 <= 231: Lodgepole Pine (4)
    ##         :   Hillshade12 > 231: Spruce/Fir (3)
    ##         WildArea = WA_RWA:
    ##         :...VertDistToHydro > 124: Lodgepole Pine (3)
    ##         :   VertDistToHydro <= 124:
    ##         :   :...Aspect <= 90: Lodgepole Pine (1)
    ##         :       Aspect > 90: Spruce/Fir (8)
    ##         WildArea = WA_CPWA:
    ##         :...HorDistRoad > 2547: Lodgepole Pine (6)
    ##             HorDistRoad <= 2547:
    ##             :...Slope > 17: Lodgepole Pine (2)
    ##                 Slope <= 17:
    ##                 :...Elevation <= 3282: Spruce/Fir (7)
    ##                     Elevation > 3282: Lodgepole Pine (1)
    ## 
    ## SubTree [S26]
    ## 
    ## GeologicZone in {alluvium,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Spruce/Fir (4)
    ## GeologicZone = glacial:
    ## :...HorDistFire <= 2151: Spruce/Fir (32)
    ## :   HorDistFire > 2151:
    ## :   :...HorDistRoad <= 1575:
    ## :       :...HorDistFire > 4239: Spruce/Fir (1)
    ## :       :   HorDistFire <= 4239:
    ## :       :   :...Hillshade09 <= 232: Lodgepole Pine (10)
    ## :       :       Hillshade09 > 232: Spruce/Fir (1)
    ## :       HorDistRoad > 1575:
    ## :       :...Hillshade15 > 175: Krummholz (1)
    ## :           Hillshade15 <= 175:
    ## :           :...HorDistRoad > 4839: Lodgepole Pine (2)
    ## :               HorDistRoad <= 4839:
    ## :               :...VertDistToHydro <= -3: Lodgepole Pine (1)
    ## :                   VertDistToHydro > -3: Spruce/Fir (18)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistRoad <= 1304:
    ##     :...Slope > 21: Spruce/Fir (5)
    ##     :   Slope <= 21:
    ##     :   :...HorDistFire <= 1371: Spruce/Fir (15/4)
    ##     :       HorDistFire > 1371:
    ##     :       :...Hillshade15 <= 125: Spruce/Fir (2)
    ##     :           Hillshade15 > 125: Lodgepole Pine (32/4)
    ##     HorDistRoad > 1304:
    ##     :...Hillshade12 <= 242:
    ##         :...WildArea in {WA_RWA,WA_CPWA}: Spruce/Fir (125/20)
    ##         :   WildArea = WA_NWA: Lodgepole Pine (3)
    ##         Hillshade12 > 242:
    ##         :...HorDistRoad <= 2045: Spruce/Fir (9)
    ##             HorDistRoad > 2045:
    ##             :...WildArea in {WA_RWA,WA_NWA}: Lodgepole Pine (6)
    ##                 WildArea = WA_CPWA:
    ##                 :...HorDistFire > 2224: Lodgepole Pine (9)
    ##                     HorDistFire <= 2224:
    ##                     :...VertDistToHydro <= 28:
    ##                         :...Hillshade09 <= 204: Spruce/Fir (1)
    ##                         :   Hillshade09 > 204: Lodgepole Pine (5)
    ##                         VertDistToHydro > 28:
    ##                         :...HorDistToHydro <= 499: Spruce/Fir (9)
    ##                             HorDistToHydro > 499:
    ##                             :...Hillshade12 <= 246: Spruce/Fir (3)
    ##                                 Hillshade12 > 246: Lodgepole Pine (3)
    ## 
    ## SubTree [S27]
    ## 
    ## ClimateZone = lower montane: Lodgepole Pine (2/1)
    ## ClimateZone in {alpine,lower montane dry,montane,montane and subalpine,
    ##                 montane dry,montane dry and montane,
    ##                 subalpine}: Douglas-fir (4)
    ## 
    ## SubTree [S28]
    ## 
    ## Hillshade15 <= 196: Lodgepole Pine (1)
    ## Hillshade15 > 196: Spruce/Fir (6)
    ## 
    ## SubTree [S29]
    ## 
    ## HorDistRoad > 3866: Lodgepole Pine (6)
    ## HorDistRoad <= 3866:
    ## :...Elevation <= 2958: Lodgepole Pine (1)
    ##     Elevation > 2958: Spruce/Fir (3)
    ## 
    ## SubTree [S30]
    ## 
    ## HorDistRoad <= 2389: Spruce/Fir (4)
    ## HorDistRoad > 2389: Lodgepole Pine (2)
    ## 
    ## 
    ## Evaluation on training data (5810 cases):
    ## 
    ##      Decision Tree   
    ##    ----------------  
    ##    Size      Errors  
    ## 
    ##     412  638(11.0%)   <<
    ## 
    ## 
    ##     (a)   (b)   (c)   (d)   (e)   (f)   (g)    <-classified as
    ##    ----  ----  ----  ----  ----  ----  ----
    ##    1801   322                            12    (a): class Spruce/Fir
    ##     149  2688     9           2     9          (b): class Lodgepole Pine
    ##            11   327                 5          (c): class Ponderosa Pine
    ##                   6    16                      (d): class Cottonwood/Willow
    ##       1    34                37                (e): class Aspen
    ##            11    45               126          (f): class Douglas-fir
    ##      20     2                           177    (g): class Krummholz
    ## 
    ## 
    ##  Attribute usage:
    ## 
    ##  100.00% WildArea
    ##   98.43% Elevation
    ##   94.03% ClimateZone
    ##   65.90% HorDistRoad
    ##   61.62% HorDistToHydro
    ##   61.39% GeologicZone
    ##   60.22% HorDistFire
    ##   58.97% VertDistToHydro
    ##   47.59% Hillshade12
    ##   26.28% Hillshade09
    ##   18.40% Hillshade15
    ##   17.19% Slope
    ##    8.50% Aspect
    ## 
    ## 
    ## Time: 0.1 secs

Separando por WildArea:

1.  WildArea WA\_RWA

``` r
# bar <- subset(foo, location == "there")
covtype_WA_RWA = subset(covtype, covtype$WildArea == "WA_RWA")
rows <- nrow(covtype_WA_RWA)
covtypeSample_WA_RWA <- covtype_WA_RWA[sample(rows,rows/100), ]

covtypeSample_WA_RWA$WildArea <- NULL
modelCT <- C5.0(Class ~ ., data=covtypeSample_WA_RWA, control = C5.0Control(noGlobalPruning = TRUE, minCases=1))
#plot(modelCT50, main="C5.0 Decision Tree - Unpruned, min=1")
summary(modelCT)
```

    ## 
    ## Call:
    ## C5.0.formula(formula = Class ~ ., data = covtypeSample_WA_RWA, control
    ##  = C5.0Control(noGlobalPruning = TRUE, minCases = 1))
    ## 
    ## 
    ## C5.0 [Release 2.07 GPL Edition]      Fri Aug 25 10:42:56 2017
    ## -------------------------------
    ## 
    ## Class specified by attribute `outcome'
    ## 
    ## Read 2607 cases (14 attributes) from undefined.data
    ## 
    ## Decision tree:
    ## 
    ## ClimateZone in {lower montane,lower montane dry,
    ## :               montane dry and montane}: Lodgepole Pine (0)
    ## ClimateZone = alpine:
    ## :...HorDistFire <= 1952: Spruce/Fir (85/4)
    ## :   HorDistFire > 1952:
    ## :   :...HorDistToHydro > 295:
    ## :       :...HorDistRoad <= 981: Krummholz (2)
    ## :       :   HorDistRoad > 981:
    ## :       :   :...Elevation <= 3472: Spruce/Fir (35)
    ## :       :       Elevation > 3472: Krummholz (1)
    ## :       HorDistToHydro <= 295:
    ## :       :...Slope > 25: Spruce/Fir (8)
    ## :           Slope <= 25:
    ## :           :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,
    ## :               :            ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,
    ## :               :            ST21,ST22,ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST30,
    ## :               :            ST31,ST32,ST33,ST34,ST35,ST36,
    ## :               :            ST37}: Krummholz (2)
    ## :               SoilType = ST38:
    ## :               :...HorDistRoad <= 1782: Spruce/Fir (4)
    ## :               :   HorDistRoad > 1782: Krummholz (16/3)
    ## :               SoilType = ST40:
    ## :               :...Elevation <= 3324: Spruce/Fir (1)
    ## :               :   Elevation > 3324: Krummholz (1)
    ## :               SoilType = ST39:
    ## :               :...VertDistToHydro <= 28:
    ## :                   :...HorDistFire <= 3881: Krummholz (6)
    ## :                   :   HorDistFire > 3881: Spruce/Fir (2)
    ## :                   VertDistToHydro > 28:
    ## :                   :...HorDistToHydro <= 258: Spruce/Fir (7)
    ## :                       HorDistToHydro > 258: Krummholz (1)
    ## ClimateZone in {montane,montane and subalpine,montane dry,subalpine}:
    ## :...Elevation <= 3008:
    ##     :...Hillshade15 <= 77:
    ##     :   :...Elevation > 2871:
    ##     :   :   :...HorDistRoad <= 612: Spruce/Fir (10)
    ##     :   :   :   HorDistRoad > 612:
    ##     :   :   :   :...Hillshade09 > 238: Lodgepole Pine (9)
    ##     :   :   :       Hillshade09 <= 238:
    ##     :   :   :       :...VertDistToHydro <= 24: Lodgepole Pine (2)
    ##     :   :   :           VertDistToHydro > 24: Spruce/Fir (2)
    ##     :   :   Elevation <= 2871:
    ##     :   :   :...HorDistFire > 2089: Lodgepole Pine (14/2)
    ##     :   :       HorDistFire <= 2089:
    ##     :   :       :...HorDistToHydro <= 67: Lodgepole Pine (3)
    ##     :   :           HorDistToHydro > 67:
    ##     :   :           :...Elevation <= 2790: Aspen (12)
    ##     :   :               Elevation > 2790:
    ##     :   :               :...VertDistToHydro > 155: Aspen (3)
    ##     :   :                   VertDistToHydro <= 155:
    ##     :   :                   :...HorDistRoad <= 664: Lodgepole Pine (4)
    ##     :   :                       HorDistRoad > 664: Aspen (1)
    ##     :   Hillshade15 > 77:
    ##     :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST10,ST11,ST13,ST14,
    ##     :       :            ST15,ST17,ST21,ST25,ST26,ST27,ST28,ST31,ST32,ST33,
    ##     :       :            ST34,ST35,ST36,ST37,ST38,ST39,
    ##     :       :            ST40}: Lodgepole Pine (0)
    ##     :       SoilType in {ST16,ST19,ST22,ST23}:
    ##     :       :...Elevation > 2921:
    ##     :       :   :...HorDistRoad > 4579:
    ##     :       :   :   :...HorDistFire <= 4843:
    ##     :       :   :   :   :...HorDistFire <= 1681: Lodgepole Pine (1)
    ##     :       :   :   :   :   HorDistFire > 1681: Spruce/Fir (32/1)
    ##     :       :   :   :   HorDistFire > 4843:
    ##     :       :   :   :   :...Hillshade12 <= 229: Spruce/Fir (1)
    ##     :       :   :   :       Hillshade12 > 229: Lodgepole Pine (3)
    ##     :       :   :   HorDistRoad <= 4579:
    ##     :       :   :   :...Hillshade15 > 166: Spruce/Fir (6)
    ##     :       :   :       Hillshade15 <= 166:
    ##     :       :   :       :...HorDistFire <= 2359:
    ##     :       :   :           :...HorDistRoad <= 743: Spruce/Fir (2)
    ##     :       :   :           :   HorDistRoad > 743:
    ##     :       :   :           :   :...HorDistToHydro <= 301: Lodgepole Pine (14)
    ##     :       :   :           :       HorDistToHydro > 301: Spruce/Fir (1)
    ##     :       :   :           HorDistFire > 2359:
    ##     :       :   :           :...Elevation > 2946: Spruce/Fir (6)
    ##     :       :   :               Elevation <= 2946:
    ##     :       :   :               :...HorDistRoad <= 2451: Spruce/Fir (1)
    ##     :       :   :                   HorDistRoad > 2451: Lodgepole Pine (4)
    ##     :       :   Elevation <= 2921:
    ##     :       :   :...HorDistFire <= 2599:
    ##     :       :       :...ClimateZone in {montane,montane dry,
    ##     :       :       :   :               subalpine}: Lodgepole Pine (56/7)
    ##     :       :       :   ClimateZone = montane and subalpine:
    ##     :       :       :   :...HorDistRoad > 2496: Aspen (2)
    ##     :       :       :       HorDistRoad <= 2496:
    ##     :       :       :       :...Aspect <= 341: Lodgepole Pine (4)
    ##     :       :       :           Aspect > 341: Spruce/Fir (1)
    ##     :       :       HorDistFire > 2599:
    ##     :       :       :...SoilType = ST19: Lodgepole Pine (0)
    ##     :       :           SoilType = ST22: Spruce/Fir (2)
    ##     :       :           SoilType in {ST16,ST23}:
    ##     :       :           :...HorDistFire > 3277:
    ##     :       :               :...HorDistFire <= 5520: Lodgepole Pine (25/1)
    ##     :       :               :   HorDistFire > 5520:
    ##     :       :               :   :...Hillshade15 <= 143: Lodgepole Pine (1)
    ##     :       :               :       Hillshade15 > 143: Spruce/Fir (5)
    ##     :       :               HorDistFire <= 3277:
    ##     :       :               :...Aspect > 302:
    ##     :       :                   :...VertDistToHydro <= -1: Spruce/Fir (1)
    ##     :       :                   :   VertDistToHydro > -1: Lodgepole Pine (6)
    ##     :       :                   Aspect <= 302:
    ##     :       :                   :...HorDistFire > 2774: Spruce/Fir (8)
    ##     :       :                       HorDistFire <= 2774:
    ##     :       :                       :...HorDistFire <= 2704: Spruce/Fir (4)
    ##     :       :                           HorDistFire > 2704: Lodgepole Pine (3)
    ##     :       SoilType in {ST07,ST08,ST09,ST12,ST18,ST20,ST24,ST29,ST30}:
    ##     :       :...HorDistRoad <= 285:
    ##     :           :...VertDistToHydro > 140: Aspen (1)
    ##     :           :   VertDistToHydro <= 140:
    ##     :           :   :...HorDistToHydro <= 127: Spruce/Fir (8)
    ##     :           :       HorDistToHydro > 127:
    ##     :           :       :...Aspect > 239: Spruce/Fir (2)
    ##     :           :           Aspect <= 239:
    ##     :           :           :...HorDistRoad <= 277: Lodgepole Pine (14/3)
    ##     :           :               HorDistRoad > 277: Spruce/Fir (2)
    ##     :           HorDistRoad > 285:
    ##     :           :...Elevation <= 2689:
    ##     :               :...HorDistRoad > 2872: Aspen (2)
    ##     :               :   HorDistRoad <= 2872:
    ##     :               :   :...Elevation > 2508: Lodgepole Pine (131/2)
    ##     :               :       Elevation <= 2508:
    ##     :               :       :...Aspect <= 87: Aspen (2)
    ##     :               :           Aspect > 87: Lodgepole Pine (2)
    ##     :               Elevation > 2689:
    ##     :               :...SoilType in {ST07,ST09,ST18,
    ##     :                   :            ST30}: Lodgepole Pine (138/10)
    ##     :                   SoilType = ST08:
    ##     :                   :...HorDistFire <= 3065: Spruce/Fir (1)
    ##     :                   :   HorDistFire > 3065: Lodgepole Pine (3)
    ##     :                   SoilType = ST24:
    ##     :                   :...VertDistToHydro <= 0: Spruce/Fir (1)
    ##     :                   :   VertDistToHydro > 0: Lodgepole Pine (14)
    ##     :                   SoilType = ST20:
    ##     :                   :...HorDistFire <= 1571: Spruce/Fir (6/1)
    ##     :                   :   HorDistFire > 1571:
    ##     :                   :   :...HorDistRoad <= 1221: Spruce/Fir (1)
    ##     :                   :       HorDistRoad > 1221:
    ##     :                   :       :...HorDistFire <= 6550: Lodgepole Pine (33/2)
    ##     :                   :           HorDistFire > 6550: Spruce/Fir (1)
    ##     :                   SoilType = ST29:
    ##     :                   :...Elevation <= 2888:
    ##     :                   :   :...HorDistRoad <= 3918: Lodgepole Pine (174/13)
    ##     :                   :   :   HorDistRoad > 3918:
    ##     :                   :   :   :...VertDistToHydro > 50: Spruce/Fir (5)
    ##     :                   :   :       VertDistToHydro <= 50:
    ##     :                   :   :       :...Elevation > 2830: Lodgepole Pine (8)
    ##     :                   :   :           Elevation <= 2830: [S1]
    ##     :                   :   Elevation > 2888:
    ##     :                   :   :...VertDistToHydro <= 29:
    ##     :                   :       :...HorDistRoad <= 553: Spruce/Fir (6)
    ##     :                   :       :   HorDistRoad > 553:
    ##     :                   :       :   :...Hillshade12 <= 200: Spruce/Fir (4)
    ##     :                   :       :       Hillshade12 > 200: Lodgepole Pine (148/48)
    ##     :                   :       VertDistToHydro > 29:
    ##     :                   :       :...Hillshade12 > 197: Lodgepole Pine (138/10)
    ##     :                   :           Hillshade12 <= 197:
    ##     :                   :           :...Elevation <= 2945: Lodgepole Pine (4)
    ##     :                   :               Elevation > 2945: [S2]
    ##     :                   SoilType = ST12:
    ##     :                   :...HorDistRoad > 2007: Lodgepole Pine (195/5)
    ##     :                       HorDistRoad <= 2007:
    ##     :                       :...VertDistToHydro > 14: Lodgepole Pine (43/3)
    ##     :                           VertDistToHydro <= 14:
    ##     :                           :...HorDistRoad <= 850: Spruce/Fir (4)
    ##     :                               HorDistRoad > 850:
    ##     :                               :...HorDistFire > 5419: Spruce/Fir (2)
    ##     :                                   HorDistFire <= 5419: [S3]
    ##     Elevation > 3008:
    ##     :...Elevation > 3071:
    ##         :...HorDistFire > 3252:
    ##         :   :...HorDistRoad <= 5190: Spruce/Fir (85/3)
    ##         :   :   HorDistRoad > 5190: Lodgepole Pine (1)
    ##         :   HorDistFire <= 3252:
    ##         :   :...HorDistToHydro <= 283:
    ##         :       :...HorDistRoad > 5279:
    ##         :       :   :...HorDistFire > 1914: Lodgepole Pine (23/1)
    ##         :       :   :   HorDistFire <= 1914:
    ##         :       :   :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,
    ##         :       :   :       :            ST08,ST09,ST10,ST11,ST12,ST13,ST14,
    ##         :       :   :       :            ST15,ST16,ST17,ST18,ST20,ST21,ST24,
    ##         :       :   :       :            ST25,ST26,ST27,ST28,ST30,ST31,ST32,
    ##         :       :   :       :            ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ##         :       :   :       :            ST40}: Spruce/Fir (2)
    ##         :       :   :       SoilType = ST19:
    ##         :       :   :       :...HorDistToHydro <= 127: Spruce/Fir (3)
    ##         :       :   :       :   HorDistToHydro > 127: Lodgepole Pine (1)
    ##         :       :   :       SoilType = ST23:
    ##         :       :   :       :...Slope <= 6: Spruce/Fir (3)
    ##         :       :   :       :   Slope > 6: Lodgepole Pine (1)
    ##         :       :   :       SoilType = ST29:
    ##         :       :   :       :...Elevation > 3230: Lodgepole Pine (4)
    ##         :       :   :       :   Elevation <= 3230:
    ##         :       :   :       :   :...Hillshade09 <= 233: Spruce/Fir (11)
    ##         :       :   :       :       Hillshade09 > 233: Lodgepole Pine (1)
    ##         :       :   :       SoilType = ST22:
    ##         :       :   :       :...VertDistToHydro <= -5: Lodgepole Pine (1)
    ##         :       :   :           VertDistToHydro > -5:
    ##         :       :   :           :...HorDistRoad > 5698: Spruce/Fir (18)
    ##         :       :   :               HorDistRoad <= 5698:
    ##         :       :   :               :...Hillshade09 > 224: Lodgepole Pine (2)
    ##         :       :   :                   Hillshade09 <= 224: [S4]
    ##         :       :   HorDistRoad <= 5279: [S5]
    ##         :       HorDistToHydro > 283:
    ##         :       :...Elevation > 3282:
    ##         :           :...HorDistRoad <= 1652:
    ##         :           :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,
    ##         :           :   :   :            ST08,ST09,ST10,ST11,ST12,ST13,ST14,
    ##         :           :   :   :            ST15,ST16,ST17,ST18,ST19,ST20,ST21,
    ##         :           :   :   :            ST24,ST25,ST26,ST27,ST28,ST30,ST31,
    ##         :           :   :   :            ST32,ST33,ST34,ST35,ST36,ST37,ST38,
    ##         :           :   :   :            ST39,ST40}: Spruce/Fir (0)
    ##         :           :   :   SoilType = ST23: Lodgepole Pine (2)
    ##         :           :   :   SoilType in {ST22,ST29}:
    ##         :           :   :   :...Hillshade12 <= 241: Spruce/Fir (9)
    ##         :           :   :       Hillshade12 > 241: Lodgepole Pine (1)
    ##         :           :   HorDistRoad > 1652:
    ##         :           :   :...Hillshade09 > 230: Krummholz (2)
    ##         :           :       Hillshade09 <= 230:
    ##         :           :       :...HorDistRoad <= 4026: Spruce/Fir (4)
    ##         :           :           HorDistRoad > 4026: Krummholz (2)
    ##         :           Elevation <= 3282:
    ##         :           :...Hillshade15 > 181:
    ##         :               :...Hillshade09 <= 141: Spruce/Fir (2)
    ##         :               :   Hillshade09 > 141: [S6]
    ##         :               Hillshade15 <= 181:
    ##         :               :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,
    ##         :                   :            ST08,ST09,ST10,ST11,ST12,ST13,ST14,
    ##         :                   :            ST15,ST16,ST17,ST18,ST19,ST21,ST24,
    ##         :                   :            ST25,ST26,ST27,ST28,ST31,ST32,ST33,
    ##         :                   :            ST34,ST35,ST36,ST37,ST38,ST39,
    ##         :                   :            ST40}: Spruce/Fir (7)
    ##         :                   SoilType = ST20:
    ##         :                   :...Slope <= 7: Lodgepole Pine (1)
    ##         :                   :   Slope > 7: Spruce/Fir (2)
    ##         :                   SoilType = ST23:
    ##         :                   :...HorDistRoad <= 1106: Lodgepole Pine (4)
    ##         :                   :   HorDistRoad > 1106:
    ##         :                   :   :...Slope <= 4: Lodgepole Pine (1)
    ##         :                   :       Slope > 4: Spruce/Fir (9)
    ##         :                   SoilType = ST22:
    ##         :                   :...Hillshade15 <= 101: Lodgepole Pine (3)
    ##         :                   :   Hillshade15 > 101:
    ##         :                   :   :...Hillshade15 > 168: Lodgepole Pine (3)
    ##         :                   :       Hillshade15 <= 168:
    ##         :                   :       :...Hillshade09 <= 196: Lodgepole Pine (1)
    ##         :                   :           Hillshade09 > 196: Spruce/Fir (27/4)
    ##         :                   SoilType = ST30:
    ##         :                   :...Elevation > 3208: Krummholz (1)
    ##         :                   :   Elevation <= 3208:
    ##         :                   :   :...Slope <= 15: Spruce/Fir (5)
    ##         :                   :       Slope > 15:
    ##         :                   :       :...Hillshade12 <= 171: Spruce/Fir (2)
    ##         :                   :           Hillshade12 > 171: Lodgepole Pine (4)
    ##         :                   SoilType = ST29:
    ##         :                   :...Slope <= 8: Lodgepole Pine (41/14)
    ##         :                       Slope > 8:
    ##         :                       :...HorDistRoad <= 932: Lodgepole Pine (5)
    ##         :                           HorDistRoad > 932:
    ##         :                           :...HorDistToHydro > 503: Spruce/Fir (25/2)
    ##         :                               HorDistToHydro <= 503:
    ##         :                               :...Hillshade09 > 248: Spruce/Fir (7)
    ##         :                                   Hillshade09 <= 248:
    ##         :                                   :...HorDistFire > 1890: [S7]
    ##         :                                       HorDistFire <= 1890:
    ##         :                                       :...Slope > 17: [S8]
    ##         :                                           Slope <= 17: [S9]
    ##         Elevation <= 3071:
    ##         :...HorDistToHydro > 566:
    ##             :...Hillshade12 <= 188: Spruce/Fir (2)
    ##             :   Hillshade12 > 188:
    ##             :   :...HorDistToHydro <= 708: Lodgepole Pine (35/1)
    ##             :       HorDistToHydro > 708:
    ##             :       :...HorDistRoad <= 3463: Spruce/Fir (2)
    ##             :           HorDistRoad > 3463: [S10]
    ##             HorDistToHydro <= 566:
    ##             :...HorDistRoad <= 3444:
    ##                 :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,
    ##                 :   :            ST10,ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,
    ##                 :   :            ST20,ST21,ST24,ST25,ST26,ST27,ST28,ST31,ST32,
    ##                 :   :            ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ##                 :   :            ST40}: Spruce/Fir (5)
    ##                 :   SoilType = ST19:
    ##                 :   :...Elevation <= 3030: Spruce/Fir (1)
    ##                 :   :   Elevation > 3030: Lodgepole Pine (1)
    ##                 :   SoilType = ST23:
    ##                 :   :...Elevation <= 3067: Spruce/Fir (21/1)
    ##                 :   :   Elevation > 3067: Lodgepole Pine (2)
    ##                 :   SoilType = ST22:
    ##                 :   :...HorDistRoad > 570: Spruce/Fir (9)
    ##                 :   :   HorDistRoad <= 570:
    ##                 :   :   :...Elevation <= 3029: Spruce/Fir (1)
    ##                 :   :       Elevation > 3029: Lodgepole Pine (4)
    ##                 :   SoilType = ST30:
    ##                 :   :...Elevation > 3043: Spruce/Fir (5)
    ##                 :   :   Elevation <= 3043:
    ##                 :   :   :...Elevation <= 3017: Spruce/Fir (1)
    ##                 :   :       Elevation > 3017: Lodgepole Pine (3)
    ##                 :   SoilType = ST29:
    ##                 :   :...Slope <= 8:
    ##                 :       :...HorDistRoad <= 1983:
    ##                 :       :   :...HorDistFire <= 2724: Lodgepole Pine (11)
    ##                 :       :   :   HorDistFire > 2724: Spruce/Fir (1)
    ##                 :       :   HorDistRoad > 1983:
    ##                 :       :   :...Hillshade15 <= 147: Spruce/Fir (7)
    ##                 :       :       Hillshade15 > 147: Lodgepole Pine (3)
    ##                 :       Slope > 8:
    ##                 :       :...VertDistToHydro > 12: Spruce/Fir (18)
    ##                 :           VertDistToHydro <= 12:
    ##                 :           :...HorDistToHydro > 242: Lodgepole Pine (5)
    ##                 :               HorDistToHydro <= 242:
    ##                 :               :...Aspect <= 94: Spruce/Fir (11)
    ##                 :                   Aspect > 94: [S11]
    ##                 HorDistRoad > 3444:
    ##                 :...Hillshade12 <= 193: Spruce/Fir (8)
    ##                     Hillshade12 > 193: [S12]
    ## 
    ## SubTree [S1]
    ## 
    ## Hillshade12 <= 169: Lodgepole Pine (1)
    ## Hillshade12 > 169: Spruce/Fir (2)
    ## 
    ## SubTree [S2]
    ## 
    ## VertDistToHydro <= 132: Spruce/Fir (7)
    ## VertDistToHydro > 132: Lodgepole Pine (1)
    ## 
    ## SubTree [S3]
    ## 
    ## HorDistFire > 2973: Lodgepole Pine (6)
    ## HorDistFire <= 2973:
    ## :...VertDistToHydro > 7: Spruce/Fir (5)
    ##     VertDistToHydro <= 7:
    ##     :...HorDistFire > 2008: Lodgepole Pine (5)
    ##         HorDistFire <= 2008:
    ##         :...HorDistRoad > 1639: Lodgepole Pine (4)
    ##             HorDistRoad <= 1639:
    ##             :...HorDistRoad <= 1165: Lodgepole Pine (2)
    ##                 HorDistRoad > 1165: Spruce/Fir (6)
    ## 
    ## SubTree [S4]
    ## 
    ## VertDistToHydro <= 18: Spruce/Fir (5)
    ## VertDistToHydro > 18: Lodgepole Pine (1)
    ## 
    ## SubTree [S5]
    ## 
    ## GeologicZone in {alluvium,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Spruce/Fir (3)
    ## GeologicZone = glacial:
    ## :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,ST11,ST12,
    ## :   :            ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST24,ST25,ST26,
    ## :   :            ST27,ST28,ST29,ST30,ST31,ST32,ST33,ST34,ST35,ST36,ST37,ST38,
    ## :   :            ST39,ST40}: Spruce/Fir (0)
    ## :   SoilType = ST22:
    ## :   :...HorDistFire > 3231: Lodgepole Pine (2)
    ## :   :   HorDistFire <= 3231:
    ## :   :   :...HorDistRoad > 1126: Spruce/Fir (44)
    ## :   :       HorDistRoad <= 1126:
    ## :   :       :...VertDistToHydro > 32: Lodgepole Pine (2)
    ## :   :           VertDistToHydro <= 32:
    ## :   :           :...HorDistToHydro <= 30: Lodgepole Pine (1)
    ## :   :               HorDistToHydro > 30: Spruce/Fir (9)
    ## :   SoilType = ST23:
    ## :   :...Elevation > 3267:
    ## :       :...Elevation <= 3273: Lodgepole Pine (1)
    ## :       :   Elevation > 3273: Krummholz (1)
    ## :       Elevation <= 3267:
    ## :       :...Hillshade09 > 224: Spruce/Fir (41/1)
    ## :           Hillshade09 <= 224:
    ## :           :...VertDistToHydro > 4: Spruce/Fir (18)
    ## :               VertDistToHydro <= 4:
    ## :               :...HorDistFire <= 1531: Spruce/Fir (9)
    ## :                   HorDistFire > 1531:
    ## :                   :...Hillshade15 <= 151:
    ## :                       :...HorDistRoad <= 1455: Spruce/Fir (1)
    ## :                       :   HorDistRoad > 1455: Lodgepole Pine (5)
    ## :                       Hillshade15 > 151:
    ## :                       :...Aspect <= 326: Spruce/Fir (5)
    ## :                           Aspect > 326: Lodgepole Pine (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistFire <= 1008:
    ##     :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,ST11,
    ##     :   :            ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,
    ##     :   :            ST23,ST24,ST25,ST26,ST27,ST28,ST31,ST32,ST33,ST34,ST35,
    ##     :   :            ST36,ST37,ST38,ST39,ST40}: Lodgepole Pine (0)
    ##     :   SoilType = ST30: Spruce/Fir (1)
    ##     :   SoilType = ST29:
    ##     :   :...Elevation > 3244: Lodgepole Pine (6)
    ##     :       Elevation <= 3244:
    ##     :       :...Aspect <= 80: Lodgepole Pine (5)
    ##     :           Aspect > 80:
    ##     :           :...Hillshade12 > 239: Lodgepole Pine (2)
    ##     :               Hillshade12 <= 239:
    ##     :               :...HorDistFire <= 258: Lodgepole Pine (1)
    ##     :                   HorDistFire > 258:
    ##     :                   :...VertDistToHydro <= 30: Spruce/Fir (9)
    ##     :                       VertDistToHydro > 30: Lodgepole Pine (1)
    ##     HorDistFire > 1008:
    ##     :...Elevation > 3139:
    ##         :...Hillshade12 <= 229: Spruce/Fir (60/3)
    ##         :   Hillshade12 > 229:
    ##         :   :...VertDistToHydro <= 1:
    ##         :       :...Aspect <= 78: Lodgepole Pine (1)
    ##         :       :   Aspect > 78: Krummholz (3)
    ##         :       VertDistToHydro > 1:
    ##         :       :...HorDistFire > 1194: Spruce/Fir (26/4)
    ##         :           HorDistFire <= 1194:
    ##         :           :...Elevation <= 3206: Spruce/Fir (2)
    ##         :               Elevation > 3206: Lodgepole Pine (2)
    ##         Elevation <= 3139:
    ##         :...Slope > 15: Spruce/Fir (20/1)
    ##             Slope <= 15:
    ##             :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,
    ##                 :            ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,
    ##                 :            ST21,ST22,ST23,ST24,ST25,ST26,ST27,ST28,ST31,ST32,
    ##                 :            ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ##                 :            ST40}: Spruce/Fir (2)
    ##                 SoilType = ST30:
    ##                 :...Hillshade15 > 160: Lodgepole Pine (1)
    ##                 :   Hillshade15 <= 160:
    ##                 :   :...VertDistToHydro <= -6: Lodgepole Pine (1)
    ##                 :       VertDistToHydro > -6: Spruce/Fir (4)
    ##                 SoilType = ST29:
    ##                 :...HorDistFire <= 1956:
    ##                     :...Hillshade12 <= 245: Spruce/Fir (20/2)
    ##                     :   Hillshade12 > 245: Lodgepole Pine (1)
    ##                     HorDistFire > 1956:
    ##                     :...HorDistToHydro <= 127: Lodgepole Pine (7)
    ##                         HorDistToHydro > 127:
    ##                         :...HorDistToHydro > 234: Lodgepole Pine (4)
    ##                             HorDistToHydro <= 234:
    ##                             :...Slope <= 7: Lodgepole Pine (3)
    ##                                 Slope > 7:
    ##                                 :...Hillshade15 <= 139: Spruce/Fir (9/1)
    ##                                     Hillshade15 > 139: [S13]
    ## 
    ## SubTree [S6]
    ## 
    ## GeologicZone in {alluvium,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone = glacial:
    ## :...Elevation <= 3179: Lodgepole Pine (2)
    ## :   Elevation > 3179: Spruce/Fir (2)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistRoad <= 1855: Spruce/Fir (1)
    ##     HorDistRoad > 1855: Lodgepole Pine (24)
    ## 
    ## SubTree [S7]
    ## 
    ## Hillshade12 <= 204: Spruce/Fir (3)
    ## Hillshade12 > 204:
    ## :...Hillshade15 > 117: Lodgepole Pine (12)
    ##     Hillshade15 <= 117:
    ##     :...Elevation <= 3183: Lodgepole Pine (2)
    ##         Elevation > 3183: Spruce/Fir (2)
    ## 
    ## SubTree [S8]
    ## 
    ## Hillshade12 > 208: Lodgepole Pine (6)
    ## Hillshade12 <= 208:
    ## :...Hillshade09 <= 224: Lodgepole Pine (1)
    ##     Hillshade09 > 224: Spruce/Fir (3)
    ## 
    ## SubTree [S9]
    ## 
    ## HorDistRoad > 4794: Spruce/Fir (10)
    ## HorDistRoad <= 4794:
    ## :...Slope > 14: Spruce/Fir (3)
    ##     Slope <= 14:
    ##     :...HorDistRoad <= 1813: Spruce/Fir (4)
    ##         HorDistRoad > 1813:
    ##         :...Hillshade09 <= 209: Spruce/Fir (2)
    ##             Hillshade09 > 209: Lodgepole Pine (6)
    ## 
    ## SubTree [S10]
    ## 
    ## ClimateZone in {montane and subalpine,montane dry,
    ## :               subalpine}: Lodgepole Pine (13/1)
    ## ClimateZone = montane:
    ## :...Elevation <= 3035: Spruce/Fir (2)
    ##     Elevation > 3035: Lodgepole Pine (3)
    ## 
    ## SubTree [S11]
    ## 
    ## HorDistToHydro > 95: Lodgepole Pine (3)
    ## HorDistToHydro <= 95:
    ## :...VertDistToHydro <= -8: Lodgepole Pine (1)
    ##     VertDistToHydro > -8: Spruce/Fir (5)
    ## 
    ## SubTree [S12]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone = alluvium:
    ## :...Slope <= 7: Lodgepole Pine (2)
    ## :   Slope > 7: Spruce/Fir (1)
    ## GeologicZone = glacial:
    ## :...Hillshade15 <= 138: Lodgepole Pine (3)
    ## :   Hillshade15 > 138:
    ## :   :...Hillshade12 <= 230: Lodgepole Pine (1)
    ## :       Hillshade12 > 230:
    ## :       :...Slope <= 10: Spruce/Fir (7)
    ## :           Slope > 10: Lodgepole Pine (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...ClimateZone in {montane and subalpine,
    ##     :               montane dry}: Lodgepole Pine (0)
    ##     ClimateZone = montane:
    ##     :...Hillshade15 <= 138: Spruce/Fir (2)
    ##     :   Hillshade15 > 138: Lodgepole Pine (1)
    ##     ClimateZone = subalpine:
    ##     :...Slope <= 8:
    ##         :...Hillshade09 <= 202: Spruce/Fir (1)
    ##         :   Hillshade09 > 202: Lodgepole Pine (27)
    ##         Slope > 8:
    ##         :...Hillshade09 > 232: Lodgepole Pine (21/2)
    ##             Hillshade09 <= 232:
    ##             :...HorDistFire > 4820: Lodgepole Pine (6)
    ##                 HorDistFire <= 4820:
    ##                 :...Hillshade12 > 249: Lodgepole Pine (5)
    ##                     Hillshade12 <= 249:
    ##                     :...HorDistFire > 3601: Spruce/Fir (10)
    ##                         HorDistFire <= 3601:
    ##                         :...HorDistRoad > 5831: Spruce/Fir (5)
    ##                             HorDistRoad <= 5831:
    ##                             :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,
    ##                                 :            ST07,ST08,ST09,ST10,ST11,ST12,
    ##                                 :            ST13,ST14,ST15,ST16,ST17,ST18,
    ##                                 :            ST19,ST20,ST21,ST22,ST23,ST25,
    ##                                 :            ST26,ST27,ST28,ST31,ST32,ST33,
    ##                                 :            ST34,ST35,ST36,ST37,ST38,ST39,
    ##                                 :            ST40}: Lodgepole Pine (0)
    ##                                 SoilType = ST24:
    ##                                 :...Elevation <= 3034: Lodgepole Pine (1)
    ##                                 :   Elevation > 3034: Spruce/Fir (1)
    ##                                 SoilType = ST30:
    ##                                 :...HorDistRoad > 5285: Lodgepole Pine (1)
    ##                                 :   HorDistRoad <= 5285: [S14]
    ##                                 SoilType = ST29:
    ##                                 :...VertDistToHydro > 24: Lodgepole Pine (7)
    ##                                     VertDistToHydro <= 24:
    ##                                     :...Elevation <= 3024: Spruce/Fir (4)
    ##                                         Elevation > 3024:
    ##                                         :...Slope <= 13: Lodgepole Pine (4)
    ##                                             Slope > 13: [S15]
    ## 
    ## SubTree [S13]
    ## 
    ## VertDistToHydro <= 46: Lodgepole Pine (2)
    ## VertDistToHydro > 46: Spruce/Fir (1)
    ## 
    ## SubTree [S14]
    ## 
    ## VertDistToHydro <= 13: Lodgepole Pine (1)
    ## VertDistToHydro > 13: Spruce/Fir (4)
    ## 
    ## SubTree [S15]
    ## 
    ## HorDistRoad <= 3837: Lodgepole Pine (1)
    ## HorDistRoad > 3837: Spruce/Fir (3)
    ## 
    ## 
    ## Evaluation on training data (2607 cases):
    ## 
    ##      Decision Tree   
    ##    ----------------  
    ##    Size      Errors  
    ## 
    ##     239  156( 6.0%)   <<
    ## 
    ## 
    ##     (a)   (b)   (c)   (d)   (e)   (f)   (g)    <-classified as
    ##    ----  ----  ----  ----  ----  ----  ----
    ##     936   115                             3    (a): class Spruce/Fir
    ##      18  1457                                  (b): class Lodgepole Pine
    ##                                                (c): class Ponderosa Pine
    ##                                                (d): class Cottonwood/Willow
    ##            10                23                (e): class Aspen
    ##                                                (f): class Douglas-fir
    ##      10                                  35    (g): class Krummholz
    ## 
    ## 
    ##  Attribute usage:
    ## 
    ##  100.00% ClimateZone
    ##   94.90% Elevation
    ##   84.81% HorDistRoad
    ##   76.45% SoilType
    ##   64.02% Hillshade15
    ##   49.21% HorDistFire
    ##   42.92% HorDistToHydro
    ##   25.89% VertDistToHydro
    ##   25.58% Hillshade12
    ##   18.64% GeologicZone
    ##   17.68% Slope
    ##   13.16% Hillshade09
    ##    3.72% Aspect
    ## 
    ## 
    ## Time: 0.0 secs

1.  WildArea WA\_NWA

``` r
# bar <- subset(foo, location == "there")
covtype_WA_NWA = subset(covtype, covtype$WildArea == "WA_NWA")
rows <- nrow(covtype_WA_NWA)
covtypeSample_WA_NWA <- covtype_WA_NWA[sample(rows,rows/100), ]

covtypeSample_WA_NWA$WildArea <- NULL
modelCT <- C5.0(Class ~ ., data=covtypeSample_WA_NWA, control = C5.0Control(noGlobalPruning = TRUE, minCases=1))
#plot(modelCT50, main="C5.0 Decision Tree - Unpruned, min=1")
summary(modelCT)
```

    ## 
    ## Call:
    ## C5.0.formula(formula = Class ~ ., data = covtypeSample_WA_NWA, control
    ##  = C5.0Control(noGlobalPruning = TRUE, minCases = 1))
    ## 
    ## 
    ## C5.0 [Release 2.07 GPL Edition]      Fri Aug 25 10:42:56 2017
    ## -------------------------------
    ## 
    ## Class specified by attribute `outcome'
    ## 
    ## Read 298 cases (14 attributes) from undefined.data
    ## 
    ## Decision tree:
    ## 
    ## ClimateZone in {lower montane,lower montane dry,montane dry,
    ## :               montane dry and montane}: Spruce/Fir (0)
    ## ClimateZone = alpine:
    ## :...Hillshade15 <= 103:
    ## :   :...Aspect <= 126: Krummholz (11)
    ## :   :   Aspect > 126: Lodgepole Pine (1)
    ## :   Hillshade15 > 103:
    ## :   :...HorDistFire <= 979: Krummholz (5)
    ## :       HorDistFire > 979:
    ## :       :...Elevation > 3469: Krummholz (4)
    ## :           Elevation <= 3469:
    ## :           :...Elevation > 3298: Spruce/Fir (24/1)
    ## :               Elevation <= 3298:
    ## :               :...HorDistFire > 1954: Lodgepole Pine (4)
    ## :                   HorDistFire <= 1954:
    ## :                   :...HorDistRoad <= 726: Lodgepole Pine (2)
    ## :                       HorDistRoad > 726: Spruce/Fir (6)
    ## ClimateZone in {montane,montane and subalpine,subalpine}:
    ## :...VertDistToHydro <= -26: Lodgepole Pine (8)
    ##     VertDistToHydro > -26:
    ##     :...Hillshade15 <= 100:
    ##         :...HorDistFire <= 1203:
    ##         :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,
    ##         :   :   :            ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,
    ##         :   :   :            ST21,ST22,ST23,ST25,ST26,ST27,ST28,ST29,ST30,ST31,
    ##         :   :   :            ST32,ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ##         :   :   :            ST40}: Lodgepole Pine (3)
    ##         :   :   SoilType = ST24:
    ##         :   :   :...Elevation <= 3298: Lodgepole Pine (2)
    ##         :   :       Elevation > 3298: Krummholz (3)
    ##         :   HorDistFire > 1203: [S1]
    ##         Hillshade15 > 100:
    ##         :...Aspect > 225:
    ##             :...Elevation > 3088: Spruce/Fir (95/8)
    ##             :   Elevation <= 3088:
    ##             :   :...HorDistToHydro > 255: Lodgepole Pine (6)
    ##             :       HorDistToHydro <= 255:
    ##             :       :...Hillshade12 <= 223: Lodgepole Pine (1)
    ##             :           Hillshade12 > 223: Spruce/Fir (6)
    ##             Aspect <= 225:
    ##             :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,
    ##                 :            ST11,ST12,ST13,ST14,ST15,ST17,ST18,ST19,ST20,ST21,
    ##                 :            ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST34,ST35,ST36,
    ##                 :            ST37,ST38,ST39,ST40}: Spruce/Fir (11)
    ##                 SoilType in {ST16,ST24}: Lodgepole Pine (7)
    ##                 SoilType = ST33:
    ##                 :...Hillshade09 <= 202: Lodgepole Pine (4)
    ##                 :   Hillshade09 > 202: Spruce/Fir (7)
    ##                 SoilType = ST22:
    ##                 :...Aspect <= 135:
    ##                 :   :...HorDistToHydro <= 663: Spruce/Fir (12)
    ##                 :   :   HorDistToHydro > 663: Lodgepole Pine (1)
    ##                 :   Aspect > 135:
    ##                 :   :...HorDistFire <= 3989: Spruce/Fir (1)
    ##                 :       HorDistFire > 3989: Lodgepole Pine (4)
    ##                 SoilType = ST32:
    ##                 :...Hillshade12 <= 229:
    ##                 :   :...Hillshade12 <= 213: Spruce/Fir (1)
    ##                 :   :   Hillshade12 > 213: Lodgepole Pine (5)
    ##                 :   Hillshade12 > 229:
    ##                 :   :...Hillshade09 <= 199: Lodgepole Pine (1)
    ##                 :       Hillshade09 > 199: Spruce/Fir (9)
    ##                 SoilType = ST23:
    ##                 :...Elevation > 3220: Lodgepole Pine (11/1)
    ##                     Elevation <= 3220:
    ##                     :...Elevation <= 3148:
    ##                         :...VertDistToHydro <= 3: Spruce/Fir (1)
    ##                         :   VertDistToHydro > 3: Lodgepole Pine (7)
    ##                         Elevation > 3148:
    ##                         :...Slope > 7: Spruce/Fir (14)
    ##                             Slope <= 7:
    ##                             :...Hillshade12 <= 226: Lodgepole Pine (2)
    ##                                 Hillshade12 > 226: Spruce/Fir (4)
    ## 
    ## SubTree [S1]
    ## 
    ## GeologicZone in {alluvium,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,volcanic}: Spruce/Fir (0)
    ## GeologicZone = glacial:
    ## :...VertDistToHydro <= 50: Spruce/Fir (3)
    ## :   VertDistToHydro > 50: Lodgepole Pine (2)
    ## GeologicZone = igneous and metamorphic:
    ## :...HorDistRoad <= 2481: Spruce/Fir (9)
    ##     HorDistRoad > 2481: Krummholz (1)
    ## 
    ## 
    ## Evaluation on training data (298 cases):
    ## 
    ##      Decision Tree   
    ##    ----------------  
    ##    Size      Errors  
    ## 
    ##      38   10( 3.4%)   <<
    ## 
    ## 
    ##     (a)   (b)   (c)   (d)   (e)   (f)   (g)    <-classified as
    ##    ----  ----  ----  ----  ----  ----  ----
    ##     194     1                                  (a): class Spruce/Fir
    ##       8    70                                  (b): class Lodgepole Pine
    ##                                                (c): class Ponderosa Pine
    ##                                                (d): class Cottonwood/Willow
    ##                                                (e): class Aspen
    ##                                                (f): class Douglas-fir
    ##       1                                  24    (g): class Krummholz
    ## 
    ## 
    ##  Attribute usage:
    ## 
    ##  100.00% ClimateZone
    ##   97.32% Hillshade15
    ##   80.87% VertDistToHydro
    ##   74.50% Aspect
    ##   64.43% Elevation
    ##   36.91% SoilType
    ##   24.50% HorDistFire
    ##    9.73% Hillshade12
    ##    8.72% HorDistToHydro
    ##    7.05% Hillshade09
    ##    6.71% Slope
    ##    6.04% HorDistRoad
    ##    5.03% GeologicZone
    ## 
    ## 
    ## Time: 0.0 secs

1.  WildArea WA\_CPWA

``` r
covtype_WA_CPWA = subset(covtype, covtype$WildArea == "WA_CPWA")
rows <- nrow(covtype_WA_CPWA)
covtypeSample_WA_CPWA <- covtype_WA_CPWA[sample(rows,rows/100), ]

covtypeSample_WA_NWA$WildArea <- NULL
modelCT <- C5.0(Class ~ ., data=covtypeSample_WA_CPWA, control = C5.0Control(noGlobalPruning = TRUE, minCases=1))
#plot(modelCT50, main="C5.0 Decision Tree - Unpruned, min=1")
summary(modelCT)
```

    ## 
    ## Call:
    ## C5.0.formula(formula = Class ~ ., data = covtypeSample_WA_CPWA, control
    ##  = C5.0Control(noGlobalPruning = TRUE, minCases = 1))
    ## 
    ## 
    ## C5.0 [Release 2.07 GPL Edition]      Fri Aug 25 10:42:56 2017
    ## -------------------------------
    ## 
    ## Class specified by attribute `outcome'
    ## 
    ## Read 2533 cases (15 attributes) from undefined.data
    ## 
    ## Decision tree:
    ## 
    ## ClimateZone in {lower montane dry,montane dry}: Lodgepole Pine (0)
    ## ClimateZone = alpine:
    ## :...Elevation <= 3228:
    ## :   :...HorDistToHydro <= 537: Spruce/Fir (15)
    ## :   :   HorDistToHydro > 537: Lodgepole Pine (1)
    ## :   Elevation > 3228:
    ## :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,ST11,
    ## :       :            ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,
    ## :       :            ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,
    ## :       :            ST34}: Krummholz (0)
    ## :       SoilType = ST36:
    ## :       :...Elevation <= 3367: Lodgepole Pine (2)
    ## :       :   Elevation > 3367: Krummholz (2)
    ## :       SoilType in {ST35,ST37,ST38,ST39,ST40}:
    ## :       :...HorDistFire <= 351:
    ## :           :...SoilType = ST35: Krummholz (2)
    ## :           :   SoilType in {ST37,ST38,ST39,ST40}: Spruce/Fir (8)
    ## :           HorDistFire > 351:
    ## :           :...HorDistFire > 2995:
    ## :               :...Slope <= 20: Krummholz (16)
    ## :               :   Slope > 20: Lodgepole Pine (1)
    ## :               HorDistFire <= 2995:
    ## :               :...SoilType in {ST35,ST37}: Krummholz (3)
    ## :                   SoilType = ST40:
    ## :                   :...Slope <= 6: Spruce/Fir (2)
    ## :                   :   Slope > 6: Krummholz (12/2)
    ## :                   SoilType = ST38:
    ## :                   :...HorDistRoad > 4341: Spruce/Fir (3)
    ## :                   :   HorDistRoad <= 4341:
    ## :                   :   :...Hillshade12 <= 241: Krummholz (31)
    ## :                   :       Hillshade12 > 241:
    ## :                   :       :...Slope <= 6:
    ## :                   :           :...HorDistFire <= 1452: Spruce/Fir (3)
    ## :                   :           :   HorDistFire > 1452: Krummholz (1)
    ## :                   :           Slope > 6:
    ## :                   :           :...Hillshade12 <= 251: Krummholz (10/1)
    ## :                   :               Hillshade12 > 251: Spruce/Fir (1)
    ## :                   SoilType = ST39:
    ## :                   :...Hillshade09 > 194: Krummholz (34/3)
    ## :                       Hillshade09 <= 194:
    ## :                       :...Hillshade15 <= 165: Spruce/Fir (4)
    ## :                           Hillshade15 > 165:
    ## :                           :...HorDistRoad <= 2673: Krummholz (5)
    ## :                               HorDistRoad > 2673:
    ## :                               :...Elevation <= 3280: Krummholz (1)
    ## :                                   Elevation > 3280: Spruce/Fir (2)
    ## ClimateZone in {lower montane,montane,montane and subalpine,
    ## :               montane dry and montane}:
    ## :...Elevation <= 2696:
    ## :   :...HorDistRoad > 2758:
    ## :   :   :...HorDistFire > 2594:
    ## :   :   :   :...Aspect <= 223: Spruce/Fir (8)
    ## :   :   :   :   Aspect > 223: Lodgepole Pine (1)
    ## :   :   :   HorDistFire <= 2594:
    ## :   :   :   :...SoilType = ST11: Lodgepole Pine (4)
    ## :   :   :       SoilType = ST13: Aspen (2)
    ## :   :   :       SoilType in {ST01,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,ST12,
    ## :   :   :       :            ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,ST23,
    ## :   :   :       :            ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,
    ## :   :   :       :            ST34,ST35,ST36,ST37,ST38,ST39,
    ## :   :   :       :            ST40}: Ponderosa Pine (1)
    ## :   :   :       SoilType = ST02:
    ## :   :   :       :...Elevation <= 2587: Lodgepole Pine (1)
    ## :   :   :           Elevation > 2587: Aspen (1)
    ## :   :   HorDistRoad <= 2758:
    ## :   :   :...ClimateZone = lower montane:
    ## :   :       :...Aspect <= 76:
    ## :   :       :   :...Hillshade15 <= 136: Douglas-fir (10/3)
    ## :   :       :   :   Hillshade15 > 136:
    ## :   :       :   :   :...Hillshade12 > 231: Douglas-fir (1)
    ## :   :       :   :       Hillshade12 <= 231:
    ## :   :       :   :       :...Elevation <= 2541: Ponderosa Pine (1)
    ## :   :       :   :           Elevation > 2541: Lodgepole Pine (3)
    ## :   :       :   Aspect > 76:
    ## :   :       :   :...HorDistRoad <= 67: Douglas-fir (2)
    ## :   :       :       HorDistRoad > 67:
    ## :   :       :       :...SoilType in {ST01,ST05,ST06,ST07,ST08,ST09,ST10,ST11,
    ## :   :       :           :            ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,
    ## :   :       :           :            ST20,ST21,ST22,ST23,ST24,ST25,ST26,ST27,
    ## :   :       :           :            ST28,ST29,ST30,ST31,ST32,ST33,ST34,ST35,
    ## :   :       :           :            ST36,ST37,ST38,ST39,
    ## :   :       :           :            ST40}: Ponderosa Pine (0)
    ## :   :       :           SoilType = ST03:
    ## :   :       :           :...Elevation <= 2556: Ponderosa Pine (6)
    ## :   :       :           :   Elevation > 2556:
    ## :   :       :           :   :...HorDistRoad <= 1484: Lodgepole Pine (8)
    ## :   :       :           :       HorDistRoad > 1484: Ponderosa Pine (2)
    ## :   :       :           SoilType in {ST02,ST04}:
    ## :   :       :           :...HorDistToHydro > 90:
    ## :   :       :               :...Hillshade12 <= 180: Douglas-fir (1)
    ## :   :       :               :   Hillshade12 > 180: Ponderosa Pine (84/4)
    ## :   :       :               HorDistToHydro <= 90:
    ## :   :       :               :...Elevation > 2653: Lodgepole Pine (4)
    ## :   :       :                   Elevation <= 2653:
    ## :   :       :                   :...SoilType = ST04:
    ## :   :       :                       :...Aspect <= 274: Ponderosa Pine (7)
    ## :   :       :                       :   Aspect > 274: Douglas-fir (1)
    ## :   :       :                       SoilType = ST02:
    ## :   :       :                       :...Elevation > 2567: Ponderosa Pine (1)
    ## :   :       :                           Elevation <= 2567:
    ## :   :       :                           :...Slope <= 14: Douglas-fir (1)
    ## :   :       :                               Slope > 14: Lodgepole Pine (3)
    ## :   :       ClimateZone in {montane,montane and subalpine,
    ## :   :       :               montane dry and montane}: [S1]
    ## :   Elevation > 2696:
    ## :   :...ClimateZone = montane dry and montane: Lodgepole Pine (0)
    ## :       ClimateZone = montane and subalpine:
    ## :       :...HorDistRoad <= 1095:
    ## :       :   :...Hillshade09 <= 225: Spruce/Fir (1)
    ## :       :   :   Hillshade09 > 225: Aspen (2)
    ## :       :   HorDistRoad > 1095:
    ## :       :   :...HorDistToHydro > 433: Aspen (3)
    ## :       :       HorDistToHydro <= 433:
    ## :       :       :...HorDistToHydro > 30: Lodgepole Pine (6)
    ## :       :           HorDistToHydro <= 30:
    ## :       :           :...HorDistFire <= 2373: Aspen (4)
    ## :       :               HorDistFire > 2373: Lodgepole Pine (3)
    ## :       ClimateZone = lower montane:
    ## :       :...VertDistToHydro > 196: Krummholz (3)
    ## :       :   VertDistToHydro <= 196:
    ## :       :   :...Aspect > 259: Aspen (3)
    ## :       :       Aspect <= 259:
    ## :       :       :...SoilType in {ST01,ST05,ST06,ST07,ST08,ST09,ST10,ST11,ST12,
    ## :       :           :            ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,
    ## :       :           :            ST22,ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST30,
    ## :       :           :            ST31,ST32,ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ## :       :           :            ST40}: Lodgepole Pine (0)
    ## :       :           SoilType = ST02: Ponderosa Pine (4)
    ## :       :           SoilType in {ST03,ST04}:
    ## :       :           :...HorDistFire <= 2188: Lodgepole Pine (37/3)
    ## :       :               HorDistFire > 2188:
    ## :       :               :...Elevation <= 2790: Ponderosa Pine (2)
    ## :       :                   Elevation > 2790: Aspen (1)
    ## :       ClimateZone = montane:
    ## :       :...Aspect > 301:
    ## :           :...HorDistFire > 1851:
    ## :           :   :...HorDistToHydro > 404: Ponderosa Pine (1)
    ## :           :   :   HorDistToHydro <= 404:
    ## :           :   :   :...Elevation <= 2712: Lodgepole Pine (1)
    ## :           :   :       Elevation > 2712: Douglas-fir (5)
    ## :           :   HorDistFire <= 1851:
    ## :           :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,
    ## :           :       :            ST12,ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,
    ## :           :       :            ST22,ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST30,
    ## :           :       :            ST31,ST32,ST33,ST34,ST35,ST36,ST37,ST38,ST39,
    ## :           :       :            ST40}: Lodgepole Pine (0)
    ## :           :       SoilType = ST10:
    ## :           :       :...Hillshade15 <= 169: Lodgepole Pine (6)
    ## :           :       :   Hillshade15 > 169:
    ## :           :       :   :...HorDistFire <= 808: Lodgepole Pine (1)
    ## :           :       :       HorDistFire > 808: Aspen (2)
    ## :           :       SoilType in {ST11,ST13}:
    ## :           :       :...Hillshade12 <= 221: Spruce/Fir (2)
    ## :           :           Hillshade12 > 221:
    ## :           :           :...VertDistToHydro <= 48: Spruce/Fir (1)
    ## :           :               VertDistToHydro > 48: Aspen (3)
    ## :           Aspect <= 301:
    ## :           :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST12,
    ## :               :            ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,ST23,
    ## :               :            ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,
    ## :               :            ST34,ST35,ST36,ST37,ST38,ST39,
    ## :               :            ST40}: Lodgepole Pine (0)
    ## :               SoilType = ST10:
    ## :               :...HorDistFire > 2274: Spruce/Fir (5)
    ## :               :   HorDistFire <= 2274:
    ## :               :   :...Aspect > 26: Lodgepole Pine (41/4)
    ## :               :       Aspect <= 26:
    ## :               :       :...VertDistToHydro > 26: Lodgepole Pine (6)
    ## :               :           VertDistToHydro <= 26:
    ## :               :           :...VertDistToHydro <= 7: Lodgepole Pine (1)
    ## :               :               VertDistToHydro > 7: Spruce/Fir (3)
    ## :               SoilType in {ST11,ST13}:
    ## :               :...Hillshade09 > 244:
    ## :                   :...SoilType = ST11: Lodgepole Pine (1)
    ## :                   :   SoilType = ST13:
    ## :                   :   :...Hillshade09 <= 246: Aspen (3)
    ## :                   :       Hillshade09 > 246:
    ## :                   :       :...Hillshade09 <= 250: Lodgepole Pine (5)
    ## :                   :           Hillshade09 > 250:
    ## :                   :           :...Elevation <= 2821: Lodgepole Pine (3)
    ## :                   :               Elevation > 2821: [S2]
    ## :                   Hillshade09 <= 244:
    ## :                   :...SoilType = ST11:
    ## :                       :...HorDistRoad > 2095:
    ## :                       :   :...Hillshade09 <= 232: Ponderosa Pine (1)
    ## :                       :   :   Hillshade09 > 232: Aspen (2)
    ## :                       :   HorDistRoad <= 2095:
    ## :                       :   :...Hillshade15 <= 128: Lodgepole Pine (34)
    ## :                       :       Hillshade15 > 128:
    ## :                       :       :...VertDistToHydro <= 29: [S3]
    ## :                       :           VertDistToHydro > 29:
    ## :                       :           :...VertDistToHydro <= 41: Spruce/Fir (2)
    ## :                       :               VertDistToHydro > 41:
    ## :                       :               :...Slope > 11: Lodgepole Pine (2)
    ## :                       :                   Slope <= 11: [S4]
    ## :                       SoilType = ST13:
    ## :                       :...HorDistRoad <= 451: Aspen (3)
    ## :                           HorDistRoad > 451:
    ## :                           :...Slope > 21: Lodgepole Pine (60/3)
    ## :                               Slope <= 21:
    ## :                               :...VertDistToHydro <= 64:
    ## :                                   :...Hillshade12 <= 223: Spruce/Fir (2)
    ## :                                   :   Hillshade12 > 223: [S5]
    ## :                                   VertDistToHydro > 64:
    ## :                                   :...Hillshade09 <= 163: Spruce/Fir (2)
    ## :                                       Hillshade09 > 163: [S6]
    ## ClimateZone = subalpine:
    ## :...Elevation > 3054:
    ##     :...HorDistFire > 3433:
    ##     :   :...Elevation > 3349: Krummholz (7)
    ##     :   :   Elevation <= 3349:
    ##     :   :   :...Hillshade12 <= 192: Krummholz (1)
    ##     :   :       Hillshade12 > 192:
    ##     :   :       :...HorDistFire <= 3945: Spruce/Fir (13)
    ##     :   :           HorDistFire > 3945: Krummholz (1)
    ##     :   HorDistFire <= 3433:
    ##     :   :...HorDistRoad <= 966:
    ##     :       :...Elevation > 3317:
    ##     :       :   :...HorDistRoad <= 850: Krummholz (4)
    ##     :       :   :   HorDistRoad > 850: Spruce/Fir (3)
    ##     :       :   Elevation <= 3317:
    ##     :       :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,
    ##     :       :       :            ST10,ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,
    ##     :       :       :            ST20,ST21,ST25,ST26,ST28,ST29,ST30,ST34,ST35,
    ##     :       :       :            ST36,ST37,ST38,ST39,
    ##     :       :       :            ST40}: Lodgepole Pine (0)
    ##     :       :       SoilType in {ST19,ST23,ST27,ST32,ST33}:
    ##     :       :       :...HorDistToHydro <= 120: Spruce/Fir (4)
    ##     :       :       :   HorDistToHydro > 120: Lodgepole Pine (70/8)
    ##     :       :       SoilType in {ST22,ST24,ST31}:
    ##     :       :       :...HorDistFire > 2337: Lodgepole Pine (3)
    ##     :       :           HorDistFire <= 2337:
    ##     :       :           :...Elevation > 3222: Krummholz (1)
    ##     :       :               Elevation <= 3222:
    ##     :       :               :...Hillshade12 <= 232: Spruce/Fir (10)
    ##     :       :                   Hillshade12 > 232:
    ##     :       :                   :...Elevation <= 3165: Lodgepole Pine (3)
    ##     :       :                       Elevation > 3165: Spruce/Fir (2)
    ##     :       HorDistRoad > 966:
    ##     :       :...HorDistToHydro > 930:
    ##     :           :...HorDistRoad <= 2718:
    ##     :           :   :...HorDistRoad <= 1273: Lodgepole Pine (2)
    ##     :           :   :   HorDistRoad > 1273: Spruce/Fir (9/2)
    ##     :           :   HorDistRoad > 2718:
    ##     :           :   :...Elevation <= 3384: Lodgepole Pine (23)
    ##     :           :       Elevation > 3384: Krummholz (1)
    ##     :           HorDistToHydro <= 930:
    ##     :           :...Elevation > 3253:
    ##     :               :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,
    ##     :               :   :            ST09,ST10,ST11,ST12,ST13,ST14,ST15,ST16,
    ##     :               :   :            ST17,ST18,ST19,ST20,ST25,ST26,ST27,ST28,
    ##     :               :   :            ST29,ST30,ST35,ST36,ST37,ST38,ST39,
    ##     :               :   :            ST40}: Spruce/Fir (0)
    ##     :               :   SoilType = ST34: Lodgepole Pine (3)
    ##     :               :   SoilType in {ST21,ST22,ST23,ST24,ST31,ST32,ST33}:
    ##     :               :   :...HorDistToHydro <= 591: Spruce/Fir (126/11)
    ##     :               :       HorDistToHydro > 591:
    ##     :               :       :...HorDistRoad <= 3571: Spruce/Fir (34/4)
    ##     :               :           HorDistRoad > 3571: Lodgepole Pine (4)
    ##     :               Elevation <= 3253:
    ##     :               :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,
    ##     :                   :            ST09,ST10,ST11,ST12,ST13,ST14,ST15,ST16,
    ##     :                   :            ST17,ST18,ST19,ST25,ST26,ST28,ST29,ST30,
    ##     :                   :            ST35,ST36,ST37,ST38,ST39,
    ##     :                   :            ST40}: Spruce/Fir (0)
    ##     :                   SoilType in {ST32,ST34}:
    ##     :                   :...HorDistRoad > 4013: Spruce/Fir (12)
    ##     :                   :   HorDistRoad <= 4013:
    ##     :                   :   :...HorDistToHydro > 726: Spruce/Fir (8)
    ##     :                   :       HorDistToHydro <= 726:
    ##     :                   :       :...SoilType = ST34: Lodgepole Pine (3)
    ##     :                   :           SoilType = ST32: [S7]
    ##     :                   SoilType in {ST20,ST21,ST22,ST23,ST24,ST27,ST31,ST33}:
    ##     :                   :...SoilType in {ST20,ST21,
    ##     :                       :            ST27}: Spruce/Fir (7)
    ##     :                       SoilType = ST22:
    ##     :                       :...Hillshade12 <= 242:
    ##     :                       :   :...HorDistFire <= 3248: Spruce/Fir (33)
    ##     :                       :   :   HorDistFire > 3248: Krummholz (1)
    ##     :                       :   Hillshade12 > 242:
    ##     :                       :   :...HorDistFire <= 323: Krummholz (1)
    ##     :                       :       HorDistFire > 323: Lodgepole Pine (2)
    ##     :                       SoilType = ST24:
    ##     :                       :...HorDistToHydro > 785:
    ##     :                       :   :...Hillshade15 <= 126: Lodgepole Pine (1)
    ##     :                       :   :   Hillshade15 > 126:
    ##     :                       :   :   :...Elevation <= 3217: Krummholz (1)
    ##     :                       :   :       Elevation > 3217: Spruce/Fir (1)
    ##     :                       :   HorDistToHydro <= 785:
    ##     :                       :   :...HorDistFire <= 3102: Spruce/Fir (44)
    ##     :                       :       HorDistFire > 3102:
    ##     :                       :       :...Elevation > 3209: Lodgepole Pine (2)
    ##     :                       :           Elevation <= 3209: [S8]
    ##     :                       SoilType = ST31:
    ##     :                       :...Hillshade09 <= 171:
    ##     :                       :   :...HorDistToHydro <= 691: Lodgepole Pine (6)
    ##     :                       :   :   HorDistToHydro > 691: Spruce/Fir (1)
    ##     :                       :   Hillshade09 > 171:
    ##     :                       :   :...Aspect <= 283: Spruce/Fir (60/2)
    ##     :                       :       Aspect > 283:
    ##     :                       :       :...HorDistFire <= 1492: Spruce/Fir (5)
    ##     :                       :           HorDistFire > 1492: [S9]
    ##     :                       SoilType = ST33:
    ##     :                       :...Hillshade12 <= 190: Spruce/Fir (14)
    ##     :                       :   Hillshade12 > 190:
    ##     :                       :   :...Aspect > 251:
    ##     :                       :       :...Hillshade15 <= 160: Lodgepole Pine (1)
    ##     :                       :       :   Hillshade15 > 160: Spruce/Fir (16)
    ##     :                       :       Aspect <= 251:
    ##     :                       :       :...HorDistRoad <= 1578: Lodgepole Pine (13)
    ##     :                       :           HorDistRoad > 1578:
    ##     :                       :           :...Hillshade12 <= 215: [S10]
    ##     :                       :               Hillshade12 > 215: [S11]
    ##     :                       SoilType = ST23:
    ##     :                       :...Aspect > 347:
    ##     :                           :...HorDistRoad <= 2385: Lodgepole Pine (2)
    ##     :                           :   HorDistRoad > 2385: Krummholz (1)
    ##     :                           Aspect <= 347:
    ##     :                           :...Slope > 21: Lodgepole Pine (3)
    ##     :                               Slope <= 21:
    ##     :                               :...Hillshade12 <= 237:
    ##     :                                   :...HorDistFire <= 1790: Spruce/Fir (40)
    ##     :                                   :   HorDistFire > 1790: [S12]
    ##     :                                   Hillshade12 > 237:
    ##     :                                   :...Elevation > 3101:
    ##     :                                       :...Elevation <= 3209: [S13]
    ##     :                                       :   Elevation > 3209: [S14]
    ##     :                                       Elevation <= 3101: [S15]
    ##     Elevation <= 3054: [S16]
    ## 
    ## SubTree [S1]
    ## 
    ## GeologicZone in {glacial,mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone = alluvium:
    ## :...VertDistToHydro > 6:
    ## :   :...Aspect <= 56: Douglas-fir (1)
    ## :   :   Aspect > 56: Ponderosa Pine (2)
    ## :   VertDistToHydro <= 6:
    ## :   :...HorDistRoad <= 2026:
    ## :       :...Elevation > 2636: Lodgepole Pine (1)
    ## :       :   Elevation <= 2636:
    ## :       :   :...Hillshade15 <= 164: Douglas-fir (12)
    ## :       :       Hillshade15 > 164: Lodgepole Pine (1)
    ## :       HorDistRoad > 2026:
    ## :       :...HorDistToHydro <= 30: Spruce/Fir (2)
    ## :           HorDistToHydro > 30:
    ## :           :...Elevation <= 2648: Douglas-fir (1)
    ## :               Elevation > 2648: Aspen (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...Elevation <= 2530:
    ##     :...Hillshade12 <= 175: Lodgepole Pine (2)
    ##     :   Hillshade12 > 175:
    ##     :   :...HorDistToHydro <= 42:
    ##     :       :...Aspect <= 221: Douglas-fir (7/1)
    ##     :       :   Aspect > 221: Lodgepole Pine (1)
    ##     :       HorDistToHydro > 42:
    ##     :       :...HorDistFire > 1057:
    ##     :           :...Hillshade12 <= 213: Douglas-fir (7)
    ##     :           :   Hillshade12 > 213:
    ##     :           :   :...HorDistFire <= 1150: Douglas-fir (1)
    ##     :           :       HorDistFire > 1150: Ponderosa Pine (6/2)
    ##     :           HorDistFire <= 1057:
    ##     :           :...HorDistRoad > 953:
    ##     :               :...HorDistRoad <= 1961: Ponderosa Pine (10)
    ##     :               :   HorDistRoad > 1961: Douglas-fir (1)
    ##     :               HorDistRoad <= 953:
    ##     :               :...Aspect <= 161: Lodgepole Pine (3)
    ##     :                   Aspect > 161:
    ##     :                   :...HorDistToHydro <= 175: Douglas-fir (2)
    ##     :                       HorDistToHydro > 175: Ponderosa Pine (1)
    ##     Elevation > 2530:
    ##     :...HorDistToHydro <= 0:
    ##         :...Aspect <= 84: Spruce/Fir (2)
    ##         :   Aspect > 84: Lodgepole Pine (2)
    ##         HorDistToHydro > 0:
    ##         :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST12,
    ##             :            ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,ST23,
    ##             :            ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,
    ##             :            ST34,ST35,ST36,ST37,ST38,ST39,
    ##             :            ST40}: Lodgepole Pine (0)
    ##             SoilType = ST11:
    ##             :...HorDistRoad <= 67: Aspen (1)
    ##             :   HorDistRoad > 67:
    ##             :   :...Slope <= 19: Lodgepole Pine (34/6)
    ##             :       Slope > 19:
    ##             :       :...Slope <= 21: Ponderosa Pine (2)
    ##             :           Slope > 21: Lodgepole Pine (1)
    ##             SoilType in {ST10,ST13}:
    ##             :...HorDistFire > 1711:
    ##                 :...Elevation <= 2566: Lodgepole Pine (1)
    ##                 :   Elevation > 2566: Douglas-fir (12/1)
    ##                 HorDistFire <= 1711:
    ##                 :...Elevation > 2584: Lodgepole Pine (26)
    ##                     Elevation <= 2584:
    ##                     :...Aspect > 193: Douglas-fir (5/1)
    ##                         Aspect <= 193:
    ##                         :...VertDistToHydro <= -1: Douglas-fir (1)
    ##                             VertDistToHydro > -1:
    ##                             :...Elevation > 2559: Ponderosa Pine (2)
    ##                                 Elevation <= 2559:
    ##                                 :...HorDistRoad <= 646: Ponderosa Pine (1)
    ##                                     HorDistRoad > 646: Lodgepole Pine (5)
    ## 
    ## SubTree [S2]
    ## 
    ## HorDistToHydro <= 313: Aspen (3)
    ## HorDistToHydro > 313: Lodgepole Pine (1)
    ## 
    ## SubTree [S3]
    ## 
    ## HorDistToHydro <= 30: Aspen (1)
    ## HorDistToHydro > 30: Lodgepole Pine (9)
    ## 
    ## SubTree [S4]
    ## 
    ## VertDistToHydro <= 64: Aspen (3)
    ## VertDistToHydro > 64: Lodgepole Pine (1)
    ## 
    ## SubTree [S5]
    ## 
    ## HorDistRoad <= 3189: Lodgepole Pine (40/8)
    ## HorDistRoad > 3189: Spruce/Fir (2)
    ## 
    ## SubTree [S6]
    ## 
    ## HorDistToHydro > 258: Lodgepole Pine (23/1)
    ## HorDistToHydro <= 258:
    ## :...HorDistRoad > 1326: Aspen (2)
    ##     HorDistRoad <= 1326:
    ##     :...HorDistToHydro <= 218: Lodgepole Pine (2)
    ##         HorDistToHydro > 218: Aspen (1)
    ## 
    ## SubTree [S7]
    ## 
    ## VertDistToHydro <= 39: Lodgepole Pine (81/22)
    ## VertDistToHydro > 39: Spruce/Fir (70/27)
    ## 
    ## SubTree [S8]
    ## 
    ## HorDistRoad <= 1430: Lodgepole Pine (1)
    ## HorDistRoad > 1430: Spruce/Fir (7)
    ## 
    ## SubTree [S9]
    ## 
    ## Hillshade12 <= 218: Spruce/Fir (1)
    ## Hillshade12 > 218: Lodgepole Pine (4)
    ## 
    ## SubTree [S10]
    ## 
    ## Hillshade09 > 220: Spruce/Fir (15)
    ## Hillshade09 <= 220:
    ## :...Hillshade09 <= 211: Spruce/Fir (4)
    ##     Hillshade09 > 211: Lodgepole Pine (2)
    ## 
    ## SubTree [S11]
    ## 
    ## HorDistRoad > 2421: Lodgepole Pine (29/12)
    ## HorDistRoad <= 2421:
    ## :...Hillshade12 <= 219: Lodgepole Pine (1)
    ##     Hillshade12 > 219: Spruce/Fir (11)
    ## 
    ## SubTree [S12]
    ## 
    ## VertDistToHydro <= 19: Spruce/Fir (9)
    ## VertDistToHydro > 19:
    ## :...Slope <= 15: Lodgepole Pine (3)
    ##     Slope > 15: Spruce/Fir (2)
    ## 
    ## SubTree [S13]
    ## 
    ## HorDistRoad <= 1001: Lodgepole Pine (1)
    ## HorDistRoad > 1001: Spruce/Fir (28)
    ## 
    ## SubTree [S14]
    ## 
    ## Hillshade09 <= 196: Spruce/Fir (2)
    ## Hillshade09 > 196: Lodgepole Pine (4)
    ## 
    ## SubTree [S15]
    ## 
    ## Hillshade09 > 221: Lodgepole Pine (4)
    ## Hillshade09 <= 221:
    ## :...HorDistFire <= 1104: Lodgepole Pine (2)
    ##     HorDistFire > 1104:
    ##     :...VertDistToHydro <= -23: Lodgepole Pine (1)
    ##         VertDistToHydro > -23: Spruce/Fir (6/1)
    ## 
    ## SubTree [S16]
    ## 
    ## GeologicZone in {mixed sedimentary,sandstone,shale,
    ## :                unspecified in the USFS ELU Survey,
    ## :                volcanic}: Lodgepole Pine (0)
    ## GeologicZone in {alluvium,glacial}:
    ## :...Elevation <= 2847:
    ## :   :...Slope <= 9:
    ## :   :   :...Hillshade12 > 241: Spruce/Fir (1)
    ## :   :   :   Hillshade12 <= 241:
    ## :   :   :   :...Elevation > 2774: Lodgepole Pine (4)
    ## :   :   :       Elevation <= 2774:
    ## :   :   :       :...HorDistRoad <= 1360: Douglas-fir (3)
    ## :   :   :           HorDistRoad > 1360: Lodgepole Pine (1)
    ## :   :   Slope > 9:
    ## :   :   :...Hillshade12 <= 225:
    ## :   :       :...HorDistRoad > 1888: Spruce/Fir (3)
    ## :   :       :   HorDistRoad <= 1888:
    ## :   :       :   :...HorDistFire <= 2047: Lodgepole Pine (7)
    ## :   :       :       HorDistFire > 2047: Spruce/Fir (1)
    ## :   :       Hillshade12 > 225:
    ## :   :       :...HorDistRoad <= 807: Spruce/Fir (1)
    ## :   :           HorDistRoad > 807:
    ## :   :           :...Elevation > 2819: Aspen (6)
    ## :   :               Elevation <= 2819:
    ## :   :               :...VertDistToHydro <= 13: Lodgepole Pine (5)
    ## :   :                   VertDistToHydro > 13: Aspen (1)
    ## :   Elevation > 2847:
    ## :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,ST11,
    ## :       :            ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST21,ST24,ST25,ST26,
    ## :       :            ST27,ST28,ST29,ST30,ST31,ST32,ST33,ST34,ST35,ST36,ST37,
    ## :       :            ST38,ST39,ST40}: Spruce/Fir (2)
    ## :       SoilType = ST19:
    ## :       :...VertDistToHydro <= -4: Aspen (1)
    ## :       :   VertDistToHydro > -4: Lodgepole Pine (4)
    ## :       SoilType in {ST20,ST22}:
    ## :       :...Hillshade12 <= 245: Spruce/Fir (29/2)
    ## :       :   Hillshade12 > 245: Lodgepole Pine (1)
    ## :       SoilType = ST23:
    ## :       :...HorDistRoad <= 1831:
    ## :           :...Slope > 14: Lodgepole Pine (9)
    ## :           :   Slope <= 14:
    ## :           :   :...Hillshade09 <= 214:
    ## :           :       :...Hillshade15 <= 178: Spruce/Fir (7)
    ## :           :       :   Hillshade15 > 178:
    ## :           :       :   :...HorDistToHydro > 95: Lodgepole Pine (3)
    ## :           :       :       HorDistToHydro <= 95:
    ## :           :       :       :...Hillshade09 <= 201: Spruce/Fir (4)
    ## :           :       :           Hillshade09 > 201: Lodgepole Pine (1)
    ## :           :       Hillshade09 > 214:
    ## :           :       :...Aspect <= 68: Lodgepole Pine (9)
    ## :           :           Aspect > 68:
    ## :           :           :...HorDistFire > 2442: Spruce/Fir (2)
    ## :           :               HorDistFire <= 2442:
    ## :           :               :...HorDistToHydro <= 67: Lodgepole Pine (4)
    ## :           :                   HorDistToHydro > 67:
    ## :           :                   :...Hillshade12 <= 236: Spruce/Fir (3)
    ## :           :                       Hillshade12 > 236: Lodgepole Pine (2)
    ## :           HorDistRoad > 1831:
    ## :           :...Aspect > 243: Spruce/Fir (10)
    ## :               Aspect <= 243:
    ## :               :...Slope > 16: Lodgepole Pine (2)
    ## :                   Slope <= 16:
    ## :                   :...Hillshade15 <= 140: Spruce/Fir (6)
    ## :                       Hillshade15 > 140:
    ## :                       :...HorDistToHydro > 201: Spruce/Fir (2)
    ## :                           HorDistToHydro <= 201:
    ## :                           :...HorDistRoad > 3032: Spruce/Fir (1)
    ## :                               HorDistRoad <= 3032:
    ## :                               :...Elevation > 3009: Lodgepole Pine (4)
    ## :                                   Elevation <= 3009:
    ## :                                   :...HorDistFire <= 2033: Spruce/Fir (2)
    ## :                                       HorDistFire > 2033: Lodgepole Pine (1)
    ## GeologicZone = igneous and metamorphic:
    ## :...Elevation > 2921:
    ##     :...Hillshade09 <= 136: Spruce/Fir (7)
    ##     :   Hillshade09 > 136:
    ##     :   :...Hillshade12 > 231: Lodgepole Pine (160/18)
    ##     :       Hillshade12 <= 231:
    ##     :       :...SoilType = ST26: Spruce/Fir (1)
    ##     :           SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,
    ##     :           :            ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,
    ##     :           :            ST21,ST22,ST23,ST25,ST27,ST28,ST29,ST30,ST34,ST35,
    ##     :           :            ST36,ST37,ST38,ST39,
    ##     :           :            ST40}: Lodgepole Pine (2)
    ##     :           SoilType = ST31:
    ##     :           :...Hillshade15 <= 95: Spruce/Fir (2)
    ##     :           :   Hillshade15 > 95: Lodgepole Pine (39/9)
    ##     :           SoilType = ST24:
    ##     :           :...HorDistRoad <= 509: Lodgepole Pine (7)
    ##     :           :   HorDistRoad > 509:
    ##     :           :   :...Elevation <= 2977:
    ##     :           :       :...HorDistRoad <= 663: Spruce/Fir (2)
    ##     :           :       :   HorDistRoad > 663:
    ##     :           :       :   :...Hillshade09 <= 233: Lodgepole Pine (9)
    ##     :           :       :       Hillshade09 > 233: Spruce/Fir (1)
    ##     :           :       Elevation > 2977:
    ##     :           :       :...Slope > 13: Spruce/Fir (14)
    ##     :           :           Slope <= 13:
    ##     :           :           :...Slope <= 12: Spruce/Fir (3)
    ##     :           :               Slope > 12: Lodgepole Pine (3)
    ##     :           SoilType = ST32:
    ##     :           :...HorDistFire > 1937: Lodgepole Pine (31/2)
    ##     :           :   HorDistFire <= 1937:
    ##     :           :   :...Hillshade12 <= 205: Lodgepole Pine (5)
    ##     :           :       Hillshade12 > 205:
    ##     :           :       :...HorDistRoad <= 618: Lodgepole Pine (6)
    ##     :           :           HorDistRoad > 618:
    ##     :           :           :...HorDistRoad > 1745: Lodgepole Pine (22/7)
    ##     :           :               HorDistRoad <= 1745:
    ##     :           :               :...Hillshade09 > 231: Lodgepole Pine (3)
    ##     :           :                   Hillshade09 <= 231:
    ##     :           :                   :...Elevation > 2945: Spruce/Fir (20/2)
    ##     :           :                       Elevation <= 2945:
    ##     :           :                       :...Slope <= 12: Lodgepole Pine (2)
    ##     :           :                           Slope > 12: Spruce/Fir (1)
    ##     :           SoilType = ST33:
    ##     :           :...HorDistRoad > 2110:
    ##     :               :...Elevation <= 2950: Lodgepole Pine (3)
    ##     :               :   Elevation > 2950:
    ##     :               :   :...Hillshade12 <= 175: Lodgepole Pine (1)
    ##     :               :       Hillshade12 > 175: Spruce/Fir (11)
    ##     :               HorDistRoad <= 2110:
    ##     :               :...VertDistToHydro > 232: Spruce/Fir (3)
    ##     :                   VertDistToHydro <= 232:
    ##     :                   :...HorDistRoad > 962:
    ##     :                       :...HorDistFire <= 3074: Lodgepole Pine (17)
    ##     :                       :   HorDistFire > 3074: Spruce/Fir (1)
    ##     :                       HorDistRoad <= 962:
    ##     :                       :...Hillshade09 <= 195: Spruce/Fir (2)
    ##     :                           Hillshade09 > 195:
    ##     :                           :...Hillshade12 > 214: Spruce/Fir (2)
    ##     :                               Hillshade12 <= 214:
    ##     :                               :...Hillshade15 <= 71: Spruce/Fir (2)
    ##     :                                   Hillshade15 > 71:
    ##     :                                   :...Slope <= 15: Spruce/Fir (1)
    ##     :                                       Slope > 15: Lodgepole Pine (11)
    ##     Elevation <= 2921:
    ##     :...Elevation <= 2623:
    ##         :...HorDistToHydro > 234: Lodgepole Pine (7)
    ##         :   HorDistToHydro <= 234:
    ##         :   :...Hillshade12 <= 187: Lodgepole Pine (1)
    ##         :       Hillshade12 > 187: Douglas-fir (6)
    ##         Elevation > 2623:
    ##         :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST10,
    ##             :            ST11,ST12,ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,
    ##             :            ST21,ST22,ST23,ST25,ST26,ST27,ST28,ST29,ST30,ST34,
    ##             :            ST35,ST36,ST37,ST38,ST39,
    ##             :            ST40}: Lodgepole Pine (28)
    ##             SoilType in {ST24,ST31,ST32,ST33}:
    ##             :...HorDistRoad <= 1172: Lodgepole Pine (78/6)
    ##                 HorDistRoad > 1172:
    ##                 :...Hillshade09 > 226:
    ##                     :...HorDistFire <= 497: Spruce/Fir (2)
    ##                     :   HorDistFire > 497:
    ##                     :   :...Slope <= 9:
    ##                     :       :...Elevation <= 2830: Ponderosa Pine (1)
    ##                     :       :   Elevation > 2830: Lodgepole Pine (7)
    ##                     :       Slope > 9:
    ##                     :       :...SoilType in {ST24,ST31}: Lodgepole Pine (4)
    ##                     :           SoilType in {ST32,ST33}:
    ##                     :           :...Aspect > 105: Aspen (4)
    ##                     :               Aspect <= 105:
    ##                     :               :...Elevation <= 2855: Aspen (3)
    ##                     :                   Elevation > 2855: [S17]
    ##                     Hillshade09 <= 226:
    ##                     :...HorDistToHydro > 190:
    ##                         :...Hillshade15 > 143:
    ##                         :   :...HorDistFire <= 350: Spruce/Fir (1)
    ##                         :   :   HorDistFire > 350: Lodgepole Pine (40/2)
    ##                         :   Hillshade15 <= 143:
    ##                         :   :...Elevation <= 2833:
    ##                         :       :...Aspect <= 33: Lodgepole Pine (8)
    ##                         :       :   Aspect > 33:
    ##                         :       :   :...Aspect <= 45: Douglas-fir (2)
    ##                         :       :       Aspect > 45: Lodgepole Pine (1)
    ##                         :       Elevation > 2833:
    ##                         :       :...SoilType = ST24: Lodgepole Pine (0)
    ##                         :           SoilType = ST32: Spruce/Fir (3)
    ##                         :           SoilType in {ST31,ST33}:
    ##                         :           :...HorDistFire > 2268: Lodgepole Pine (6)
    ##                         :               HorDistFire <= 2268: [S18]
    ##                         HorDistToHydro <= 190:
    ##                         :...Aspect > 331: Spruce/Fir (7/1)
    ##                             Aspect <= 331:
    ##                             :...HorDistToHydro > 120:
    ##                                 :...Hillshade12 > 247: Aspen (1)
    ##                                 :   Hillshade12 <= 247:
    ##                                 :   :...HorDistRoad <= 2120: [S19]
    ##                                 :       HorDistRoad > 2120: [S20]
    ##                                 HorDistToHydro <= 120:
    ##                                 :...Slope > 16: Lodgepole Pine (18/1)
    ##                                     Slope <= 16:
    ##                                     :...SoilType = ST24: Spruce/Fir (1)
    ##                                         SoilType = ST32: [S21]
    ##                                         SoilType = ST31:
    ##                                         :...Aspect > 280: Lodgepole Pine (2)
    ##                                         :   Aspect <= 280: [S22]
    ##                                         SoilType = ST33:
    ##                                         :...Elevation <= 2712: Spruce/Fir (1)
    ##                                             Elevation > 2712: [S23]
    ## 
    ## SubTree [S17]
    ## 
    ## VertDistToHydro <= 166: Lodgepole Pine (6)
    ## VertDistToHydro > 166: Aspen (1)
    ## 
    ## SubTree [S18]
    ## 
    ## HorDistToHydro <= 272: Lodgepole Pine (3)
    ## HorDistToHydro > 272:
    ## :...VertDistToHydro <= 111: Spruce/Fir (6/1)
    ##     VertDistToHydro > 111: Lodgepole Pine (2)
    ## 
    ## SubTree [S19]
    ## 
    ## HorDistToHydro <= 175: Lodgepole Pine (12)
    ## HorDistToHydro > 175: Spruce/Fir (2)
    ## 
    ## SubTree [S20]
    ## 
    ## SoilType in {ST24,ST32,ST33}: Spruce/Fir (5)
    ## SoilType = ST31: Lodgepole Pine (1)
    ## 
    ## SubTree [S21]
    ## 
    ## Elevation <= 2863: Aspen (1)
    ## Elevation > 2863: Lodgepole Pine (1)
    ## 
    ## SubTree [S22]
    ## 
    ## HorDistRoad <= 1495: Lodgepole Pine (1)
    ## HorDistRoad > 1495: Aspen (4)
    ## 
    ## SubTree [S23]
    ## 
    ## HorDistToHydro > 90: Lodgepole Pine (3)
    ## HorDistToHydro <= 90:
    ## :...HorDistRoad <= 2446: Aspen (2)
    ##     HorDistRoad > 2446: Lodgepole Pine (1)
    ## 
    ## 
    ## Evaluation on training data (2533 cases):
    ## 
    ##      Decision Tree   
    ##    ----------------  
    ##    Size      Errors  
    ## 
    ##     304  183( 7.2%)   <<
    ## 
    ## 
    ##     (a)   (b)   (c)   (d)   (e)   (f)   (g)    <-classified as
    ##    ----  ----  ----  ----  ----  ----  ----
    ##     789    92                             6    (a): class Spruce/Fir
    ##      42  1158     4                 2          (b): class Lodgepole Pine
    ##            12   129                 4          (c): class Ponderosa Pine
    ##                                                (d): class Cottonwood/Willow
    ##             5     1          65                (e): class Aspen
    ##             3     1                76          (f): class Douglas-fir
    ##      11                                 133    (g): class Krummholz
    ## 
    ## 
    ##  Attribute usage:
    ## 
    ##  100.00% Elevation
    ##  100.00% ClimateZone
    ##   83.50% SoilType
    ##   76.35% HorDistRoad
    ##   58.11% HorDistFire
    ##   52.86% HorDistToHydro
    ##   39.08% Hillshade12
    ##   38.53% GeologicZone
    ##   38.14% Hillshade09
    ##   36.24% Aspect
    ##   20.65% Slope
    ##   16.70% VertDistToHydro
    ##   11.01% Hillshade15
    ## 
    ## 
    ## Time: 0.1 secs

1.  WildArea WA\_CLPWA

``` r
covtype_WA_CLPWA = subset(covtype, covtype$WildArea == "WA_CLPWA")
rows <- nrow(covtype_WA_CLPWA)
covtypeSample_WA_CLPWA <- covtype_WA_CLPWA[sample(rows,rows/100), ]

covtypeSample_WA_CLPWA$WildArea <- NULL
modelCT <- C5.0(Class ~ ., data=covtypeSample_WA_CLPWA, control = C5.0Control(noGlobalPruning = TRUE, minCases=1))
#plot(modelCT50, main="C5.0 Decision Tree - Unpruned, min=1")
summary(modelCT)
```

    ## 
    ## Call:
    ## C5.0.formula(formula = Class ~ ., data = covtypeSample_WA_CLPWA, control
    ##  = C5.0Control(noGlobalPruning = TRUE, minCases = 1))
    ## 
    ## 
    ## C5.0 [Release 2.07 GPL Edition]      Fri Aug 25 10:42:56 2017
    ## -------------------------------
    ## 
    ## Class specified by attribute `outcome'
    ## 
    ## Read 369 cases (14 attributes) from undefined.data
    ## 
    ## Decision tree:
    ## 
    ## Elevation > 2497:
    ## :...HorDistFire > 1505:
    ## :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST06,ST07,ST08,ST09,ST11,ST12,
    ## :   :   :            ST13,ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,ST23,
    ## :   :   :            ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,ST34,
    ## :   :   :            ST35,ST36,ST37,ST38,ST39,ST40}: Ponderosa Pine (2)
    ## :   :   SoilType = ST10: Douglas-fir (1)
    ## :   HorDistFire <= 1505:
    ## :   :...SoilType in {ST01,ST02,ST03,ST04,ST05,ST07,ST08,ST09,ST11,ST12,ST13,
    ## :       :            ST14,ST15,ST16,ST17,ST18,ST19,ST20,ST21,ST22,ST23,ST24,
    ## :       :            ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,ST34,ST35,
    ## :       :            ST36,ST37,ST38,ST39,ST40}: Lodgepole Pine (1)
    ## :       SoilType = ST06:
    ## :       :...HorDistRoad <= 979: Lodgepole Pine (7)
    ## :       :   HorDistRoad > 979: Ponderosa Pine (1)
    ## :       SoilType = ST10:
    ## :       :...Hillshade12 <= 190: Ponderosa Pine (2)
    ## :           Hillshade12 > 190:
    ## :           :...Aspect <= 336: Lodgepole Pine (7)
    ## :               Aspect > 336: Ponderosa Pine (1)
    ## Elevation <= 2497:
    ## :...SoilType in {ST07,ST08,ST09,ST12,ST13,ST14,ST15,ST18,ST19,ST20,ST21,ST22,
    ##     :            ST23,ST24,ST25,ST26,ST27,ST28,ST29,ST30,ST31,ST32,ST33,ST34,
    ##     :            ST35,ST36,ST37,ST38,ST39,ST40}: Ponderosa Pine (0)
    ##     SoilType in {ST03,ST04,ST05,ST17}:
    ##     :...ClimateZone in {alpine,lower montane dry,montane,montane dry,
    ##     :   :               montane dry and montane,
    ##     :   :               subalpine}: Ponderosa Pine (0)
    ##     :   ClimateZone = montane and subalpine: Cottonwood/Willow (6)
    ##     :   ClimateZone = lower montane:
    ##     :   :...HorDistFire > 1398:
    ##     :       :...SoilType in {ST03,ST05,ST17}: Cottonwood/Willow (6)
    ##     :       :   SoilType = ST04: Ponderosa Pine (1)
    ##     :       HorDistFire <= 1398:
    ##     :       :...Elevation > 2248:
    ##     :           :...Slope <= 38: Ponderosa Pine (25)
    ##     :           :   Slope > 38: Cottonwood/Willow (1)
    ##     :           Elevation <= 2248:
    ##     :           :...HorDistRoad <= 454: Ponderosa Pine (8)
    ##     :               HorDistRoad > 454:
    ##     :               :...HorDistToHydro > 301: Ponderosa Pine (1)
    ##     :                   HorDistToHydro <= 301:
    ##     :                   :...Hillshade12 <= 232: Cottonwood/Willow (7)
    ##     :                       Hillshade12 > 232: Ponderosa Pine (1)
    ##     SoilType in {ST01,ST02,ST06,ST10,ST11,ST16}:
    ##     :...HorDistToHydro <= 0:
    ##         :...Slope <= 13:
    ##         :   :...Elevation <= 2380: Cottonwood/Willow (5)
    ##         :   :   Elevation > 2380:
    ##         :   :   :...Elevation <= 2418: Douglas-fir (1)
    ##         :   :       Elevation > 2418: Lodgepole Pine (1)
    ##         :   Slope > 13:
    ##         :   :...SoilType in {ST02,ST06,ST10,ST11,
    ##         :       :            ST16}: Ponderosa Pine (10/1)
    ##         :       SoilType = ST01:
    ##         :       :...HorDistFire <= 759: Douglas-fir (1)
    ##         :           HorDistFire > 759: Cottonwood/Willow (2)
    ##         HorDistToHydro > 0:
    ##         :...ClimateZone in {alpine,lower montane dry,montane dry,
    ##             :               montane dry and montane,
    ##             :               subalpine}: Ponderosa Pine (0)
    ##             ClimateZone = montane and subalpine:
    ##             :...Elevation <= 2348: Ponderosa Pine (1)
    ##             :   Elevation > 2348: Douglas-fir (1)
    ##             ClimateZone = lower montane:
    ##             :...VertDistToHydro > 222: Cottonwood/Willow (3)
    ##             :   VertDistToHydro <= 222:
    ##             :   :...Hillshade09 <= 210:
    ##             :       :...Elevation <= 2342:
    ##             :       :   :...Elevation <= 2001: Douglas-fir (3)
    ##             :       :   :   Elevation > 2001: Ponderosa Pine (34/5)
    ##             :       :   Elevation > 2342:
    ##             :       :   :...HorDistRoad > 1355: Ponderosa Pine (2)
    ##             :       :       HorDistRoad <= 1355:
    ##             :       :       :...HorDistFire <= 1556: Douglas-fir (14)
    ##             :       :           HorDistFire > 1556: Ponderosa Pine (1)
    ##             :       Hillshade09 > 210:
    ##             :       :...HorDistRoad > 849: Ponderosa Pine (22/4)
    ##             :           HorDistRoad <= 849:
    ##             :           :...Aspect > 182: Cottonwood/Willow (1)
    ##             :               Aspect <= 182:
    ##             :               :...HorDistToHydro > 362:
    ##             :                   :...HorDistToHydro <= 391: Douglas-fir (4)
    ##             :                   :   HorDistToHydro > 391: Ponderosa Pine (1)
    ##             :                   HorDistToHydro <= 362:
    ##             :                   :...HorDistFire <= 832: Ponderosa Pine (32/1)
    ##             :                       HorDistFire > 832:
    ##             :                       :...Aspect <= 49: Ponderosa Pine (3)
    ##             :                           Aspect > 49:
    ##             :                           :...Aspect <= 121: Douglas-fir (4)
    ##             :                               Aspect > 121: Ponderosa Pine (1)
    ##             ClimateZone = montane:
    ##             :...HorDistRoad <= 437:
    ##                 :...Aspect <= 94:
    ##                 :   :...Hillshade09 <= 191: Ponderosa Pine (3)
    ##                 :   :   Hillshade09 > 191:
    ##                 :   :   :...HorDistToHydro > 258: Ponderosa Pine (1)
    ##                 :   :       HorDistToHydro <= 258:
    ##                 :   :       :...HorDistFire <= 283: Ponderosa Pine (1)
    ##                 :   :           HorDistFire > 283: Douglas-fir (4)
    ##                 :   Aspect > 94:
    ##                 :   :...VertDistToHydro <= 9: Lodgepole Pine (3)
    ##                 :       VertDistToHydro > 9:
    ##                 :       :...SoilType in {ST01,ST02,ST06,ST11,
    ##                 :           :            ST16}: Ponderosa Pine (1)
    ##                 :           SoilType = ST10:
    ##                 :           :...Aspect <= 254: Lodgepole Pine (2)
    ##                 :               Aspect > 254:
    ##                 :               :...HorDistToHydro <= 127:
    ##                 :                   :...Hillshade15 <= 178: Douglas-fir (1)
    ##                 :                   :   Hillshade15 > 178: Ponderosa Pine (10)
    ##                 :                   HorDistToHydro > 127: [S1]
    ##                 HorDistRoad > 437:
    ##                 :...Hillshade12 <= 170: Ponderosa Pine (24/1)
    ##                     Hillshade12 > 170:
    ##                     :...VertDistToHydro > 161: Ponderosa Pine (9)
    ##                         VertDistToHydro <= 161:
    ##                         :...HorDistFire > 1419: Ponderosa Pine (7)
    ##                             HorDistFire <= 1419:
    ##                             :...Elevation > 2390:
    ##                                 :...Hillshade12 > 198: Douglas-fir (10)
    ##                                 :   Hillshade12 <= 198: [S2]
    ##                                 Elevation <= 2390:
    ##                                 :...Hillshade09 > 186:
    ##                                     :...HorDistFire <= 1099: Ponderosa Pine (5)
    ##                                     :   HorDistFire > 1099: Douglas-fir (1)
    ##                                     Hillshade09 <= 186:
    ##                                     :...Elevation > 2321: Douglas-fir (9)
    ##                                         Elevation <= 2321: [S3]
    ## 
    ## SubTree [S1]
    ## 
    ## HorDistToHydro > 190: Ponderosa Pine (13/1)
    ## HorDistToHydro <= 190:
    ## :...Hillshade09 <= 162: Ponderosa Pine (1)
    ##     Hillshade09 > 162: Lodgepole Pine (3)
    ## 
    ## SubTree [S2]
    ## 
    ## VertDistToHydro <= 99: Lodgepole Pine (2)
    ## VertDistToHydro > 99: Douglas-fir (1)
    ## 
    ## SubTree [S3]
    ## 
    ## Elevation > 2302: Ponderosa Pine (6)
    ## Elevation <= 2302:
    ## :...HorDistFire <= 677:
    ##     :...HorDistRoad > 470: Ponderosa Pine (7)
    ##     :   HorDistRoad <= 470:
    ##     :   :...HorDistToHydro <= 228: Douglas-fir (2)
    ##     :       HorDistToHydro > 228: Ponderosa Pine (1)
    ##     HorDistFire > 677:
    ##     :...Hillshade12 <= 217: Douglas-fir (12/1)
    ##         Hillshade12 > 217:
    ##         :...Elevation <= 2214: Ponderosa Pine (3)
    ##             Elevation > 2214: Douglas-fir (2)
    ## 
    ## 
    ## Evaluation on training data (369 cases):
    ## 
    ##      Decision Tree   
    ##    ----------------  
    ##    Size      Errors  
    ## 
    ##      67   14( 3.8%)   <<
    ## 
    ## 
    ##     (a)   (b)   (c)   (d)   (e)   (f)   (g)    <-classified as
    ##    ----  ----  ----  ----  ----  ----  ----
    ##                                                (a): class Spruce/Fir
    ##            26     1                            (b): class Lodgepole Pine
    ##                 228                 1          (c): class Ponderosa Pine
    ##                   5    31                      (d): class Cottonwood/Willow
    ##                                                (e): class Aspen
    ##                   7                70          (f): class Douglas-fir
    ##                                                (g): class Krummholz
    ## 
    ## 
    ##  Attribute usage:
    ## 
    ##  100.00% Elevation
    ##  100.00% SoilType
    ##   88.62% ClimateZone
    ##   81.30% HorDistToHydro
    ##   68.83% HorDistRoad
    ##   63.96% VertDistToHydro
    ##   55.01% HorDistFire
    ##   49.59% Hillshade09
    ##   32.25% Hillshade12
    ##   26.29% Aspect
    ##   12.47% Slope
    ##    2.98% Hillshade15
    ## 
    ## 
    ## Time: 0.0 secs

Dados do Rafael Santos
======================

``` r
#install.packages("C50")
library(C50)
load('Data/CovType2.R')
rows <- nrow(covtype)
covtype <- covtype[sample(rows,rows/100), ]
modelCT <- C5.0(Class ~ ., data=covtype, control = C5.0Control(noGlobalPruning = TRUE,minCases=1))
plot(modelCT, main="C5.0 Decision Tree - Unpruned, min=1")
```

![](CovtypeExerciseDecisionTree_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)
