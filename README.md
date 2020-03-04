# french-death
Projet d'analyse de BDD sous MongoDB

-----

## 1. Récupération des données
Télécharger et décompressez les fichiers suivants :

Les données utilisées sont issues de l'INSEE, regroupées par [@flo2607](https://www.kaggle.com/flo2607) et [@etiennelq](https://www.kaggle.com/etiennelq) sur la plateforme [Kaggle](https://www.kaggle.com).

### _*Paquet 1 : [french death : list of death certificates in france](https://www.kaggle.com/flo2607/french-death)*_  
Lien de téléchargement : https://www.kaggle.com/flo2607/french-death/download (2GB)  
Description : Liste des données concernant les personnes décédées entre 1970 et 2020  

### __*Paquet 2 : [French employment, salaries, population per town : Some data to show equality and inequalities in France](https://www.kaggle.com/etiennelq/french-employment-by-town)*__  
Lien de téléchargement : https://www.kaggle.com/etiennelq/french-employment-by-town/download (344MB)  
Description : Données relatives à chaque ville de France : population, economie, nombre d'entreprises, ...  

---

## 2. Installation de MongoDB
Lien de téléchargement : https://www.mongodb.com/download-center/community  
*REM : nous utilisons la version 4.2.3*
Ajouter le dossier "/bin" de mongoDB dans la variable d'environement PATH.

## 2.bis Installation de Robo T3 *(optionnel)*
[Robo T3](https://robomongo.org/) est une GUI pour MongoDB, ça peut être utile ;)  
Lien de téléchargement : https://studio3t.com/download/

---

## 3. Import des données CSV
Ouvrir un terminal (<kdb>Ctrl</kdb> + <kdb>R</kdb>, puis tapez "cmd" et <kdb>ENTER</kdb> sous Windows) et naviguez jusqu'au dossier contenant les données téléchargées.  
```console
> cd mon\chemin\vers\les\donnees
```
Créer le Dataset "death-french" pour MongoDB et importer les fichiers:  
```console
mongoimport --type csv -d death-french -c deaths --headerline --drop export.csv
mongoimport --type csv -d death-french -c base_etablissement_par_tranche_effectif --headerline --drop base_etablissement_par_tranche_effectif.csv
mongoimport --type csv -d death-french -c name_geographic_information --headerline --drop name_geographic_information.csv
mongoimport --type csv -d death-french -c net_salary_per_town_categories --headerline --drop net_salary_per_town_categories.csv
mongoimport --type csv -d death-french -c population --headerline --drop population.csv  
```
Le dernier fichier peut durer quelques minutes.

---

## 4. Faire la suite
Voilà.
