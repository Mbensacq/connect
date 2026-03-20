-- TP SQL 1 - Réponses aux questions

-- 1. Liste des communes triée par ordre croissant du nombre d'habitants
SELECT nomCommune AS "Nom Commune", 
       nbHabitants AS "Nombre d'habitants"
FROM COMMUNE
ORDER BY nbHabitants ASC;

-- 2. Numéro, date et poids des dépôts de carton provenant de la commune de Lormont en mars 2024
SELECT d.numDepot AS "Numéro Dépôt",
       d.dateDepot AS "Date",
       (d.poidsArrivee - d.poidsDepart) AS "Poids (kg)"
FROM DEPOT d
JOIN COMMUNE c ON d.codeCommune = c.codeCommune
JOIN TYPEDECHET t ON d.codeType = t.codeType
WHERE c.nomCommune = 'Lormont'
  AND t.libelleType = 'carton'
  AND EXTRACT(YEAR FROM d.dateDepot) = 2024
  AND EXTRACT(MONTH FROM d.dateDepot) = 3;

-- 3. Combien de dépôts ont été effectués par la commune de Lormont en mars 2024 ?
SELECT COUNT(*) AS "Nombre de dépôts"
FROM DEPOT d
JOIN COMMUNE c ON d.codeCommune = c.codeCommune
WHERE c.nomCommune = 'Lormont'
  AND EXTRACT(YEAR FROM d.dateDepot) = 2024
  AND EXTRACT(MONTH FROM d.dateDepot) = 3;

-- 4. Liste des dépôts de plus de 500 kg de plastique réalisés par le camion TB-555-PP,
--    triés par ordre chronologique décroissant
SELECT d.numDepot AS "Numéro Dépôt",
       d.dateDepot AS "Date",
       d.heureDepot AS "Heure",
       (d.poidsArrivee - d.poidsDepart) AS "Poids (kg)",
       c.nomCommune AS "Commune"
FROM DEPOT d
JOIN TYPEDECHET t ON d.codeType = t.codeType
JOIN COMMUNE c ON d.codeCommune = c.codeCommune
WHERE d.numImmat = 'TB-555-PP'
  AND t.libelleType = 'plastique'
  AND (d.poidsArrivee - d.poidsDepart) > 500
ORDER BY d.dateDepot DESC, d.heureDepot DESC;

-- 5. Liste des camions ayant déposé du verre au mois de Mai 2024
SELECT DISTINCT cam.numImmat AS "Immatriculation",
                cam.nomProprietaire AS "Propriétaire"
FROM CAMION cam
JOIN DEPOT d ON cam.numImmat = d.numImmat
JOIN TYPEDECHET t ON d.codeType = t.codeType
WHERE t.libelleType = 'verre'
  AND EXTRACT(YEAR FROM d.dateDepot) = 2024
  AND EXTRACT(MONTH FROM d.dateDepot) = 5;
