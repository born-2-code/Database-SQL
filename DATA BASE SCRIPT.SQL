/* ************************************************************************** */
/*                                                                            */
/*   CREATE DATA BASE.SQL              $$$$$$$$\ $$\   $$\ $$$$$$\  $$$$$$\   */
/*                                     $$  _____|$$ |  $$ |\_$$  _|$$  __$$ | */
/*                                     $$ |      \$$\ $$  |  $$ |  $$ /  $$ | */
/*                                     $$$$$\     \$$$$  /   $$ |  $$$$$$$$ | */
/*   By:                               $$  __|    $$  $$<    $$ |  $$  __$$ | */
/*                                     $$ |      $$  /\$$\   $$ |  $$ |  $$ | */
/*   Erwan PLESSIS                     $$$$$$$$\ $$ /  $$ |$$$$$$\ $$ |  $$ | */
/*                                     \________|\__|  \__|\______|\__|  \__| */
/*                                                                            */
/* ************************************************************************** */

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `BDD`
--

-- --------------------------------------------------------

--
-- Table structure for table `Arbitrage`
--

CREATE TABLE `Arbitrage` (
  `id_arbitrage` int(11) NOT NULL,
  `nom_arbitre_princ` varchar(25) NOT NULL,
  `nationa_arb` varchar(25) NOT NULL,
  `nom_arbitre_assist_1` varchar(25) NOT NULL,
  `nationa_arb_assist_1` varchar(25) NOT NULL,
  `nom_arbitre_assist_2` varchar(25) NOT NULL,
  `nationa_arb_assist_2` varchar(25) NOT NULL,
  `id_mat` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Arbitrage`
--

INSERT INTO `Arbitrage` (`id_arbitrage`, `nom_arbitre_princ`, `nationa_arb`, `nom_arbitre_assist_1`, `nationa_arb_assist_1`, `nom_arbitre_assist_2`, `nationa_arb_assist_2`, `id_mat`) VALUES
(1, 'Husmann', 'Allemand', 'Kinder', 'Allemand', 'Country', 'Allemand', 1),
(2, 'Husmann', 'Allemand', 'Kinder', 'Allemand', 'Country', 'Allemand', 2),
(3, 'Husmann', 'Allemand', 'Kinder', 'Allemand', 'Country', 'Allemand', 3);

-- --------------------------------------------------------

--
-- Table structure for table `Blessure`
--

CREATE TABLE `Blessure` (
  `id_blessure` int(11) NOT NULL,
  `gravite_blessure` varchar(25) NOT NULL,
  `duree_sortie_blessure` tinyint(4) DEFAULT NULL,
  `tmps_sortie_blessure` tinyint(4) DEFAULT NULL,
  `id_mat` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Blessure`
--

INSERT INTO `Blessure` (`id_blessure`, `gravite_blessure`, `duree_sortie_blessure`, `tmps_sortie_blessure`, `id_mat`) VALUES
(1, 'Definitive', NULL, NULL, NULL);

--
-- Triggers `Blessure`
--
DELIMITER $$
CREATE TRIGGER `CHECK_tmps_sortie_blessure` BEFORE INSERT ON `blessure`
 FOR EACH ROW BEGIN

    if ((NEW.tmps_sortie_blessure < 0 ) OR (NEW.gravite_blessure != 'Temporaire' OR NEW.gravite_blessure != 'Définitive' OR NEW.gravite_blessure != NULL))
    then signal SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Les valeurs entrées ne sont pas valides !';

end if;
end
$$
DELIMITER ;

--
-- Table structure for table `But`
--

CREATE TABLE `But` (
  `id_but` int(11) NOT NULL,
  `tmps_but` tinyint(4) DEFAULT NULL,
  `id_mat` int(11) NOT NULL,
  `tmps_but_adv` tinyint(4) DEFAULT NULL,
  `id_mat_Matchh` int(11) NOT NULL,
  `no_j` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `But`
--

INSERT INTO `But` (`id_but`, `tmps_but`, `id_mat`, `tmps_but_adv`, `id_mat_Matchh`, `no_j`) VALUES
(1, 30, 1, NULL, 1, 10),
(2, 50, 1, NULL, 1, 11),
(3, 86, 1, NULL, 1, 10),
(4, 48, 2, NULL, 2, 9),
(5, 67, 2, NULL, 2, 10),
(6, NULL, 3, 13, 3, 0),
(7, 42, 3, NULL, 3, 11),
(8, NULL, 3, 81, 3, 0);

--
-- Table structure for table `Faute`
--

CREATE TABLE `Faute` (
  `id_faute` int(11) NOT NULL,
  `nom_faute` varchar(25) NOT NULL,
  `sanction` varchar(25) DEFAULT NULL,
  `carton` varchar(25) DEFAULT NULL,
  `occasion_exclu` varchar(25) NOT NULL,
  `tmps_faute` tinyint(4) NOT NULL,
  `id_mat` int(11) NOT NULL,
  `no_j` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Faute`
--

INSERT INTO `Faute` (`id_faute`, `nom_faute`, `sanction`, `carton`, `occasion_exclu`, `tmps_faute`, `id_mat`, `no_j`) VALUES
(1, 'Coup de boule', NULL, 'rouge', 'oui', 10, 3, 1),
(2, 'Tacle non conventionnel', NULL, 'Jaune', 'non', 61, 1, 14),
(3, 'Coup de coude', NULL, 'Rouge', 'oui', 74, 2, NULL);

--
-- Triggers `Faute`
--
DELIMITER $$
CREATE TRIGGER `CHECK_nom_faute` BEFORE INSERT ON `faute`
 FOR EACH ROW BEGIN

    if ((NEW.nom_faute != 'Coup de boule' OR NEW.nom_faute != 'Tacle non conventionnel' OR NEW.nom_faute != 'Crache sur un joueur' OR NEW.nom_faute != 'Coup de pied' OR NEW.nom_faute != 'Coup de genou' OR NEW.nom_faute != NULL ) OR (NEW.occasion_exclu != 'Oui' OR NEW.occasion_exclu != 'Non'))
    then signal SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Les valeurs entrées ne sont pas valides !';

end if;
end
$$
DELIMITER ;

--
-- Table structure for table `Jouer`
--

CREATE TABLE `Jouer` (
  `tmps_jeu_j` tinyint(4) NOT NULL,
  `role_j` varchar(25) NOT NULL,
  `poste_j_pdt_match` varchar(25) NOT NULL,
  `position_j_pdt_match` varchar(25) DEFAULT NULL,
  `no_j` tinyint(4) NOT NULL,
  `id_mat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Jouer`
--

INSERT INTO `Jouer` (`tmps_jeu_j`, `role_j`, `poste_j_pdt_match`, `position_j_pdt_match`, `no_j`, `id_mat`) VALUES
(90, 'Titulaire', 'Gardien', NULL, 1, 1),
(70, 'Titulaire', 'Gardien', NULL, 1, 2),
(10, 'Titulaire', 'Gardien', NULL, 1, 3),
(90, 'Titulaire', 'Defenseur', 'Droite', 2, 1),
(90, 'Titulaire', 'Defenseur', 'Droite', 2, 2),
(50, 'Titulaire', 'Defenseur', 'Droite', 2, 3),
(35, 'Titulaire', 'Defenseur', 'Gauche', 3, 1),
(90, 'Titulaire', 'Defenseur', 'Gauche', 3, 2),
(90, 'Titulaire', 'Defenseur', 'Gauche', 3, 3),
(90, 'Titulaire', 'Milieu', 'Gauche', 4, 1),
(30, 'Titulaire', 'Milieu', 'Gauche', 4, 2),
(90, 'Titulaire', 'Milieu', 'Gauche', 4, 3),
(90, 'Titulaire', 'Milieu', 'Droite', 5, 1),
(90, 'Titulaire', 'Milieu', 'Droite', 5, 2),
(90, 'Titulaire', 'Milieu', 'Droite', 5, 3),
(90, 'Titulaire', 'Milieu', 'Centre', 6, 1),
(90, 'Titulaire', 'Milieu', 'Centre', 6, 2),
(90, 'Titulaire', 'Milieu', 'Centre', 6, 3),
(90, 'Titulaire', 'Defenseur', 'Centre', 7, 1),
(90, 'Titulaire', 'Defenseur', 'Centre', 7, 2),
(90, 'Titulaire', 'Defenseur', 'Centre', 7, 3),
(90, 'Titulaire', 'Defenseur', 'Centre', 8, 1),
(90, 'Titulaire', 'Defenseur', 'Centre', 8, 2),
(90, 'Titulaire', 'Defenseur', 'Centre', 8, 3),
(90, 'Titulaire', 'Attaquant', 'Gauche', 9, 1),
(90, 'Titulaire', 'Attaquant', 'Gauche', 9, 2),
(90, 'Titulaire', 'Attaquant', 'Gauche', 9, 3),
(90, 'Titulaire', 'Attaquant', 'Centre', 10, 1),
(90, 'Titulaire', 'Attaquant', 'Centre', 10, 2),
(90, 'Titulaire', 'Attaquant', 'Centre', 10, 3),
(70, 'Titulaire', 'Milieu offensif', 'Centre', 11, 1),
(90, 'Titulaire', 'Milieu offensif', 'Centre', 11, 2),
(90, 'Titulaire', 'Milieu offensif', 'Centre', 11, 3),
(0, 'Remplacant', 'Gardien', NULL, 12, 1),
(20, 'Remplacant', 'Gardien', NULL, 12, 2),
(80, 'Remplacant', 'Gardien', NULL, 12, 3),
(20, 'Remplacant', 'Milieu', 'Centre', 13, 1),
(60, 'Remplacant', 'Milieu', 'Centre', 13, 2),
(0, 'Remplacant', 'Milieu', 'Centre', 13, 3),
(55, 'Remplacant', 'Defenseur', 'Centre', 14, 1),
(0, 'Remplacant', 'Defenseur', 'Centre', 14, 2),
(40, 'Remplacant', 'Defenseur', 'Centre', 14, 3),
(0, 'Remplacant', 'Attaquant', 'Centre', 15, 1),
(0, 'Remplacant', 'Attaquant', 'Centre', 15, 2),
(0, 'Remplacant', 'Attaquant', 'Centre', 15, 3);

--
-- Triggers `Jouer`
--

DELIMITER $$
CREATE TRIGGER `CHECK_poste_j_pdt_match` BEFORE INSERT ON `jouer`
 FOR EACH ROW BEGIN

    if ((NEW.poste_j_pdt_match != 'Milieu offensif' OR NEW.poste_j_pdt_match != 'Attaquant' OR NEW.poste_j_pdt_match != 'Defenseur' OR NEW.poste_j_pdt_match != 'Milieu' OR NEW.poste_j_pdt_match != 'Gardien') OR (NEW.position_j_pdt_match != 'Centre' OR NEW.position_j_pdt_match != 'Droite' OR NEW.position_j_pdt_match != 'Gauche' OR NEW.position_j_pdt_match != NULL ) OR (NEW.role_j != 'Titulaire' OR NEW.role_j != 'Remplacant'))
    then signal SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Ce poste n''existe pas durant ce match!';

end if;
end
$$

DELIMITER ;

--
-- Table structure for table `Joueur`
--

CREATE TABLE `Joueur` (
  `no_j` tinyint(4) NOT NULL,
  `nom_j` varchar(25) NOT NULL,
  `prenom_j` varchar(25) NOT NULL,
  `poste_predilec_j` varchar(25) NOT NULL,
  `grade_j` varchar(25) NOT NULL,
  `id_blessure` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Dumping data for table `Joueur`
--

INSERT INTO `Joueur` (`no_j`, `nom_j`, `prenom_j`, `poste_predilec_j`, `grade_j`, `id_blessure`) VALUES
(1, 'Trapp', 'Kevin', 'Gardien', 'Joueur', NULL),
(2, 'Aoas', 'Marcos', 'Defenseur', 'Joueur', NULL),
(3, 'Luiz', 'Davis', 'Defenseur', 'Joueur', NULL),
(4, 'Matouidi', 'Blaise', 'Milieu', 'Joueur', NULL),
(5, 'Pereira De sa', 'Roli', 'Milieu', 'Joueur', NULL),
(6, 'Verratti', 'Marco', 'Milieu', 'Joueur', NULL),
(7, 'Aurier', 'Serge', 'Defenseur', 'Joueur', NULL),
(8, 'Silva', 'Thiago', 'Defenseur', 'Capitaine', NULL),
(9, 'Cavani', 'Edinson', 'Attaquant', 'Suppleant', NULL),
(10, 'Ibrahimovic', 'Zlatan', 'Attaquant', 'Joueur', NULL),
(11, 'Di Maria', 'Angel', 'Millieu offensif', 'Joueur', NULL),
(12, 'Sirigu', 'Salvatore', 'Gardien', 'Joueur', NULL),
(13, 'Pastore', 'Javier', 'Milieu', 'Joueur', NULL),
(14, 'Kurzawa', 'Layvin', 'Defenseur', 'Joueur', NULL),
(15, 'Neymar', 'Jean', 'Attaquant', 'Joueur', 1);

--
-- Triggers `Joueur`
--

DELIMITER $$
CREATE TRIGGER `CHECK_no_j` BEFORE INSERT ON `joueur`
 FOR EACH ROW BEGIN

    if ((NEW.no_j < '1' OR NEW.no_j >'44' OR NEW.no_j = NULL) OR (NEW.poste_predilec_j != 'Attaquant' OR NEW.poste_predilec_j != 'Defenseur' OR NEW.poste_predilec_j != 'Milieu' OR NEW.poste_predilec_j != 'Gardien') OR (NEW.grade_j != 'Capitaine' OR NEW.grade_j != 'Suppleant' OR NEW.grade_j != 'Joueur' ))
    then signal SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Vos valeurs ne sont pas valides!';

end if;
end
$$
DELIMITER ;

--
-- Table structure for table `Matchh`
--

CREATE TABLE `Matchh` (
  `id_mat` int(11) NOT NULL,
  `nom_equipe_adv` varchar(25) NOT NULL,
  `lieu` varchar(25) NOT NULL,
  `date_recontre` date NOT NULL,
  `maillot` varchar(25) NOT NULL,
  `h_debut_match` time NOT NULL,
  `h_debut_mi_temps` time NOT NULL,
  `h_debut_prolong_1` time NOT NULL,
  `h_debut_prolong_2` time NOT NULL,
  `id_arbitrage` int(11) NOT NULL,
  `score_equipe` tinyint(25) NOT NULL,
  `score_equipe_adv` tinyint(25) NOT NULL,
  `Gagnant` varchar(25) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Matchh`
--

INSERT INTO `Matchh` (`id_mat`, `nom_equipe_adv`, `lieu`, `date_recontre`, `maillot`, `h_debut_match`, `h_debut_mi_temps`, `h_debut_prolong_1`, `h_debut_prolong_2`, `id_arbitrage`, `score_equipe`, `score_equipe_adv`, `Gagnant`) VALUES
(1, 'Orleans', 'Paris', '2016-01-07', 'Domicile', '18:00:00', '18:50:00', '19:40:00', '19:55:00', 1, 3, 0, 'equipe'),
(2, 'Sochaux', 'Sochaux', '2016-01-10', 'Exterieur', '18:00:00', '18:50:00', '19:40:00', '19:55:00', 2, 2, 0, 'equipe'),
(3, 'Nice', 'Nice', '2016-01-14', 'Exterieur', '19:00:00', '19:50:00', '20:40:00', '20:55:00', 3, 1, 2, 'equipe_adv');

--
-- Triggers `Matchh`
--

DELIMITER $$
CREATE TRIGGER `CHECK_maillot` BEFORE INSERT ON `matchh`
 FOR EACH ROW BEGIN
    if ((NEW.maillot != 'Domicile' OR NEW.maillot != 'Exterieur') OR (NEW.score_equipe_adv < 0 ) OR (NEW.score_equipe < 0 ) OR (NEW.Gagnant != 'Equipe' OR NEW.Gagnant != 'Equipe_adv'))
    then signal SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Ces valeurs ne sont pas valide !';

end if;
end
$$
DELIMITER ;

--
-- Table structure for table `Remplacement`
--

CREATE TABLE `Remplacement` (
  `id_remplacements` int(11) NOT NULL,
  `no_entree_j` tinyint(4) NOT NULL,
  `no_sortie_j` tinyint(4) NOT NULL,
  `tmps_remp_j` tinyint(4) DEFAULT NULL,
  `id_mat` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Remplacement`
--

INSERT INTO `Remplacement` (`id_remplacements`, `no_entree_j`, `no_sortie_j`, `tmps_remp_j`, `id_mat`) VALUES
(1, 14, 3, 35, 1),
(2, 13, 11, 70, 1),
(3, 12, 1, 70, 2),
(6, 13, 4, 30, 2),
(7, 12, 1, 10, 3),
(8, 13, 2, 50, 3),
(9, 11, 13, 60, 1);

--
-- Triggers `Remplacement`
--

DELIMITER $$
CREATE TRIGGER `CHECK_no_entree_j` BEFORE INSERT ON `remplacement`
 FOR EACH ROW BEGIN

    if ((NEW.no_entree_j < '1' OR NEW.no_entree_j >'44' OR NEW.no_entree_j = NULL) OR (NEW.no_sortie_j < '1' OR NEW.no_sortie_j >'44' OR NEW.no_sortie_j = NULL) OR (NEW.tmps_remp_j < 0 ))
    then signal SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Les valeurs entrées ne sont pas valides !';

end if;
end
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Arbitrage`
--
ALTER TABLE `Arbitrage`
  ADD PRIMARY KEY (`id_arbitrage`),
  ADD KEY `FK_Arbitrage_id_mat` (`id_mat`);

--
-- Indexes for table `Blessure`
--
ALTER TABLE `Blessure`
  ADD PRIMARY KEY (`id_blessure`),
  ADD KEY `FK_Blessure_id_mat` (`id_mat`);

--
-- Indexes for table `But`
--
ALTER TABLE `But`
  ADD PRIMARY KEY (`id_but`),
  ADD KEY `FK_But_id_mat` (`id_mat`),
  ADD KEY `FK_But_id_mat_Matchh` (`id_mat_Matchh`),
  ADD KEY `FK_But_no_j` (`no_j`);

--
-- Indexes for table `Faute`
--
ALTER TABLE `Faute`
  ADD PRIMARY KEY (`id_faute`),
  ADD KEY `FK_Faute_id_mat` (`id_mat`),
  ADD KEY `FK_Faute_no_j` (`no_j`);

--
-- Indexes for table `Jouer`
--
ALTER TABLE `Jouer`
  ADD PRIMARY KEY (`no_j`,`id_mat`),
  ADD KEY `FK_Jouer_id_mat` (`id_mat`);

--
-- Indexes for table `Joueur`
--
ALTER TABLE `Joueur`
  ADD PRIMARY KEY (`no_j`),
  ADD KEY `FK_Joueur_id_blessure` (`id_blessure`);

--
-- Indexes for table `Matchh`
--
ALTER TABLE `Matchh`
  ADD PRIMARY KEY (`id_mat`),
  ADD KEY `FK_Matchh_id_arbitrage` (`id_arbitrage`);

--
-- Indexes for table `Remplacement`
--
ALTER TABLE `Remplacement`
  ADD PRIMARY KEY (`id_remplacements`),
  ADD KEY `FK_Remplacement_id_mat` (`id_mat`),
  ADD KEY `FK_Remplacement_no_entree_j` (`no_entree_j`),
  ADD KEY `FK_Remplacement_no_sortie_j` (`no_sortie_j`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Arbitrage`
--
ALTER TABLE `Arbitrage`
  MODIFY `id_arbitrage` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Blessure`
--
ALTER TABLE `Blessure`
  MODIFY `id_blessure` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `But`
--
ALTER TABLE `But`
  MODIFY `id_but` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `Faute`
--
ALTER TABLE `Faute`
  MODIFY `id_faute` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Matchh`
--
ALTER TABLE `Matchh`
  MODIFY `id_mat` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Remplacement`
--
ALTER TABLE `Remplacement`
  MODIFY `id_remplacements` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Arbitrage`
--
ALTER TABLE `Arbitrage`
  ADD CONSTRAINT `FK_Arbitrage_id_mat` FOREIGN KEY (`id_mat`) REFERENCES `Matchh` (`id_mat`);

--
-- Constraints for table `Blessure`
--
ALTER TABLE `Blessure`
  ADD CONSTRAINT `FK_Blessure_id_mat` FOREIGN KEY (`id_mat`) REFERENCES `Matchh` (`id_mat`);

--
-- Constraints for table `But`
--
ALTER TABLE `But`
  ADD CONSTRAINT `FK_But_id_mat` FOREIGN KEY (`id_mat`) REFERENCES `Matchh` (`id_mat`),
  ADD CONSTRAINT `FK_But_id_mat_Matchh` FOREIGN KEY (`id_mat_Matchh`) REFERENCES `Matchh` (`id_mat`),
  ADD CONSTRAINT `FK_But_no_j` FOREIGN KEY (`no_j`) REFERENCES `Joueur` (`no_j`);

--
-- Constraints for table `Faute`
--
ALTER TABLE `Faute`
  ADD CONSTRAINT `FK_Faute_id_mat` FOREIGN KEY (`id_mat`) REFERENCES `Matchh` (`id_mat`),
  ADD CONSTRAINT `FK_Faute_no_j` FOREIGN KEY (`no_j`) REFERENCES `Joueur` (`no_j`);

--
-- Constraints for table `Jouer`
--
ALTER TABLE `Jouer`
  ADD CONSTRAINT `FK_Jouer_id_mat` FOREIGN KEY (`id_mat`) REFERENCES `Matchh` (`id_mat`),
  ADD CONSTRAINT `FK_Jouer_no_j` FOREIGN KEY (`no_j`) REFERENCES `Joueur` (`no_j`);

--
-- Constraints for table `Joueur`
--
ALTER TABLE `Joueur`
  ADD CONSTRAINT `FK_Joueur_id_blessure` FOREIGN KEY (`id_blessure`) REFERENCES `Blessure` (`id_blessure`);

--
-- Constraints for table `Matchh`
--
ALTER TABLE `Matchh`
  ADD CONSTRAINT `FK_Matchh_id_arbitrage` FOREIGN KEY (`id_arbitrage`) REFERENCES `Arbitrage` (`id_arbitrage`);

--
-- Constraints for table `Remplacement`
--
ALTER TABLE `Remplacement`
  ADD CONSTRAINT `FK_Remplacement_id_mat` FOREIGN KEY (`id_mat`) REFERENCES `Matchh` (`id_mat`),
  ADD CONSTRAINT `FK_Remplacement_no_entree_j` FOREIGN KEY (`no_entree_j`) REFERENCES `Joueur` (`no_j`),
  ADD CONSTRAINT `FK_Remplacement_no_sortie_j` FOREIGN KEY (`no_sortie_j`) REFERENCES `Joueur` (`no_j`);
