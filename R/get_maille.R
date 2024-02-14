#' Extract cell coordinate
#'
#' @description Cette fonction permet d'extraire les coordonnees de la ou des
#' mailles correspondant a un polygone ou un point donne. Les coordonnees X et
#' Y en Lambert II étendu des mailles Meteo France ont ete fusionnee avec le
#' GeoPackage des mailles Safran de Bertuzzi et Clastre, 2022.
#'
#' @return La fonction renvoie un data frame contenant les coordonnees X et Y
#' en Lambert II étendu et correspondant au polygone ou point d'entre.
#'
#' @import sf
#' @import dplyr
#' @import tmap
#'
#' @param geom -> Polygone ou point pour lequel on veut obtenir les
#' coordonnees de la maille Safran.
#'
#' @author Baptiste ANTOINE
#'
#' @source Meteo France (<https://meteo.data.gouv.fr/>) and Bertuzzi, Patrick; Clastre,
#' Philippe, 2022, "Information sur les mailles SAFRAN", DOI 10.57745/1PDFNL,
#' Recherche Data Gouv, V2.
#'
#' @export
#'
#'
get_maille <- function(geom) {

  # maille_sim2 <- readRDS("maille_sim2.rds")
  maille_sim2 <- DataClim::maille_sim2
  maille <- sf::st_intersection(maille_sim2, geom)

  return(maille[,c(2,3)])
}


