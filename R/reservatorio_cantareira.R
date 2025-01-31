#' Dados dos reservatórios brasileiros do Sistema Cantareira
#'
#' @export
#' @param codigo_reservatorio Codigo do reservatorio a ser buscado, (voce pode consultar a tabela com os codigos chamando `tabela_reservatorios`).
#' @param data_inicial Data inicial do registro. Se for anterior a data de funcionamento, retorna a data de registro mais antiga.
#' @param data_final Data final do registro. Pode ser usado Sys.Date() para retornar a data de registro mais recente.
#'
#' @examples
#' reservatorio_cantareira(29001, "2000-01-01", Sys.Date())

reservatorio_cantareira <-
  function(codigo_reservatorio,
           data_inicial = "1980-01-01",
           data_final = Sys.Date()) {
    #info msg

    reservatorio_busca <- tabela_reservatorios() %>%
      dplyr::filter(codigo %in% codigo_reservatorio) %>%
      dplyr::select(reservatorio)

    if(nrow(reservatorio_busca) == 0){
      usethis::ui_stop("Não foi possível encontrar esse código no banco de dados. Verifique o código na tabela utilizando a função {ui_code('tabela_reservatorios()')}")
    }


    usethis::ui_info("Buscando as informações do reservatório {reservatorio_busca$reservatorio}")

    #motivational msg1
    message(motivational_message(1))

    #get url
    url <-
      glue::glue(
        "https://www.ana.gov.br/sar0/MedicaoCantareira?dropDownListReservatorios={codigo_reservatorio}&dataInicial={format.Date(data_inicial, \'%d\')}%2F{format.Date(data_inicial, \'%m\')}%2F{format.Date(data_inicial, \'%Y\')}&dataFinal={format.Date(data_final, \'%d\')}%2F{format.Date(data_final, \'%m\')}%2F{format.Date(data_final, \'%Y\')}"
      )

    nodes_table <- rvest::read_html(url) %>%
      rvest::html_nodes("table")
    #motivation msg 2
    message(motivational_message(2))
    #organiza
    table_reservoir <- nodes_table[[1]] %>%
      rvest::html_table() %>%
      janitor::clean_names() %>%
      dplyr::relocate(dplyr::last_col()) %>%
      dplyr::rename(
        data = 1,
        codigo_reservatorio = 2,
        volume_util_hm3 = 5,
        volume_util_percentual = 6,
        afluencia_m3_s = 7,
        defluencia_m3_s = 8
      )

    table_reservoir$data <- as.Date(table_reservoir$data, format = "%d/%m/%Y")
    table_reservoir$codigo_reservatorio <- as.factor(table_reservoir$codigo_reservatorio)
    table_reservoir$reservatorio <- as.factor(table_reservoir$reservatorio)
    table_reservoir$cota_m <- as.numeric(sub(",", ".", table_reservoir$cota_m))
    table_reservoir$afluencia_m3_s <- as.numeric(sub(",", ".", table_reservoir$afluencia_m3_s))
    table_reservoir$defluencia_m3_s <- as.numeric(sub(",", ".", table_reservoir$defluencia_m3_s))
    table_reservoir$volume_util_percentual <- as.numeric(sub(",", ".", table_reservoir$volume_util_percentual))
    table_reservoir$volume_util_hm3 <- as.numeric(sub(",", ".", table_reservoir$volume_util_hm3))

    if(nrow(table_reservoir) == 0){
      usethis::ui_oops("Não foi possível obter os dados. Verifique se as variáveis estão corretas ou entre em contato!")
    }else{
      usethis::ui_done(motivational_message(3))
      return(table_reservoir)
    }

  }
