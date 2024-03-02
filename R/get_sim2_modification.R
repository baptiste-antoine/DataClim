get_sim2 <- function(years, x, y) {

  SIM2_results <- list()

  for (year in years) {

    nom_dataframe <- paste0("SIM2_", year)
    file_path <- paste("D:/DataClimStorageA00/DataClimStorageA00/data/", nom_dataframe, ".rda", sep = "")

    env <- new.env() # Charger le fichier dans un nouvel environnement
    load(file_path, envir = env)

    data <- get(nom_dataframe, envir = env) # Extraire l'objet de l'environnement
    filtered_data <- data %>% dplyr::filter(LAMBX == x & LAMBY == y)
    SIM2_results[[as.character(year)]] <- filtered_data

    rm(env, data, filtered_data)
    gc()
  }


  result_df <- do.call(rbind, SIM2_results) # Combiner les résultats en un seul data frame
  rm(SIM2_results)
  gc() # Nettoyer la mémoire

  return(result_df)
}

system.file(package = "DataClim")

