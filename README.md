# DataClim

Ce package a pour objectif de permettre l'analyse des données mise à disposition par Météo France depuis le 01 janvier 2024.

## Installation du package 

### Données SIM
Météo France met les données de changement climatique de la chaîne Safran-Isba-Modcou sous forme de fichier compressé (.gz) pour chaque décennie depuis 1960 (données disponibles à partir du 01/08/1958). Ce fichier compressé pèse 1,1 Go et le fichier CSV qu'il contient en fait environ 3,7 Go ; soit environ 24 Go de données à ce jour. 

Ce package vous laisse deux options ; télécharger les fichiers que vous souhaitez utiliser via la fonction ... au cas par cas, lorsque vous en avez besoin ou alors télécharger les données sous forme de fichier .rda annuel via la fonction .... L'avantage principal de cette méthode est le gain de place puisque les données ne représentent plus que 3,3 Go à ce jour, soit plus de sept fois moins que les fichiers initiaux de Météo France. 

A vous de voir ce que vous préférez en fonction de l'utilisation que vous ferez des données SIM, et de la fréquence à laquelle vous devez y accéder. 

Si vous choisissez la seconde option, la marche à suivre est la suivante :
