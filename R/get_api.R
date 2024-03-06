#' #chargement des librairies
#' rm(list = ls())
#' library(rjson)
#' library(ggplot2)
#' library(httr)
#' #'
#' #Récupération des informations
#' url_service="https://api.geosas.fr/edr/collections/safran-isba"
#' data_info = fromJSON(file=url_service)
#'
#' for (parametre in data_info$parameter_names) {
#'   name=names(parametre)
#'   print(name)
#'   print(parametre[[name]]$description)
#' }
#'
#' param_name='T_Q'
#' # Pour coord nécessite de remplacer l'espace par %20
#' # sinon la librairie rjson plante
#' #'POINT(349598 6798263)' devient :
#' coord='POINT(349598%206798263)'
#' projection='EPSG:2154'
#' formatage='CoverageJSON'
#' date='2022-07-01/2022-07-31'
#' requete=sprintf('%sposition?coords=%s&crs=%s&parameter-name=%s&f=%s&datetime=%s',
#'                 url_service,coord,projection,param_name,formatage,date)
#' print(requete)
#'
#' data = fromJSON(file=requete)
#'
#' date_value <- data$domain$axes$t$values
#' values <- data$ranges[[param_name]]$values
#'
#' cat("Exemple de date pour définir le format:", date_value[1], "\n")
#' df=data.frame(date=date_value,parametre=values)
#' df$date <- as.POSIXct(df$date , format='%Y-%m-%dT%H-%M-%SZ')
#' colnames(df)[2] <- param_name
#' print(df)

get_api <- function(url_service, param_name, coord, projection, formatage, date) {
  # Récupération des informations
  data_info <- fromJSON(file = url_service)

  for (parametre in data_info$parameter_names) {
    name <- names(parametre)
    print(name)
    print(parametre[[name]]$description)
  }

  # Pour coord nécessite de remplacer l'espace par %20
  coord <- gsub(" ", "%20", coord)

  requete <- sprintf('%sposition?coords=%s&crs=%s&parameter-name=%s&f=%s&datetime=%s',
                     url_service, coord, projection, param_name, formatage, date)
  print(requete)

  data <- fromJSON(file = requete)

  date_value <- data$domain$axes$t$values
  values <- data$ranges[[param_name]]$values

  cat("Exemple de date pour définir le format:", date_value[1], "\n")
  df <- data.frame(date = date_value, parametre = values)
  df$date <- as.POSIXct(df$date, format = '%Y-%m-%dT%H-%M-%SZ')
  colnames(df)[2] <- param_name

  print(df)
}

# Exemple d'utilisation de la fonction
url_service <- 'https://api.geosas.fr/edr/collections/safran-isba/'
param_name <- 'T_Q'
coord <- 'POINT(349598 6798263)'
projection <- 'EPSG:2154'
formatage <- 'CoverageJSON'
date <- '2022-07-01/2022-07-31'

data <- get_api(url_service, param_name, coord, projection, formatage, date)

