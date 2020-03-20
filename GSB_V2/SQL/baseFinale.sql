/*
 Navicat Premium Data Transfer

 Source Server         : Debian
 Source Server Type    : MySQL
 Source Server Version : 100317
 Source Host           : localhost:3306
 Source Schema         : EXEMPLE

 Target Server Type    : MySQL
 Target Server Version : 100317
 File Encoding         : 65001

 Date: 30/09/2019 15:55:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Etat
-- ----------------------------
DROP TABLE IF EXISTS `Etat`;
CREATE TABLE `Etat`  (
  `id` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `libelle` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Etat
-- ----------------------------
INSERT INTO `Etat` VALUES ('CL', 'Saisie clôturée');
INSERT INTO `Etat` VALUES ('CR', 'Fiche créée, saisie en cours');
INSERT INTO `Etat` VALUES ('RB', 'Remboursée');
INSERT INTO `Etat` VALUES ('VA', 'Validée et mise en paiement');

-- ----------------------------
-- Table structure for FicheFrais
-- ----------------------------
DROP TABLE IF EXISTS `FicheFrais`;
CREATE TABLE `FicheFrais`  (
  `idVisiteur` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mois` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nbJustificatifs` int(11) NULL DEFAULT NULL,
  `montantValide` decimal(10, 2) NULL DEFAULT NULL,
  `dateModif` date NULL DEFAULT NULL,
  `idEtat` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`, `mois`) USING BTREE,
  INDEX `idEtat`(`idEtat`) USING BTREE,
  CONSTRAINT `FicheFrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `Etat` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FicheFrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `Visiteur` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FicheFrais
-- ----------------------------
INSERT INTO `FicheFrais` VALUES ('a89', '09', 0, 0.00, '2019-09-20', 'CR');

-- ----------------------------
-- Table structure for FraisForfait
-- ----------------------------
DROP TABLE IF EXISTS `FraisForfait`;
CREATE TABLE `FraisForfait`  (
  `id` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `libelle` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `montant` decimal(5, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FraisForfait
-- ----------------------------
INSERT INTO `FraisForfait` VALUES ('ETP', 'Forfait Etape', 110.00);
INSERT INTO `FraisForfait` VALUES ('KM', 'Frais Kilométrique', 0.62);
INSERT INTO `FraisForfait` VALUES ('NUI', 'Nuitée Hôtel', 80.00);
INSERT INTO `FraisForfait` VALUES ('REP', 'Repas Restaurant', 25.00);

-- ----------------------------
-- Table structure for LigneFraisForfait
-- ----------------------------
DROP TABLE IF EXISTS `LigneFraisForfait`;
CREATE TABLE `LigneFraisForfait`  (
  `idVisiteur` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mois` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `idFraisForfait` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantite` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`, `mois`, `idFraisForfait`) USING BTREE,
  INDEX `idFraisForfait`(`idFraisForfait`) USING BTREE,
  CONSTRAINT `LigneFraisForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `LigneFraisForfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `FraisForfait` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of LigneFraisForfait
-- ----------------------------
INSERT INTO `LigneFraisForfait` VALUES ('a89', '09', 'ETP', 2);
INSERT INTO `LigneFraisForfait` VALUES ('a89', '09', 'KM', 0);
INSERT INTO `LigneFraisForfait` VALUES ('a89', '09', 'NUI', 0);
INSERT INTO `LigneFraisForfait` VALUES ('a89', '09', 'REP', 11);

-- ----------------------------
-- Table structure for LigneFraisHorsForfait
-- ----------------------------
DROP TABLE IF EXISTS `LigneFraisHorsForfait`;
CREATE TABLE `LigneFraisHorsForfait`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mois` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `libelle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `montant` decimal(10, 2) NULL DEFAULT NULL,
  `paiement` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idVisiteur`(`idVisiteur`, `mois`) USING BTREE,
  INDEX `RefModePaiement`(`paiement`) USING BTREE,
  CONSTRAINT `LigneFraisHorsForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of LigneFraisHorsForfait
-- ----------------------------
INSERT INTO `LigneFraisHorsForfait` VALUES (11, 'a89', '09', 'aaaa', '2019-09-30', 111111.00, '3');
INSERT INTO `LigneFraisHorsForfait` VALUES (12, 'a89', '09', 'aaaa', '2019-09-30', 111111.00, '3');
INSERT INTO `LigneFraisHorsForfait` VALUES (13, 'a89', '09', 'aaaa', '2019-09-30', 111111.00, '3');
INSERT INTO `LigneFraisHorsForfait` VALUES (14, 'a89', '09', 'aaaa', '2019-09-30', 111111.00, '3');
INSERT INTO `LigneFraisHorsForfait` VALUES (15, 'a89', '09', 'aaaa', '2019-09-30', 111111.00, '3');
INSERT INTO `LigneFraisHorsForfait` VALUES (16, 'a89', '09', 'bbbb', '2019-09-30', 222.00, '1');
INSERT INTO `LigneFraisHorsForfait` VALUES (17, 'a89', '09', 'bbbb', '2019-09-30', 222.00, '1');
INSERT INTO `LigneFraisHorsForfait` VALUES (18, 'a89', '09', 'bbbb', '2019-09-30', 222.00, '1');
INSERT INTO `LigneFraisHorsForfait` VALUES (19, 'a89', '09', 'bbbb', '2019-09-30', 222.00, '1');
INSERT INTO `LigneFraisHorsForfait` VALUES (20, 'a89', '09', 'test', '2019-09-30', 75.00, '1');
INSERT INTO `LigneFraisHorsForfait` VALUES (21, 'a89', '09', 'test2', '2019-09-30', 75.00, '2');

-- ----------------------------
-- Table structure for ModePaiement
-- ----------------------------
DROP TABLE IF EXISTS `ModePaiement`;
CREATE TABLE `ModePaiement`  (
  `id` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `modePaiement` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ModePaiement
-- ----------------------------
INSERT INTO `ModePaiement` VALUES ('1', 'Carte Bancaire');
INSERT INTO `ModePaiement` VALUES ('2', 'Chèques');
INSERT INTO `ModePaiement` VALUES ('3', 'Espèces');

-- ----------------------------
-- Table structure for Visiteur
-- ----------------------------
DROP TABLE IF EXISTS `Visiteur`;
CREATE TABLE `Visiteur`  (
  `id` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nom` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `prenom` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `login` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mdp` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `adresse` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cp` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ville` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dateEmbauche` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Visiteur
-- ----------------------------
INSERT INTO `Visiteur` VALUES ('a131', 'Villechalane', 'Louis', 'lvillachane', 'jux7g', '8 rue des Charmes', '46000', 'Cahors', '2005-12-21');
INSERT INTO `Visiteur` VALUES ('a17', 'Andre', 'David', 'dandre', 'oppg5', '1 rue Petit', '46200', 'Lalbenque', '1998-11-23');
INSERT INTO `Visiteur` VALUES ('a55', 'Bedos', 'Christian', 'cbedos', 'gmhxd', '1 rue Peranud', '46250', 'Montcuq', '1995-01-12');
INSERT INTO `Visiteur` VALUES ('a89', 'leandre', 'leandre', 'admin', 'admin', 'fdknfdsnfj', '12343', 'fkdnfd', '2019-09-18');
INSERT INTO `Visiteur` VALUES ('a93', 'Tusseau', 'Louis', 'ltusseau', 'ktp3s', '22 rue des Ternes', '46123', 'Gramat', '2000-05-01');
INSERT INTO `Visiteur` VALUES ('b13', 'Bentot', 'Pascal', 'pbentot', 'doyw1', '11 allée des Cerises', '46512', 'Bessines', '1992-07-09');
INSERT INTO `Visiteur` VALUES ('b16', 'Bioret', 'Luc', 'lbioret', 'hrjfs', '1 Avenue gambetta', '46000', 'Cahors', '1998-05-11');
INSERT INTO `Visiteur` VALUES ('b19', 'Bunisset', 'Francis', 'fbunisset', '4vbnd', '10 rue des Perles', '93100', 'Montreuil', '1987-10-21');
INSERT INTO `Visiteur` VALUES ('b25', 'Bunisset', 'Denise', 'dbunisset', 's1y1r', '23 rue Manin', '75019', 'paris', '2010-12-05');
INSERT INTO `Visiteur` VALUES ('b28', 'Cacheux', 'Bernard', 'bcacheux', 'uf7r3', '114 rue Blanche', '75017', 'Paris', '2009-11-12');
INSERT INTO `Visiteur` VALUES ('b34', 'Cadic', 'Eric', 'ecadic', '6u8dc', '123 avenue de la République', '75011', 'Paris', '2008-09-23');
INSERT INTO `Visiteur` VALUES ('b4', 'Charoze', 'Catherine', 'ccharoze', 'u817o', '100 rue Petit', '75019', 'Paris', '2005-11-12');
INSERT INTO `Visiteur` VALUES ('b50', 'Clepkens', 'Christophe', 'cclepkens', 'bw1us', '12 allée des Anges', '93230', 'Romainville', '2003-08-11');
INSERT INTO `Visiteur` VALUES ('b59', 'Cottin', 'Vincenne', 'vcottin', '2hoh9', '36 rue Des Roches', '93100', 'Monteuil', '2001-11-18');
INSERT INTO `Visiteur` VALUES ('c14', 'Daburon', 'François', 'fdaburon', '7oqpv', '13 rue de Chanzy', '94000', 'Créteil', '2002-02-11');
INSERT INTO `Visiteur` VALUES ('c3', 'De', 'Philippe', 'pde', 'gk9kx', '13 rue Barthes', '94000', 'Créteil', '2010-12-14');
INSERT INTO `Visiteur` VALUES ('c54', 'Debelle', 'Michel', 'mdebelle', 'od5rt', '181 avenue Barbusse', '93210', 'Rosny', '2006-11-23');
INSERT INTO `Visiteur` VALUES ('d13', 'Debelle', 'Jeanne', 'jdebelle', 'nvwqq', '134 allée des Joncs', '44000', 'Nantes', '2000-05-11');
INSERT INTO `Visiteur` VALUES ('d51', 'Debroise', 'Michel', 'mdebroise', 'sghkb', '2 Bld Jourdain', '44000', 'Nantes', '2001-04-17');
INSERT INTO `Visiteur` VALUES ('e22', 'Desmarquest', 'Nathalie', 'ndesmarquest', 'f1fob', '14 Place d Arc', '45000', 'Orléans', '2005-11-12');
INSERT INTO `Visiteur` VALUES ('e24', 'Desnost', 'Pierre', 'pdesnost', '4k2o5', '16 avenue des Cèdres', '23200', 'Guéret', '2001-02-05');
INSERT INTO `Visiteur` VALUES ('e39', 'Dudouit', 'Frédéric', 'fdudouit', '44im8', '18 rue de l église', '23120', 'GrandBourg', '2000-08-01');
INSERT INTO `Visiteur` VALUES ('e49', 'Duncombe', 'Claude', 'cduncombe', 'qf77j', '19 rue de la tour', '23100', 'La souteraine', '1987-10-10');
INSERT INTO `Visiteur` VALUES ('e5', 'Enault-Pascreau', 'Céline', 'cenault', 'y2qdu', '25 place de la gare', '23200', 'Gueret', '1995-09-01');
INSERT INTO `Visiteur` VALUES ('e52', 'Eynde', 'Valérie', 'veynde', 'i7sn3', '3 Grand Place', '13015', 'Marseille', '1999-11-01');
INSERT INTO `Visiteur` VALUES ('f21', 'Finck', 'Jacques', 'jfinck', 'mpb3t', '10 avenue du Prado', '13002', 'Marseille', '2001-11-10');
INSERT INTO `Visiteur` VALUES ('f39', 'Frémont', 'Fernande', 'ffremont', 'xs5tq', '4 route de la mer', '13012', 'Allauh', '1998-10-01');
INSERT INTO `Visiteur` VALUES ('f4', 'Gest', 'Alain', 'agest', 'dywvt', '30 avenue de la mer', '13025', 'Berre', '1985-11-01');

SET FOREIGN_KEY_CHECKS = 1;
