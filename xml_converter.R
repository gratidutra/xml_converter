xml_converter <-  function(input) {
  
  print("Iniciando conversão...")
  
  # verificando se existe o pacote pacman se não instala
  
  if (any("pacman" == FALSE)) {
    install.packages(packages[!pacman])
  }
  
  # chamadno o packeage pacman
  
  library(pacman)
  
  # verificando se existe os pacote necessário com o pacman se não instala e chama
  
  pacman::p_load(XML, tidyverse, methods, data.table, readr)
  
  # Lendo os arquivos xmls
  
  xml <- xmlParse(input)
  
  # Transformando em lista os xmls
  
  list_xml <- xmlToList(xml)
  
  # retirando da lista o xml para transformar em formato de tabela
  
  unlist_xml <- unlist(list_xml, use.names = T)
  
  # Criando um dataframe
  
  xml_df <- data.frame(t(unlist_xml),
                       row.names = NULL
  )
  
  # Realizando a transposta da transposta para que não seja perdida as perguntas
  
  xml_df_long <- t(xml_df)
  
  # Como o dataframe está com rownames é necessário transformar as row.names em uma coluna
  
  names <- rownames(xml_df_long)
  
  rownames(xml_df_long) <- NULL
  
  # Criando uma nova variável que contém as infos com a pergunta e resposta
  
  data <- cbind(names, xml_df_long)
  
  # Transformando esse objeto data em data frame
  
  data <- data.frame(data)
  
  # Renomeando as colunas
  
  data <- data %>% rename(
    pergunta = names,
    resposta = V2
  )
  
  # Criando a tabela final com os resultados
  
  df <- data %>%
    group_by(pergunta) %>%
    mutate(row = row_number()) %>%
    tidyr::pivot_wider(names_from = pergunta, values_from = resposta) %>%
    select(-row)
  
  print("xmls transformados!")
  
  return(df)
}



