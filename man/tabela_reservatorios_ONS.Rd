% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tabela_reservatorios_ONS.R
\name{tabela_reservatorios_ONS}
\alias{tabela_reservatorios_ONS}
\title{Tabela com dados dos reservatorios brasileiros apresentados pela ONS}
\format{
Um dataframe com 39 observacoes e 12 variaveis
\describe{

\item{subsistema}{subsistema-ONS a qual o reservatorio pertence}
\item{reservatorio}{o nome do reservatorio}
\item{codigo}{o codigo do reservatorio segundo o SAR}
\item{res_latitude}{latitude do reservatorio}
\item{res_longitude}{longitude do reservatorio}
\item{municipio}{municipio do reservatorio}
\item{codigo_municipio_ibge}{codigo do municipio na base do ibge}
\item{estado_nome}{estado em forma de nome}
\item{estado_sigla}{estado em forma de sigla}
\item{rio}{nome do rio}
\item{sub_bacia}{sub-bacia do rio}
\item{bacia}{bacia hidrográfica do rio}
}
}
\source{
ANA (Antônio Augusto, Diego Pena e Théo Albuquerque) e \url{http://www.ons.org.br/paginas/energia-agora/reservatorios}, editado por Bruno Mioto. obtido em 2021-10-22.
}
\usage{
tabela_reservatorios_ONS()
}
\description{
Um dataset contendo os atributos dos principais reservatorios brasileiros apresentados pela ONS.
}
\examples{
tabela_reservatorios_ONS()
}
