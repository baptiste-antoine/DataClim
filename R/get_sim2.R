#' Extract SIM2 climate data
#'
#' @description Cette fonction permet d'extraire pour une maille donnee les
#' donnees fournies par Meteo France dans son modele de surface Safran-Isba-Modcou.
#' La periode d'extraction est limitee a 30 ans pour des questions de RAM.
#'
#' @return La fonction renvoie un data frame contenant les 28 vaiables du modèle Safran-Isba-Modcou de Meteo France
#'
#' @import dplyr
#'
#' @param years -> Sélection des années ; maximum 30
#' @param x -> Coordonnees X de la maille en LAMBERT
#' @param y -> Coordonnees Y de la maille en LAMBERT
#'
#' @author Baptiste ANTOINE
#'
#' @source Meteo France -> meteo.data.gouv.fr
#'
#' @export
#'
#'
#'
get_sim2 <- function(years, x, y) {

  # List of DataClimStorage package names
  package_names <- c("DataClimStorageA60", "DataClimStorageA70", "DataClimStorageA80",
                     "DataClimStorageA90", "DataClimStorageA00", "DataClimStorageA10",
                     "DataClimStorageA20")

  for (year in years) {
    for (pkg_name in package_names) {
      version_range <- as.numeric(stringr::str_extract(pkg_name, "\\d+"))
      year <- as.numeric(stringr::str_sub(year, -2, -1))
      decade_start <- floor(year / 10) * 10
      decade_end <- ceiling(year / 10) * 10 -1

      if (version_range >= decade_start && version_range <= decade_end) {
        if (requireNamespace(pkg_name, quietly = TRUE)) {
          # Load the package if not already loaded
          library(pkg_name, character.only = TRUE)
        }
      }
    }
  }

  dataframes_annees <- lapply(years, function(year) {
    nom_dataframe <- paste0("SIM2_", year)
    data <- get(nom_dataframe)
    data <- data %>% dplyr::filter(data$LAMBX == x & data$LAMBY == y)
    # SIM2_results <- rbind(SIM2_results, data)
  })

  # Détacher les packages avant de quitter la fonction
  # Obtenez la liste des packages chargés
  loaded_packages <- search()

  # Filtrer les packages dont le nom commence par "DataClimS"
  dataclim_packages <- grep("^package:DataClimS", loaded_packages, value = TRUE)

  # Détacher chaque package
  for (package in dataclim_packages) {
    detach(package, unload = TRUE, character.only = TRUE)
  }

  gc()

  return(do.call(rbind, dataframes_annees))
}




