Hot Dogs in Baltimore
================

-   [Sobre os dados](#sobre-os-dados)
-   [Preparando o ambiente](#preparando-o-ambiente)
    -   [Definindo parâmetros para a execução](#definindo-parâmetros-para-a-execução)
    -   [Criando diretório temporário](#criando-diretório-temporário)
    -   [Baixando arquivo de dados](#baixando-arquivo-de-dados)
-   [Organizando os dados](#organizando-os-dados)
    -   [Removendo e renomeando variáveis](#removendo-e-renomeando-variáveis)
    -   [Formatando variáveis](#formatando-variáveis)

Sobre os dados
==============

Neste script são utilizados dados de vendedores de Baltimore. O arquivo CSV de origem desses dados está organizado da seguinte forma:

| Column Name | Type       | Description                                         |
|-------------|------------|-----------------------------------------------------|
| Id          | Number     | Identifier. Always zero !                           |
| LicenseNum  | Plain Text | License Number                                      |
| VendorName  | Plain Text | Vendor Name                                         |
| VendorAddr  | Plain Text | Vendor Address                                      |
| ItemsSold   | Plain Text | Items Sold in comma separated values format         |
| Cart\_Descr | Plain Text | Cart Description                                    |
| St          | Plain Text | State. Always 'MD'                                  |
| Location.1  | Plain Text | Location. Format: 'CityName ZIP\_CODE\\n(LAT, LON)' |

Fonte: [Site da cidade de Baltimore](https://data.baltimorecity.gov/dataset/Food-Vendor-Locations/bqw3-z52q)

Para a análise que será realizada, as variáveis serão transformadas/extraídas para o seguinte formato:

| Variable      | Type       | Description                                  |
|---------------|------------|----------------------------------------------|
| LicenseNumber | Factor     | LicenseNumber                                |
| VendorName    | Plain Text | Vendor Name                                  |
| VendorAddress | Plain Text | Vendor Address                               |
| ItemsSold     | Plain Text | Itemns Sold in comma separated values format |
| CityName      | Plain Text | City Name                                    |
| Zip           | Plain Text | Zip Code                                     |
| Lat           | Number     | Latitude                                     |
| Lon           | Number     | Longitude                                    |
| sellsHotDog   | Logical    | TRUE if the vendor sells the product         |
| sellsPizza    | Logical    | TRUE if the vendor sells the product         |

Preparando o ambiente
=====================

Definindo parâmetros para a execução
------------------------------------

``` r
# pasta para a execução do script
homeDir<-"/home/vconrado/doutorado/disciplinas/CAP-386/vconrado/cap-386/exercises"
# diretório para armazenar dados baixados
tempDir<-"./TempData"
# endereço dos dados a serem utilizados no script
bVendorsURL <- "https://data.baltimorecity.gov/api/views/bqw3-z52q/rows.csv?accessType=DOWNLOAD" 
```

Criando diretório temporário
----------------------------

Cria diretorio para guardar dados temporarios

``` r
orig <- getwd()
setwd(homeDir)
```

    ## Error in setwd(homeDir): cannot change working directory

``` r
if (!file.exists(tempDir)) {
      dir.create(tempDir)  
}
```

Baixando arquivo de dados
-------------------------

Baixa o arquivo CSV do site de Baltimore

``` r
fileName <- paste(tempDir,"/bVendors.csv",sep="");

if (!file.exists(fileName)) {
  download.file(bVendorsURL,destfile = fileName,method="curl")
  if (file.exists(fileName)) {
    tam <- file.info(fileName)$size
    paste("File downloaded, ",tam," bytes")
  } else {
    stop("Error downloading file!")
  }
} else {
  "Using a pre-existing file"
}
```

    ## [1] "Using a pre-existing file"

``` r
bVendors <- read.csv(file=fileName, header=TRUE, sep=",", stringsAsFactors=FALSE)
```

Organizando os dados
====================

Removendo e renomeando variáveis
--------------------------------

As variáveis **Id** e **St** são removidas pois apresentam um único valor. A variável **Cart\_Descr** é removida pois não será utilizada na análise.

``` r
bVendors$Id <- NULL
bVendors$Cart_Descr <- NULL
bVendors$St <- NULL

names(bVendors)[names(bVendors) == "LicenseNum"] <- "LicenseNumber"
names(bVendors)[names(bVendors) == "VendorAddr"] <- "VendorAddress"
names(bVendors)[names(bVendors) == "Location.1"] <- "Location"

str(bVendors)
```

    ## 'data.frame':    77 obs. of  5 variables:
    ##  $ LicenseNumber: chr  "DF000166" "DF000075" "DF000133" "DF000136" ...
    ##  $ VendorName   : chr  "Abdul-Ghani, Christina, \"The Bullpen Bar\"" "Ali, Fathi" "Ali, Fathi" "Ali, Fathi" ...
    ##  $ VendorAddress: chr  "508 Washington Blvd, confined within 10 x 10 space" "SEC Calvert & Madison on Calvert" "NEC Baltimore & Pine Sts" "NEC Light & Redwood Sts" ...
    ##  $ ItemsSold    : chr  "Grilled food, pizza slices, gyro sandwiches" "Hot Dogs, Sausage, Snacks, Gum, Candies, Drinks" "Hot dogs, Sausage, drinks, snacks, gum, & candy" "Hot dogs, sausages, chips, snacks, drinks, gum" ...
    ##  $ Location     : chr  "Towson 21204\n(39.28540000000, -76.62260000000)" "Owings Mill 21117\n(39.29860000000, -76.61280000000)" "Owings Mill 21117\n(39.28920000000, -76.62670000000)" "Owings Mill 21117\n(39.28870000000, -76.61360000000)" ...

Formatando variáveis
--------------------

Extraindo **Nome da Cidade** e **CEP**

``` r
cityZip=unlist(strsplit(bVendors$Location,"\n"))[seq(1,nrow(bVendors)*2,2)]
bVendors$City=gsub(".{6}$","",cityZip)
bVendors$Zip=substr(cityZip, nchar(cityZip)-4,nchar(cityZip))
```

Extraindo **Latitude** e **Longitude**

``` r
latLonSTmp=unlist(strsplit(bVendors$Location,"\n"))
lats <- vector(length = nrow(bVendors),mode = "numeric")
longs <- vector(length = nrow(bVendors),mode = "numeric")

for(i in 1:nrow(bVendors)){
  latLonS = unlist(strsplit(gsub("^.|.$", "",latLonSTmp[i*2]),", "))
  lats[i] <- as.numeric(latLonS[1])
  longs[i] <- as.numeric(latLonS[2])
}
bVendors$Lat <- lats
bVendors$Long <- longs
bVendors$Location <- NULL
```

Extraindo **sellsHotDog** e **sellsPizza**

``` r
searchItem="Hot dog|franks"
bVendors$sellsHotDog <- grepl(searchItem,ignore.case = TRUE, bVendors$ItemsSold)
searchItem="pizza"
bVendors$sellsPizza <- grepl(searchItem,ignore.case = TRUE, bVendors$ItemsSold)
```

Exibindo os dados limpos

``` r
str(bVendors)
```

    ## 'data.frame':    77 obs. of  10 variables:
    ##  $ LicenseNumber: chr  "DF000166" "DF000075" "DF000133" "DF000136" ...
    ##  $ VendorName   : chr  "Abdul-Ghani, Christina, \"The Bullpen Bar\"" "Ali, Fathi" "Ali, Fathi" "Ali, Fathi" ...
    ##  $ VendorAddress: chr  "508 Washington Blvd, confined within 10 x 10 space" "SEC Calvert & Madison on Calvert" "NEC Baltimore & Pine Sts" "NEC Light & Redwood Sts" ...
    ##  $ ItemsSold    : chr  "Grilled food, pizza slices, gyro sandwiches" "Hot Dogs, Sausage, Snacks, Gum, Candies, Drinks" "Hot dogs, Sausage, drinks, snacks, gum, & candy" "Hot dogs, sausages, chips, snacks, drinks, gum" ...
    ##  $ City         : chr  "Towson" "Owings Mill" "Owings Mill" "Owings Mill" ...
    ##  $ Zip          : chr  "21204" "21117" "21117" "21117" ...
    ##  $ Lat          : num  39.3 39.3 39.3 39.3 39.3 ...
    ##  $ Long         : num  -76.6 -76.6 -76.6 -76.6 -76.6 ...
    ##  $ sellsHotDog  : logi  FALSE TRUE TRUE TRUE TRUE TRUE ...
    ##  $ sellsPizza   : logi  TRUE FALSE FALSE FALSE FALSE FALSE ...
