-- Normalisation des codes INSEE
UPDATE name_geographic_information
SET code_insee = CONCAT("0", code_insee)
WHERE CHAR_LENGTH(code_insee) = 4;

-- Creation d'une table population 7 fois plus petite (pas de MOCO)
CREATE TABLE `project_db`.`population_no_moco` ( 
`CODGEO` VARCHAR(8) NOT NULL, 
`LIBGEO` VARCHAR(128) NULL,
`AGEQ80_17` INT NOT NULL, 
`SEXE` INT NOT NULL, 
`NB` INT NULL,
PRIMARY KEY (`CODGEO`, `AGEQ80_17`, `SEXE`)) 
ENGINE = MyISAM;

INSERT IGNORE INTO `project_db`.`population_no_moco` 
SELECT `CODGEO`, LIBGEO, AGEQ80_17, SEXE, SUM(NB) AS NB 
FROM `project_db`.`population` 
GROUP BY `CODGEO`, LIBGEO, AGEQ80_17, SEXE;

-- Remplissage de la table "age" 
INSERT IGNORE INTO `project_db`.`age` (id_age, decenie, tranche_age, age80_17) VALUES  (1, 0, "0-5", 0), (2, 0, "0-5", 0), (3, 0, "0-5", 0), (4, 0, "0-5", 0), (5, 0, "0-5", 0), (6, 0, "5-10", 5), (7, 0, "5-10", 5), (8, 0, "5-10", 5), (9, 0, "5-10", 5), (10, 10, "10-15", 10), (11, 10, "10-15", 10), (12, 10, "10-15", 10), (13, 10, "10-15", 10), (14, 10, "10-15", 10), (15, 10, "10-15", 10), (16, 10, "15-20", 15), (17, 10, "15-20", 15), (18, 10, "15-20", 15), (19, 10, "15-20", 15), (20, 20, "20-25", 20), (21, 20, "20-25", 20), (22, 20, "20-25", 20), (23, 20, "20-25", 20), (24, 20, "20-25", 20), (25, 20, "20-25", 20), (26, 20, "25-30", 25), (27, 20, "25-30", 25), (28, 20, "25-30", 25), (29, 20, "25-30", 25), (30, 30, "30-35", 30), (31, 30, "30-35", 30), (32, 30, "30-35", 30), (33, 30, "30-35", 30), (34, 30, "30-35", 30), (35, 30, "30-35", 30), (36, 30, "35-40", 35), (37, 30, "35-40", 35), (38, 30, "35-40", 35), (39, 30, "35-40", 35), (40, 40, "40-45", 40), (41, 40, "40-45", 40), (42, 40, "40-45", 40), (43, 40, "40-45", 40), (44, 40, "40-45", 40), (45, 40, "40-45", 40), (46, 40, "45-50", 45), (47, 40, "45-50", 45), (48, 40, "45-50", 45), (49, 40, "45-50", 45), (50, 50, "50-55", 50), (51, 50, "50-55", 50), (52, 50, "50-55", 50), (53, 50, "50-55", 50), (54, 50, "50-55", 50), (55, 50, "50-55", 50), (56, 50, "55-60", 55), (57, 50, "55-60", 55), (58, 50, "55-60", 55), (59, 50, "55-60", 55), (60, 60, "60-65", 60), (61, 60, "60-65", 60), (62, 60, "60-65", 60), (63, 60, "60-65", 60), (64, 60, "60-65", 60), (65, 60, "60-65", 60), (66, 60, "65-70", 65), (67, 60, "65-70", 65), (68, 60, "65-70", 65), (69, 60, "65-70", 65), (70, 70, "70-75", 70), (71, 70, "70-75", 70), (72, 70, "70-75", 70), (73, 70, "70-75", 70), (74, 70, "70-75", 70), (75, 70, "70-75", 70), (76, 70, "75-80", 75), (77, 70, "75-80", 75), (78, 70, "75-80", 75), (79, 70, "75-80", 75), (80, 80, "80-85", 80), (81, 80, "80-85", 80), (82, 80, "80-85", 80), (83, 80, "80-85", 80), (84, 80, "80-85", 80), (85, 80, "80-85", 80), (86, 80, "85-90", 85), (87, 80, "85-90", 85), (88, 80, "85-90", 85), (89, 80, "85-90", 85), (90, 90, "90-95", 90), (91, 90, "90-95", 90), (92, 90, "90-95", 90), (93, 90, "90-95", 90), (94, 90, "90-95", 90), (95, 90, "90-95", 90), (96, 90, "95-100", 95), (97, 90, "95-100", 95), (98, 90, "95-100", 95), (99, 90, "95-100", 95), (100, 100, "100-105", 100), (101, 100, "100-105", 100), (102, 100, "100-105", 100), (103, 100, "100-105", 100), (104, 100, "100-105", 100), (105, 100, "100-105", 100), (106, 100, "105-110", 105), (107, 100, "105-110", 105), (108, 100, "105-110", 105), (109, 100, "105-110", 105), (110, 110, "110-115", 110), (111, 110, "110-115", 110), (112, 110, "110-115", 110), (113, 110, "110-115", 110), (114, 110, "110-115", 110), (115, 110, "110-115", 110), (116, 110, "115-120", 115), (117, 110, "115-120", 115), (118, 110, "115-120", 115), (119, 110, "115-120", 115), (120, 120, "120-125", 120), (121, 120, "120-125", 120), (122, 120, "120-125", 120), (123, 120, "120-125", 120), (124, 120, "120-125", 120), (125, 120, "120-125", 120), (126, 120, "125-130", 125), (127, 120, "125-130", 125), (128, 120, "125-130", 125), (129, 120, "125-130", 125), (130, 130, "130-135", 130), (131, 130, "130-135", 130), (132, 130, "130-135", 130), (133, 130, "130-135", 130), (134, 130, "130-135", 130), (135, 130, "130-135", 130), (136, 130, "135-140", 135), (137, 130, "135-140", 135), (138, 130, "135-140", 135), (139, 130, "135-140", 135), (140, 140, "140-145", 140), (141, 140, "140-145", 140), (142, 140, "140-145", 140), (143, 140, "140-145", 140), (144, 140, "140-145", 140), (145, 140, "140-145", 140), (146, 140, "145-150", 145), (147, 140, "145-150", 145), (148, 140, "145-150", 145), (149, 140, "145-150", 145), (150, 150, "150-155", 150), (151, 150, "150-155", 150), (152, 150, "150-155", 150), (153, 150, "150-155", 150), (154, 150, "150-155", 150), (155, 150, "150-155", 150), (156, 150, "155-160", 155), (157, 150, "155-160", 155), (158, 150, "155-160", 155), (159, 150, "155-160", 155), (160, 160, "160-165", 160), (161, 160, "160-165", 160), (162, 160, "160-165", 160), (163, 160, "160-165", 160), (164, 160, "160-165", 160), (165, 160, "160-165", 160), (166, 160, "165-170", 165), (167, 160, "165-170", 165), (168, 160, "165-170", 165), (169, 160, "165-170", 165), (170, 170, "170-175", 170), (171, 170, "170-175", 170), (172, 170, "170-175", 170), (173, 170, "170-175", 170), (174, 170, "170-175", 170), (175, 170, "170-175", 170), (176, 170, "175-180", 175), (177, 170, "175-180", 175), (178, 170, "175-180", 175), (179, 170, "175-180", 175), (180, 180, "180-185", 180), (181, 180, "180-185", 180), (182, 180, "180-185", 180), (183, 180, "180-185", 180), (184, 180, "180-185", 180), (185, 180, "180-185", 180), (186, 180, "185-190", 185), (187, 180, "185-190", 185), (188, 180, "185-190", 185), (189, 180, "185-190", 185), (190, 190, "190-195", 190), (191, 190, "190-195", 190), (192, 190, "190-195", 190), (193, 190, "190-195", 190), (194, 190, "190-195", 190), (195, 190, "190-195", 190), (196, 190, "195-200", 195), (197, 190, "195-200", 195), (198, 190, "195-200", 195), (199, 190, "195-200", 195), (200, 200, "200-205", 200) ;


