-- init.sql: creates schema and inserts sample data for the TP
-- Database: bda

-- Drop if exists (safe for re-init during development)
DROP TABLE IF EXISTS DEPOT;
DROP TABLE IF EXISTS TYPEDECHET;
DROP TABLE IF EXISTS CAMION;
DROP TABLE IF EXISTS COMMUNE;

-- COMMUNE
CREATE TABLE COMMUNE (
  codeCommune VARCHAR(10) PRIMARY KEY,
  nomCommune VARCHAR(100) UNIQUE NOT NULL,
  codePostal VARCHAR(10),
  nbHabitants INTEGER NOT NULL CHECK (nbHabitants > 0)
);

-- CAMION
CREATE TABLE CAMION (
  numImmat VARCHAR(20) PRIMARY KEY,
  nomProprietaire VARCHAR(200) NOT NULL,
  miseEnService DATE NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- TYPEDECHET
CREATE TABLE TYPEDECHET (
  codeType VARCHAR(10) PRIMARY KEY,
  libelleType VARCHAR(100) NOT NULL
);

-- DEPOT
CREATE TABLE DEPOT (
  numDepot SERIAL PRIMARY KEY,
  dateDepot DATE NOT NULL,
  heureDepot TIME NOT NULL,
  poidsArrivee INTEGER NOT NULL CHECK (poidsArrivee > 0),
  poidsDepart INTEGER NOT NULL CHECK (poidsDepart > 0),
  codeType VARCHAR(10) NOT NULL REFERENCES TYPEDECHET(codeType),
  numImmat VARCHAR(20) NOT NULL REFERENCES CAMION(numImmat),
  codeCommune VARCHAR(10) NOT NULL REFERENCES COMMUNE(codeCommune)
);

-- Sample data: communes
INSERT INTO COMMUNE(codeCommune, nomCommune, codePostal, nbHabitants) VALUES
('C001','Lormont','33310',27000),
('C002','Talence','33400',42000),
('C003','Bordeaux','33000',260000),
('C004','Mérignac','33700',70000),
('C005','Pessac','33600',62000);

-- Sample data: types
INSERT INTO TYPEDECHET(codeType, libelleType) VALUES
('CA','Carton'),
('VE','Verre'),
('PL','Plastique'),
('TE','Textile'),
('PA','Papier');

-- Sample data: camions
INSERT INTO CAMION(numImmat, nomProprietaire, miseEnService, is_active) VALUES
('TB-555-PP','Transports Dupont','2018-06-15', TRUE),
('XZ-985-UI','Ancienne Société','2010-03-01', FALSE), -- retired
('BM-100-XX','Bordeaux Métropole','2019-11-20', TRUE),
('BM-200-YY','Bordeaux Métropole','2018-09-01', TRUE),
('NO-000-ZZ','Privé Sans Depot','2021-05-01', TRUE),
('LT-321-AB','Logistique Sud','2016-02-10', TRUE);

-- Sample data: depots (dates covering March and May 2024)
INSERT INTO DEPOT(dateDepot, heureDepot, poidsArrivee, poidsDepart, codeType, numImmat, codeCommune) VALUES
('2024-03-05','08:30','120','110','CA','TB-555-PP','C001'), -- carton from Lormont
('2024-03-12','09:15','200','190','CA','LT-321-AB','C001'),
('2024-03-20','14:00','50','60','PL','BM-100-XX','C001'),
('2024-03-22','10:00','300','310','PL','TB-555-PP','C003'),
('2024-05-02','11:00','700','690','VE','TB-555-PP','C002'), -- verre in May by TB-555-PP
('2024-05-15','07:30','550','540','VE','BM-200-YY','C001'),
('2024-05-20','12:00','1200','1190','PL','BM-100-XX','C002'),
('2024-04-01','08:00','80','85','CA','XZ-985-UI','C004'),
('2024-02-14','15:00','60','65','PA','BM-100-XX','C005'),
('2024-06-10','09:30','400','410','TE','LT-321-AB','C002');

-- Additional deposits so that some queries have results
INSERT INTO DEPOT(dateDepot, heureDepot, poidsArrivee, poidsDepart, codeType, numImmat, codeCommune) VALUES
('2024-03-28','16:20','600','590','PL','TB-555-PP','C001'),
('2024-05-05','09:45','520','515','PL','TB-555-PP','C001');

-- View: total weight per commune (sum of poidsDepart - poidsArrivee? The description uses difference between weighings -> quantity delivered)
CREATE OR REPLACE VIEW poids_par_commune AS
SELECT c.codeCommune, c.nomCommune,
       SUM(d.poidsDepart - d.poidsArrivee) AS poids_total_depose
FROM COMMUNE c
LEFT JOIN DEPOT d ON d.codeCommune = c.codeCommune
GROUP BY c.codeCommune, c.nomCommune;

-- Indexes to help queries
CREATE INDEX idx_depot_date ON DEPOT(dateDepot);
CREATE INDEX idx_depot_type ON DEPOT(codeType);

-- Function to "retire" a camion (soft delete)
CREATE OR REPLACE FUNCTION retire_camion(v_numImmat VARCHAR)
RETURNS VOID LANGUAGE plpgsql AS $$
BEGIN
  UPDATE CAMION SET is_active = FALSE WHERE numImmat = v_numImmat;
END;
$$;

-- Ensure init transaction commits
COMMIT;
