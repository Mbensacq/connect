create table COMMUNE (
    codeCommune INT PRIMARY KEY,
    nomCommune VARCHAR(50) UNIQUE NOT NULL,
    codePostal VARCHAR(10),
    nbHabitants INT NOT NULL CHECK (nbHabitants > 0)
);
create table CAMION (
    numImmat VARCHAR(20) PRIMARY KEY,
    nomProprietaire VARCHAR(200) NOT NULL,
    miseEnService DATE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);
create table TYPEDECHET (
    codeType VARCHAR(10) PRIMARY KEY,
    libelleType VARCHAR(100) NOT NULL
);
create table DEPOT (
    numDepot SERIAL PRIMARY KEY,
    dateDepot DATE NOT NULL,
    heureDepot TIME NOT NULL,
    poidsArrivee INTEGER NOT NULL CHECK (poidsArrivee > 0),
    poidsDepart INTEGER NOT NULL CHECK (poidsDepart > 0),
    codeType VARCHAR(10) NOT NULL REFERENCES TYPEDECHET(codeType),
    numImmat VARCHAR(20) NOT NULL REFERENCES CAMION(numImmat),
    codeCommune INT NOT NULL REFERENCES COMMUNE(codeCommune)
);