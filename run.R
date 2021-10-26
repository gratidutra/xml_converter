source('xml_converter.R')

#selecione a pasta onde estão contidos os xmls

input <- list.files(pattern = ".xml")

# convertendo os xmls

all_dfs <- sapply(input, xml_converter) 

df_final <- bind_rows(all_dfs, .id = "column_label")
