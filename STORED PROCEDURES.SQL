/* ************************************************************************** */
/*                                                                            */
/*   QUERIES.SQL                       $$$$$$$$\ $$\   $$\ $$$$$$\  $$$$$$\   */
/*                                     $$  _____|$$ |  $$ |\_$$  _|$$  __$$ | */
/*                                     $$ |      \$$\ $$  |  $$ |  $$ /  $$ | */
/*                                     $$$$$\     \$$$$  /   $$ |  $$$$$$$$ | */
/*   By:                               $$  __|    $$  $$<    $$ |  $$  __$$ | */
/*                                     $$ |      $$  /\$$\   $$ |  $$ |  $$ | */
/*   Erwan PLESSIS                     $$$$$$$$\ $$ /  $$ |$$$$$$\ $$ |  $$ | */
/*                                     \________|\__|  \__|\______|\__|  \__| */
/*                                                                            */
/* ************************************************************************** */

--#####################################################################--
--# 						PROCEDURES STOCKEES						                        #----
--#####################################################################--

DELIMITER ;;

CREATE PROCEDURE `update_info_j`
	(
        no TINYINT(4),
        grade VARCHAR(25),
        poste VARCHAR(25)
    )
BEGIN	
	UPDATE Joueur SET grade_j = grade, poste_predilec_j = poste WHERE no = no_j;
	
    SELECT CONCAT('Les paramètres du joueur ',no_j, ' ont bien été modifiés.');
END ;;

--#####################################################################--
--# Saisir les informations relatives à un match (avant son démarrage)#----
--#####################################################################--

DELIMITER ;; 
CREATE PROCEDURE nouveau_match
(
	nom_equipe_adverse varchar(20), 
	date_rencontre date, 
	lieu_rencontre varchar(20), 
	type_de_maillot varchar(20), 
	premiere_mi_temps time
)  
BEGIN
	INSERT INTO Matchh(nom_equipe_adv, date_rencontre, lieu, maillot, h_debut_mi_temps, h_debut_prolong_1, h_debut_prolong_2)
	VALUES(nom_equipe_adverse, date_rencontre, lieu_rencontre, type_de_maillot, premiere_mi_temps);
	
	SELECT CONCAT('Informations du match contre ', nom_equipe_adverse ,' bien rentrées, n\'oubliez pas d\'ajouter les horraires à la fin du match ainsi que les prolongations si elles ont lieu !');
END ;;

--###############################################################################################################--
--# Pendant le match, saisir les informations relatives aux buts marqués, 			                  							#---
--# aux sorties/entrées des joueurs ainsi que les fautes sifflées (indiquant l’arbitre ayant sifflé la faute)   #---
--###############################################################################################################--

-- Procédure pour saisir un but marque

DELIMITER ;;

CREATE PROCEDURE ajout_but
    (
        temps_but TINYINT(4),
        joueur TINYINT(4),
        numero_rencontre INT
    )

BEGIN
    INSERT INTO But(tmps_but, no_j, id_mat_Matchh)
    VALUES(temps_but, joueur, numero_rencontre);
END;;

-- Procédure pour saisir un remplacement

DELIMITER ;;

CREATE PROCEDURE saisie_remplacements
    (
    temps_changement INT,
    no_joueur_entrant INT,
    no_joueur_sortant    INT,
    no_rencontre INT
    )
BEGIN
    INSERT INTO Remplacement(tmps_remp_j, no_entree_j, no_sortie_j, id_mat)
    VALUES(temps_changement, no_joueur_entrant, no_joueur_sortant, no_rencontre);
END;;

-- Procédure pour saisir une faute

DELIMITER ;;

CREATE PROCEDURE saisie_fautes
    (
    temps_faute INT,
    type_carton VARCHAR(25),
    n_faute VARCHAR(25),
    j_fautif INT,
    no_rencontre INT
    )
BEGIN
    INSERT INTO Faute(tmps_fautes, carton, nom_faute, no_j, id_mat)
    VALUES(temps_faute, type_carton, n_faute, j_fautif, no_rencontre);
END;;
	
--#######################################################################################################--
--# Afficher la composition détaillée de l’équipe (Numéro, nom et poste des joueurs ainsi que le grade) #----
--#######################################################################################################--

DELIMITER ;;
CREATE PROCEDURE afficher_infos_equipe()
BEGIN
    SELECT('Voici les informations concernant les joueurs de l\'équipe.');
   SELECT no_j, nom_j, grade_j, poste_predilec_j
   FROM Joueur;
   END ;;

--##################################################################################################################################################################################--
-- Afficher les informations relatives à un match (incluant la composition et postes/placements de l’équipe) avec les différents  événements du match ordonnés dans le temps        ####
--##################################################################################################################################################################################--

DELIMITER ;;
CREATE PROCEDURE `infos_match` 
( 
   NOmatch INT 
) 
BEGIN 
SELECT CONCAT ('Informations liées au match ',NOmatch,'.') AS '';
SELECT nom_equipe_adv, date_recontre, lieu, h_debut_match
FROM Matchh
WHERE id_mat = NOmatch;

SELECT CONCAT ('Informations liées aux buts marqués par l_équipe durant le match ',NOmatch,'.') AS '';
SELECT tmps_but, no_j 
FROM But
WHERE id_mat = NOmatch 
ORDER BY tmps_but ASC;

SELECT CONCAT('Informations liées aux buts marqués par l_équipe adverse durant le match ',NOmatch,'.') AS '';
SELECT tmps_but_adv
FROM But
WHERE id_mat = NOmatch
ORDER BY tmps_but_adv ASC;

SELECT CONCAT ('Informations liées aux remplacements des joueurs durant le match ',NOmatch,'.') AS '';
SELECT tmps_remp_j, no_entree_j, no_sortie_j
FROM Remplacement 
WHERE id_mat = NOmatch
ORDER BY tmps_remp_j ASC;

SELECT CONCAT ('Informations liées aux fautes ayant eu lieu durant le match ',NOmatch,'.') AS '';
SELECT tmps_faute, carton, nom_faute, penalite, no_j, occasion_exclusion
FROM Faute
WHERE id_mat = NOmatch 
ORDER BY tmps_faute ASC;

SELECT     ('Informations liées aux blessures de l_équipe durant le match ',NOmatch,'.') AS '';
SELECT id_blessure, tmps_sortie_blessure, gravite_blessure, no_j
FROM(
   SELECT * FROM Blessure
   NATURAL JOIN Joueur
   )
AS joint WHERE id_mat=NOmatch
ORDER BY tmps_sortie_blessure ASC;

SELECT CONCAT ('Informations liées aux joueurs pendant le match ',NOmatch,'.') AS '';
SELECT no_j, nom_j, prenom_j, role_j, position_j_pdt_match, poste_j_pdt_match
FROM(
   SELECT * FROM Jouer
   NATURAL JOIN Joueur
   )
   AS jointure WHERE id_mat=NOmatch;

END;;