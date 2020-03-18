# french-death
Projet d'analyse de BDD sous MySQL

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

## 2. Installation de WAMP:
- Pour Windows
[WAMP](http://www.wampserver.com/) : Installer le logiciel WAMP  
Lancer le logiciel.   
Acceder à [PhpMyAdmin](http://localhost/phpmyadmin/) et se connecter (login : root, password : aucun)  

- Pour Linux  
Demerdez-vous, j'ai aucune idée...  


---

## 3. Import des donnees CSV sous MySQL
### Depuis GitHub
Veillez à ce que le fichier "db_login.txt", "db_installer.exe" et les données décompressées (CSV) soient dans le même répertoire.  
Remplissez les informations de "db_login.txt" pour qu'il ressemble à
```
hostname
username
password
```
Les valeurs dans le fichier sont corrects pour les utilisateurs souhaitant executer le script en local avec le login "root" sans mot de passe.   
Lancez l'executable "db_installer.exe", patientez (cela peut durer au moins 10 minutes).   
Si une erreur apparait lors de l'installation (du type "[WARN] MySQLError during execute statement", recopiez la commande sur PhpMyAdmin (http://localhost/phpmyadmin/db_sql.php?db=project_db) pour l'executer manuellement, puis continuez le programme en appuyant sur < ENTRER >.   
Les données sont là!  
La BDD ressemble à cela :  
![db_done]

Les tables "population_no_moco", "small_deaths" et "small_facts_table" sont les versions "très light" de "population", "deaths" et "facts_table".

---

## 4. Faire la suite
Voilà.


# Avec MongoDB (liste incomplète...)

## 1. Installation de MongoDB
Lien de téléchargement : https://www.mongodb.com/download-center/community  
*REM : nous utilisons la version 4.2.3*
Ajouter le dossier "/bin" de mongoDB dans la variable d'environement PATH.

## 2 Installation de Robo T3 *(optionnel)*
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

[db_creation]: https://i.ibb.co/n17yZrj/new-db.png "Creation d'une base de données"
[db_done]: https://i.ibb.co/jLVq67M/tables.png "Resumé des tables"
