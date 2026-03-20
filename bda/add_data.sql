-- Données supplémentaires pour avoir des résultats à toutes les requêtes
-- Note: poidsArrivee - poidsDepart = quantité déposée (le camion arrive plein et repart vide)

-- Ajouter des dépôts de plus de 500 kg de plastique par TB-555-PP
INSERT INTO DEPOT (dateDepot, heureDepot, poidsArrivee, poidsDepart, codeType, numImmat, codeCommune)
VALUES 
-- Dépôt de 650 kg de plastique
('2024-03-10', '14:30', 8000, 7350, 'PL', 'TB-555-PP', 4),
-- Dépôt de 750 kg de plastique  
('2024-03-25', '10:15', 8500, 7750, 'PL', 'TB-555-PP', 1),
-- Dépôt de 520 kg de plastique
('2024-02-15', '09:00', 7800, 7280, 'PL', 'TB-555-PP', 2);
