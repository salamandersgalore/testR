```{r}
census<- read.fwf("https://www2.census.gov/programs-surveys/saipe/datasets/2019/2019-state-and-county/est19-ut.txt", widths = c(2, 4, 9, 9, 9, 5, 5, 5, 9, 9, 9, 5, 5, 5, 9, 9, 9, 5, 5, 5, 7, 7, 7, 8, 8, 8, 5, 5, 5, 46, 3, 25))

str(census)

library(tidyverse)
library(stringr)

colnames(census)<-c("StateCode", "fips", "EstPov", "EstPovLwrCon","EstPovHigCon", "EstPerPov", "EstPerPovLwrCon", "EstPerPovHigCon", "Est0-17Pov","Est0-17PovLwrCon","Est0-17HigCon", "Est%0-17Pov", "Est%0-17PovLwr", "EstPer0-17PovHig", "EstRel5-17Pov","Est5-17PovLwr", "Est5-17PovHig","EstPer5-17","EstPer5-17LwrCon", "EstPer5-17HigCon", "EstMedianHI", "EstMedHILwr", "EstMedHIHig", "Est<5Pov","Est<5LwrCon","Est<5HigCon","EstPer<5","EstPer<5LwrCon", "EstPer<5HigCon", "County", "StateAbb", "Tag")

census$fips<- c(49000,49001,49003,49005,49007,49009,49011,49013,49015,49017,49019,49021,49023,49025,49027,49029,49031,49033,49035,49037,49039,49041,49043,49045,49047,49049,49051,49053,49055,49057)

```
```{r}
library(sf)
library(raster)
library(tmap)
library(spData)
library(leaflet)
```
```{r}
data("World")
tmap_mode("view")
tm_shape(World) +
  tm_polygons("life_exp")+
  tm_fill()+
  tm_borders()
```
```{r}
library(usmap)
library(ggplot2)
```

```{r}
library(ggpubr)
library(gridExtra)

povplot<-plot_usmap(include = "Utah", regions = "counties", data = census, values = "EstPerPov")+
  scale_fill_continuous(low = "white", high = "blue", name = "Poverty Percentage Estimates 2020")+
  theme(legend.position = "right")+
  ggtitle("Utah Poverty Estimates 2020")

options(scipen=100000)#removes sci notation on legend for HI

HIplot<-plot_usmap(include = "Utah", regions = "counties", data = census, values = "EstMedianHI")+
  scale_fill_continuous(low = "white", high = "blue", name = "Estimated Median Household Income 2020")+
  theme(legend.position = "right") 

grid.arrange(povplot, HIplot, nrow = 1) #Map size is different
```

