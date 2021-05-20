-- Revert mbaw:internees from pg

BEGIN;

	DROP table mbaw.hospitalizations;

COMMIT;
