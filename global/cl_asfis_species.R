produce_cl_asfis_species<-function(dest=getwd()){

  link<-'https://www.fao.org/fishery/static/ASFIS/ASFIS_sp.zip'
  
  path<-file.path(tempdir(),"ASFIS_sp.zip")
  unziped<-gsub(".zip","",path)
  download.file(url = link, destfile = path)
  utils::unzip(zipfile = path, exdir = unziped, unzip = getOption("unzip"))
  
  folder_file<-list.files(unziped,full.names = T)
  
  match<-folder_file[grepl('*.txt', folder_file)]
  
  data<-readr::read_csv(match)
  
  reformat<-data.frame(code=data$`3A_CODE`,
             uri=rep("",nrow(data)),
             label=data$English_name,
             definition=data$Scientific_Name,
             name_en=data$English_name,
             name_fr=data$French_name,
             name_es=data$Spanish_name,
             name_ar=data$Arabic_name,
             name_cn=data$Chinese_name,
             name_ru=data$Russian_name,
             isscaap_group_code=data$ISSCAAP,
             scientific_name=data$Scientific_Name,
             taxonomic_code=data$TAXOCODE,
             author=data$Author,
             family=data$Family,
             order=data$Order)
  
  reformat[is.na(reformat)] <- ""
  
  write.csv(reformat,paste0(dest,"/cl_asfis_species.csv"),fileEncoding = "UTF-8", row.names=FALSE, quote=FALSE)
  
}