-- Table minimisée de "deaths"
CREATE TABLE `project_db`.`small_deaths` LIKE `project_db`.`deaths`;
INSERT IGNORE INTO `project_db`.`small_deaths`
    SELECT * FROM `project_db`.`deaths` WHERE date_deces > '2020-01-01';




-- /!\ Have a break ;) /!\


-- Small facts view and table
CREATE OR REPLACE VIEW small_facts AS
	SELECT pop.CODGEO AS code_commune, ngi.numero_departement AS code_dpt, ngi.code_region AS code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AS id_age, 
	    COUNT(*) AS nb_deaths,
	    pop.SEXE AS sexe,
	    IF(pop.SEXE = 1, nsptc.SNHMH14 , nsptc.SNHMF14 ) AS salaire_moyen_net,
        IF(pop.SEXE = 1, nsptc.SNHMHC14 , nsptc.SNHMFC14 ) AS salaire_moyen_direction,
        IF(pop.SEXE = 1, nsptc.SNHMHP14 , nsptc.SNHMFP14 ) AS salaire_moyen_cadre,
        IF(pop.SEXE = 1, nsptc.SNHMHE14 , nsptc.SNHMFE14 ) AS salaire_moyen_employe,
        IF(pop.SEXE = 1, nsptc.SNHMHO14 , nsptc.SNHMFO14 ) AS salaire_moyen_ouvrier,
        IF(pop.SEXE = 1, 
           IF(a.id_age <= 25, nsptc.SNHMH1814, 
             IF(a.id_age <= 50, nsptc.SNHMH2614, nsptc.SNHMH5014)),
           IF(a.id_age <= 25, nsptc.SNHMF1814, 
             IF(a.id_age <= 50, nsptc.SNHMF2614, nsptc.SNHMF5014))) AS salaire_moyen_age
	FROM population_no_moco pop 
	JOIN name_geographic_information ngi ON ngi.code_insee = pop.CODGEO 
	JOIN small_deaths d ON d.code_lieu_deces = pop.CODGEO AND d.sexe = pop.SEXE 
	JOIN age a ON a.id_age = TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AND a.age80_17 = pop.AGEQ80_17 
	LEFT JOIN net_salary_per_town_categories nsptc ON ngi.code_insee = nsptc.CODGEO     
	GROUP BY pop.CODGEO, ngi.numero_departement, ngi.code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces), pop.SEXE;

