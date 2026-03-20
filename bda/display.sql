
\i drop_all.sql
\i create_all.sql
\i inject.sql

SELECT 'Communes' as table_name, count(*) as rows FROM COMMUNE
UNION ALL
SELECT 'Camions', count(*) FROM CAMION
UNION ALL
SELECT 'Types Déchet', count(*) FROM TYPEDECHET
UNION ALL
SELECT 'Dépôts', count(*) FROM DEPOT;

\d COMMUNE
\d CAMION
\d TYPEDECHET
\d DEPOT
