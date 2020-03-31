DROP DATABASE IF EXISTS `project_db`;
CREATE DATABASE `project_db`;
USE `project_db`;

DROP TABLE IF EXISTS `project_db`.`net_salary_per_town_categories`;
DROP TABLE IF EXISTS `project_db`.`population`;
DROP TABLE IF EXISTS `project_db`.`base_etablissement_par_tranche_effectif`;
DROP TABLE IF EXISTS `project_db`.`name_geographic_information`;
DROP TABLE IF EXISTS `project_db`.`deaths`;
DROP TABLE IF EXISTS `project_db`.`age`;
DROP TABLE IF EXISTS `project_db`.`population_no_moco`;
DROP TABLE IF EXISTS `project_db`.`small_deaths`;
DROP TABLE IF EXISTS `project_db`.`small_facts_table`;
DROP TABLE IF EXISTS `project_db`.`facts_table`;

CREATE TABLE `project_db`.`net_salary_per_town_categories` ( 
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

CREATE TABLE `project_db`.`population` ( 
`NIVGEO` VARCHAR(8), 
`CODGEO` VARCHAR(8) NOT NULL, 
`LIBGEO` VARCHAR(128) NULL, 
`MOCO` INT NULL, 
`AGEQ80_17` INT NOT NULL, 
`SEXE` INT NOT NULL, 
`NB` INT NULL,
PRIMARY KEY (`CODGEO`, `AGEQ80_17`, `SEXE`)) 
ENGINE = MyISAM;

CREATE TABLE `project_db`.`base_etablissement_par_tranche_effectif` ( 
`CODGEO` VARCHAR(8) NOT NULL, 
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
`E14TS500` INT NULL,
PRIMARY KEY(`CODGEO`)) 
ENGINE = MyISAM;

CREATE TABLE `project_db`.`name_geographic_information` ( 
`EU_circo` VARCHAR(128) NULL,
`code_region` INT NULL,
`nom_region` VARCHAR(128) NULL,
`chef_lieu_region` VARCHAR(128) NULL,
`numero_departement` INT NULL,
`nom_departement` VARCHAR(128) NULL,
`prefecture` VARCHAR(128) NULL,
`numero_circonscription` INT NULL,
`nom_commune` VARCHAR(128) NULL,
`codes_postaux` VARCHAR(16) NULL,
`code_insee` VARCHAR(16) NOT NULL,
`latitude` VARCHAR(16) NULL,
`longitude` VARCHAR(16) NULL,
`eloignement` FLOAT NULL,
PRIMARY KEY(`code_insee`))
ENGINE = MyISAM;

CREATE TABLE `project_db`.`deaths` ( 
`nom` VARCHAR(128) NULL , 
`prenom` VARCHAR(128) NULL , 
`sexe` INT NOT NULL , 
`date_naissance` DATE NOT NULL , 
`code_lieu_naissance` VARCHAR(8) NOT NULL , 
`commune_naissance` VARCHAR(128) NULL , 
`pays_naissance` VARCHAR(128) NULL , 
`date_deces` DATE NOT NULL , 
`code_lieu_deces` VARCHAR(8) NOT NULL , 
`numero_acte_deces` INT NULL,
INDEX `IND_SEXE` (`sexe`),
INDEX `IND_DATE_DECES` (`date_deces`),
INDEX `IND_CODE_DECES` (`code_lieu_deces`),
INDEX `IND_DATE_NAISS` (`date_naissance`),
INDEX `IND_CODE_NAISS` (`code_lieu_naissance`)) 
ENGINE = MyISAM;

CREATE TABLE `project_db`.`age` (
`id_age` INT NOT NULL,
`decenie` INT,
`tranche_age` VARCHAR(128),
`age80_17` INT,
PRIMARY KEY(`id_age`))
ENGINE = MyISAM;

CREATE TABLE `project_db`.`population_no_moco` ( 
`CODGEO` VARCHAR(8) NOT NULL, 
`LIBGEO` VARCHAR(128) NULL,
`AGEQ80_17` INT NOT NULL, 
`SEXE` INT NOT NULL, 
`NB` INT NULL,
PRIMARY KEY (`CODGEO`, `AGEQ80_17`, `SEXE`)) 
ENGINE = MyISAM;