CREATE TABLE `project_db`.`small_facts_table` (
code_commune VARCHAR(128),
code_dpt VARCHAR(8), 
code_region VARCHAR(8),
id_age INT, 
nb_deaths INT,
sexe INT,
salaire_moyen_net FLOAT,
salaire_moyen_direction FLOAT,
salaire_moyen_cadre FLOAT,
salaire_moyen_employe FLOAT,
salaire_moyen_ouvrier FLOAT,
salaire_moyen_age FLOAT,
UNIQUE `code_commune` (`code_commune`, `id_age`, `sexe`) USING BTREE
);
INSERT IGNORE INTO `project_db`.`small_facts_table` 
	SELECT pop.CODGEO AS code_commune, ngi.numero_departement AS code_dpt, ngi.code_region AS code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AS id_age, 
	    COUNT(*) AS nb_deaths,
	    pop.SEXE AS sexe,
	    IF(pop.SEXE = 1, nsptc.SNHMH14 , nsptc.SNHMF14 ) AS salaire_moyen_net,
        IF(pop.SEXE = 1, nsptc.SNHMHC14 , nsptc.SNHMFC14 ) AS salaire_moyen_direction,
        IF(pop.SEXE = 1, nsptc.SNHMHP14 , nsptc.SNHMFP14 ) AS salaire_moyen_cadre,
        IF(pop.SEXE = 1, nsptc.SNHMHE14 , nsptc.SNHMFE14 ) AS salaire_moyen_employe,
        IF(pop.SEXE = 1, nsptc.SNHMHO14 , nsptc.SNHMFO14 ) AS salaire_moyen_ouvrier,
        IF(pop.SEXE = 1, 
           IF(a.id_age <= 25, nsptc.SNHMH1814, 
             IF(a.id_age <= 50, nsptc.SNHMH2614, nsptc.SNHMH5014)),
           IF(a.id_age <= 25, nsptc.SNHMF1814, 
             IF(a.id_age <= 50, nsptc.SNHMF2614, nsptc.SNHMF5014))) AS salaire_moyen_age
	FROM population_no_moco pop 
	JOIN name_geographic_information ngi ON ngi.code_insee = pop.CODGEO 
	JOIN small_deaths d ON d.code_lieu_deces = pop.CODGEO AND d.sexe = pop.SEXE 
	JOIN age a ON a.id_age = TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AND a.age80_17 = pop.AGEQ80_17 
	LEFT JOIN net_salary_per_town_categories nsptc ON ngi.code_insee = nsptc.CODGEO 
	GROUP BY pop.CODGEO, ngi.numero_departement, ngi.code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces), pop.SEXE;


-- /!\ Have a break ;) /!\



