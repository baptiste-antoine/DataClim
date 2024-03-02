# DataClim

Ce package a pour objectif de permettre l'analyse des données mise à disposition par Météo France depuis le 01 janvier 2024.

## Installation du package 

### Données SIM
Météo France met les données de changement climatique de la chaîne Safran-Isba-Modcou sous forme de fichier compressé (.gz) pour chaque décennie depuis 1960 (données disponibles à partir du 01/08/1958). Ce fichier compressé pèse 1,1 Go et le fichier CSV qu'il contient en fait environ 3,7 Go. 

Ce package vous laisse deux options ; télécharger les fichiers que vous souhaitez utiliser via la fonction ... au cas par cas lorsque vous en avez besoin ou alors télécharger les données sous forme de fichier .rda annuel via la fonction ...

Si vous choisissez la seconde option, la marche à suivre est la suivante :
