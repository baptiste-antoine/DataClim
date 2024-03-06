rm(list = ls())

# Charger les packages
library(httr)
library(jsonlite)

# Définir l'URL de l'API
url <- "https://cckpapi.worldbank.org/cckp/v1/cmip6-x0.25_timeseries_tas_timeseries_annual_1950-2014,2015-2100_mean,median_historical,ssp126,ssp245,ssp370,ssp585_ensemble_all_mean/FRA?_format=json"

# Envoyer une requête GET à l'API
response <- GET(url)

# Vérifier si la requête a réussi (statut 200)
if (http_status(response)$category == "Success") {
  # Lire et traiter les données JSON
  data <- fromJSON(content(response, "text", encoding = "UTF-8"))
  
  # Afficher ou traiter les données selon vos besoins
  print(data)
} else {
  cat("La requête a échoué. Statut:", http_status(response)$reason)
}

historical <- data.frame(temp = t(as.data.frame(data$data$`1950-2014`$median$historical$FRA)), year = c(1950:2014))
ssp126 <- data.frame(temp = t(as.data.frame(data$data$`2015-2100`$median$ssp126)), year = c(2015:2100))
ssp245 <- data.frame(temp = t(as.data.frame(data$data$`2015-2100`$median$ssp245)), year = c(2015:2100))
ssp370 <- data.frame(temp = t(as.data.frame(data$data$`2015-2100`$median$ssp370)), year = c(2015:2100))
ssp585 <- data.frame(temp = t(as.data.frame(data$data$`2015-2100`$median$ssp585)), year = c(2015:2100))


library(dplyr)
library(DataClim)
data <- DataClim::get_sim2(c(1970:1999), x =600, y = 24010)
data$year <-  substr(data$DATE, 1, 4)
data <- data %>% group_by(year) %>% summarise(temp = mean(T_Q))

temp <- data.frame()
temp <- rbind(temp, data)

ssp126 <- rbind(tail(historical, 1), ssp126)
ssp245 <- rbind(tail(historical, 1), ssp245)
ssp370 <- rbind(tail(historical, 1), ssp370)
ssp585 <- rbind(tail(historical, 1), ssp585)

# Plotting
plot(ssp585$year, ssp585$temp, col = "red", type = "l", xlim = c(1950,2100),
     ylim = c(10,17))
lines(data$year, data$France, type = 'l', main = "France Population Over Years", xlab = "Year", ylab = "Population")
lines(ssp370$year, ssp370$temp, col = "orange", type = "l")
lines(ssp245$year, ssp245$temp, col = "blue", type = "l")
lines(ssp126$year, ssp126$temp, col = "green", type = "l")
lines(historical$year, historical$temp, col = "black", type = "l")
lines(data$year, data$temp, type = "p")


# Fit a linear model
model <- lm(France ~ year, data = data)

# Add fitted values
lines(data$year, fitted(model), col = "red", lty = 2)

# Add confidence intervals
intervals <- predict(model, interval = "confidence")
lines(data$year, intervals[, "lwr"], col = "blue", lty = 3)
lines(data$year, intervals[, "upr"], col = "blue", lty = 3)

# Add prediction intervals
prediction_intervals <- predict(model, interval = "prediction")
lines(data$year, prediction_intervals[, "lwr"], col = "green", lty = 4)
lines(data$year, prediction_intervals[, "upr"], col = "green", lty = 4)

# Add legend
legend("topleft", legend = c("Observed", "Fitted Values", "95% Confidence Intervals", "95% Prediction Intervals"),
       col = c("black", "red", "blue", "green"), lty = c(1, 2, 3, 4))




