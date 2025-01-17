<?php
include("vues/v_sommaire.php");
$idVisiteur = $_SESSION['idVisiteur'];
$aaaamm = getMois(date("d/m/Y"));
$numAnnee = substr($aaaamm, 0, 4);
$numMois = substr($aaaamm, 4, 2);
$mois = $numMois;
$action = $_REQUEST['action'];

switch ($action) {
	case 'saisirFrais': {
			if ($pdo->estPremierFraisMois($idVisiteur, $mois)) {

				$pdo->creeNouvellesLignesFrais($idVisiteur, $mois);
			}
			break;
		}
	case 'validerMajFraisForfait': {
			$lesFrais = $_REQUEST['lesFrais'];
			if (lesQteFraisValides($lesFrais)) {
				$pdo->majFraisForfait($idVisiteur, $mois, $lesFrais);
			} else {
				ajouterErreur("Les valeurs des frais doivent être numériques");
				include("vues/v_erreurs.php");
			}
			break;
		}
	case 'validerCreationFrais': {
			$dateFrais = $_REQUEST['dateFrais'];
			$libelle = $_REQUEST['libelle'];
			$montant = $_REQUEST['montant'];
			$paiement = $_REQUEST['paiement'];
			valideInfosFrais($dateFrais, $libelle, $montant, $paiement);
			if (nbErreurs() != 0) {
				include("vues/v_erreurs.php");
			} else {
				$pdo->creeNouveauFraisHorsForfait($idVisiteur, $mois, $libelle, $dateFrais, $montant, $paiement);
			}
			break;
		}
	case 'supprimerFrais': {
			$idFrais = $_REQUEST['idFrais'];
			$pdo->supprimerFraisHorsForfait($idFrais);
			break;
		}
}
$lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $mois);
$lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $mois);
$modePaiementAll = $pdo->getModePaiement();
include("vues/v_listeFraisForfait.php");
include("vues/v_listeFraisHorsForfait.php");
