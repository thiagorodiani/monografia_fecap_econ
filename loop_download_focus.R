#Download de Todos os Boletins FOCUS - 05 de Janeiro de 2001 até 29/12/2017
#Thiago Tiuzzi - FECAP - 19/02/2018 - (Ult. Atualização - 26/03/2018)

#Pacotes
library(bizdays)
library(xml2)
library(rvest)
library(lubridate)

cal <- create.calendar("Brazil/ANBIMA", holidaysANBIMA, weekdays=c("saturday", "sunday"))

#Intervalo de Datas - Todas as Sextas - Tratamento
dt_Inicio <- dmy("01-Jan-2001")
dt_Final <- dmy("31-Dec-2017")
datas_Focus <-seq(from = dt_Inicio, to = dt_Final, by = "days")
datas_Focus <- bizseq(dt_Inicio, dt_Final, cal)
vt_datas <- as.vector(which(wday(datas_Focus)==6))
datas_Focus <- as.data.frame(datas_Focus)
datas_Focus <- datas_Focus[c(vt_datas), ]
datas_Focus <- as.character(format(datas_Focus, format = '%Y%m%d'))

#####ATENÇÃO#######
#Setar wd() antes de fazer o download#
setwd("C:/Users/thiago.tiuzzi/Documents/Thiago Tiuzzi/Mono/Boletins Focus/")

#Loop para download (Especificar quantidade - Total = 887)
links = c()
for (val in datas_Focus) {

  links[val] <- paste0("http://www.bcb.gov.br/pec/GCI/PORT/readout/R", val, '.pdf')
  download.file(links[val], destfile = paste("Boletim_", val, ".pdf", sep = ""), mode="wb", quiet = TRUE)
}


url <- "https://www.bcb.gov.br/pec/GCI/PORT/readout/readout.asp"
doc <- read_html(url)

dates <- html_attr(html_nodes(doc, "a"), "href")
dates <- dates[30:929]


teste <- as.data.frame(datas_Focus)
