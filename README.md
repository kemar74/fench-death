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

## 2.b. Installation de WAMP:
(J'espère vraiment que vous avez un OS Windows...)
[WAMP](http://www.wampserver.com/) : Installer le logiciel  
Lancer le logiciel.   
Acceder à [PhpMyAdmin](http://localhost/phpmyadmin/) et se connecter (login : root, password : aucun)  

---

## 3. Import des donnees CSV sous MySQL
Créer une base de données "project_db" avec le bouton "Nouvelle base de données" dans le menu de gauche.
![https://ibb.co/94b0znW][db_creation]  
Acceder à l'onglet "SQL"  
Lancer la commande suivante (en remplaçant ```A:/Uni-Nantes/BDD evoluee/Projet/``` par le chemin de votre dossier) :
```sql 
CREATE TABLE `project_db`.`net_salary_per_town_category` ( 
`CODGEO` VARCHAR(8) NOT NULL , 
`LIBGEO` VARCHAR(128) NOT NULL , 
`SNHM14` FLOAT NULL , 
`SNHMC14` FLOAT NULL , 
`SNHMP14` FLOAT NULL , 
`SNHME14` FLOAT NULL , 
`SNHMO14` FLOAT NULL , 
`SNHMF14` FLOAT NULL , 
`SNHMFC14` FLOAT NULL , 
`SNHMFP14` FLOAT NULL , 
`SNHMFE14` FLOAT NULL , 
`SNHMFO14` FLOAT NULL , 
`SNHMH14` FLOAT NULL , 
`SNHMHC14` FLOAT NULL , 
`SNHMHP14` FLOAT NULL , 
`SNHMHE14` FLOAT NULL , 
`SNHMHO14` FLOAT NULL , 
`SNHM1814` FLOAT NULL , 
`SNHM2614` FLOAT NULL , 
`SNHM5014` FLOAT NULL , 
`SNHMF1814` FLOAT NULL , 
`SNHMF2614` FLOAT NULL , 
`SNHMF5014` FLOAT NULL , 
`SNHMH1814` FLOAT NULL , 
`SNHMH2614` FLOAT NULL , 
`SNHMH5014` FLOAT NULL , 
PRIMARY KEY (`CODGEO`)) ENGINE = MyISAM;

CREATE TABLE `project_db`.`popultation` ( 
`NIVGEO` VARCHAR(8), 
`CODGEO` VARCHAR(8), 
`LIBGEO` VARCHAR(128) NULL, 
`MOCO` INT NULL, 
`AGEQ80_17` INT NULL, 
`SEXE` INT NULL, 
`NB` INT NULL) 
ENGINE = MyISAM;

CREATE TABLE `project_db`.`base_etablissement_par_tranche_effectif` ( `CODGEO` VARCHAR(8) NOT NULL, 
`LIBGEO` VARCHAR(128) NOT NULL, 
`REG` INT NULL, 
`DEP` INT NULL, 
`E14TST` INT NULL, 
`E14TS0ND` INT NULL, 
`E14TS1` INT NULL, 
`E14TS6` INT NULL, 
`E14TS10` INT NULL, 
`E14TS20` INT NULL, 
`E14TS50` INT NULL, 
`E14TS100` INT NULL, 
`E14TS200` INT NULL, 
`E14TS500` INT NULL) 
ENGINE = MyISAM;

CREATE TABLE `project_db`.`name_geographic_information` ( `EU_circo` VARCHAR(128) NULL,
`code_region` INT NULL,
`nom_region` VARCHAR(128) NULL,
`chef_lieu_region` VARCHAR(128) NULL,
`numero_departement` INT NULL,
`nom_departement` VARCHAR(128) NULL,
`prefecture` VARCHAR(128) NULL,
`numero_circonscription` INT NULL,
`nom_commune` VARCHAR(128) NULL,
`codes_postaux` VARCHAR(16) NULL,
`code_insee` VARCHAR(16) NULL,
`latitude` VARCHAR(16) NULL,
`longitude` VARCHAR(16) NULL,
`éloignement` FLOAT NULL)
ENGINE = MyISAM;

CREATE TABLE `project_db`.`deaths` ( `id` INT NOT NULL AUTO_INCREMENT , 
`nom` VARCHAR(128) NULL , 
`prenom` VARCHAR(128) NULL , 
`sexe` INT NULL , 
`date_naissance` DATE NULL , 
`code_lieu_naissance` VARCHAR(8) NULL , 
`commune_naissance` VARCHAR(128) NULL , 
`pays_naissance` VARCHAR(128) NULL , 
`date_deces` DATE NULL , 
`code_lieu_deces` VARCHAR(8) NULL , 
`num_acte_deces` INT NULL , 
PRIMARY KEY (`id`)) 
ENGINE = MyISAM;

LOAD DATA LOCAL INFILE 'A:/Uni-Nantes/BDD evoluee/Projet/base_etablissement_par_tranche_effectif.csv'
INTO TABLE project_db.base_etablissement_par_tranche_effectif
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'A:/Uni-Nantes/BDD evoluee/Projet/export.csv'
INTO TABLE project_db.deaths
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'A:/Uni-Nantes/BDD evoluee/Projet/name_geographic_information.csv'
INTO TABLE project_db.name_geographic_information
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'A:/Uni-Nantes/BDD evoluee/Projet/net_salary_per_town_categories.csv'
INTO TABLE project_db.net_salary_per_town_categories
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'A:/Uni-Nantes/BDD evoluee/Projet/population.csv'
INTO TABLE project_db.population
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

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

[db_creation]: https://i.ibb.co/n17yZrj/new-db.png "Creation d'une base de données"
