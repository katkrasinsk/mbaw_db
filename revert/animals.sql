-- Revert mbaw:animals from pg

BEGIN;

	DROP TABLE mbaw.animals;

COMMIT;