CREATE OR REPLACE VIEW facts AS
	SELECT pop.CODGEO AS code_commune, ngi.numero_departement AS code_dpt, ngi.code_region AS code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AS id_age, 
	    COUNT(*) AS nb_deaths,
	    pop.SEXE AS sexe,
	    IF(pop.SEXE = 1, nsptc.SNHMH14 , nsptc.SNHMF14 ) AS salaire_moyen_net,
        IF(pop.SEXE = 1, nsptc.SNHMHC14 , nsptc.SNHMFC14 ) AS salaire_moyen_direction,
        IF(pop.SEXE = 1, nsptc.SNHMHP14 , nsptc.SNHMFP14 ) AS salaire_moyen_cadre,
        IF(pop.SEXE = 1, nsptc.SNHMHE14 , nsptc.SNHMFE14 ) AS salaire_moyen_employe,
        IF(pop.SEXE = 1, nsptc.SNHMHO14 , nsptc.SNHMFO14 ) AS salaire_moyen_ouvrier,
        IF(pop.SEXE = 1, 
           IF(a.id_age <= 25, nsptc.SNHMH1814, 
             IF(a.id_age <= 50, nsptc.SNHMH2614, nsptc.SNHMH5014)),
           IF(a.id_age <= 25, nsptc.SNHMF1814, 
             IF(a.id_age <= 50, nsptc.SNHMF2614, nsptc.SNHMF5014))) AS salaire_moyen_age
	FROM population_no_moco pop 
	JOIN name_geographic_information ngi ON ngi.code_insee = pop.CODGEO 
	JOIN deaths d ON d.code_lieu_deces = pop.CODGEO AND d.sexe = pop.SEXE 
	JOIN age a ON a.id_age = TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AND a.age80_17 = pop.AGEQ80_17 
	LEFT JOIN net_salary_per_town_categories nsptc ON ngi.code_insee = nsptc.CODGEO 

	GROUP BY pop.CODGEO, ngi.numero_departement, ngi.code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces), pop.SEXE;

CREATE TABLE `project_db`.`facts_table` (
code_commune VARCHAR(128),
code_dpt VARCHAR(8), 
code_region VARCHAR(8),
id_age INT, 
nb_deaths INT,
sexe INT,
salaire_moyen_net FLOAT,
salaire_moyen_direction FLOAT,
salaire_moyen_cadre FLOAT,
salaire_moyen_employe FLOAT,
salaire_moyen_ouvrier FLOAT,
salaire_moyen_age FLOAT,
UNIQUE `code_commune` (`code_commune`, `id_age`, `sexe`) USING BTREE
);
INSERT IGNORE INTO `project_db`.`facts_table` 
	SELECT pop.CODGEO AS code_commune, ngi.numero_departement AS code_dpt, ngi.code_region AS code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AS id_age, 
	    COUNT(*) AS nb_deaths,
	    pop.SEXE AS sexe,
	    IF(pop.SEXE = 1, nsptc.SNHMH14 , nsptc.SNHMF14 ) AS salaire_moyen_net,
        IF(pop.SEXE = 1, nsptc.SNHMHC14 , nsptc.SNHMFC14 ) AS salaire_moyen_direction,
        IF(pop.SEXE = 1, nsptc.SNHMHP14 , nsptc.SNHMFP14 ) AS salaire_moyen_cadre,
        IF(pop.SEXE = 1, nsptc.SNHMHE14 , nsptc.SNHMFE14 ) AS salaire_moyen_employe,
        IF(pop.SEXE = 1, nsptc.SNHMHO14 , nsptc.SNHMFO14 ) AS salaire_moyen_ouvrier,
        IF(pop.SEXE = 1, 
           IF(a.id_age <= 25, nsptc.SNHMH1814, 
             IF(a.id_age <= 50, nsptc.SNHMH2614, nsptc.SNHMH5014)),
           IF(a.id_age <= 25, nsptc.SNHMF1814, 
             IF(a.id_age <= 50, nsptc.SNHMF2614, nsptc.SNHMF5014))) AS salaire_moyen_age
	FROM population_no_moco pop 
	JOIN name_geographic_information ngi ON ngi.code_insee = pop.CODGEO 
	JOIN deaths d ON d.code_lieu_deces = pop.CODGEO AND d.sexe = pop.SEXE 
	JOIN age a ON a.id_age = TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces) AND a.age80_17 = pop.AGEQ80_17 
	LEFT JOIN net_salary_per_town_categories nsptc ON ngi.code_insee = nsptc.CODGEO 

	GROUP BY pop.CODGEO, ngi.numero_departement, ngi.code_region,
		TIMESTAMPDIFF(YEAR, d.date_naissance, d.date_deces), pop.SEXE;
