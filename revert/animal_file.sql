-- Revert mbaw:animal_file from pg

BEGIN;

	DROP TABLE mbaw.animal_file;

COMMIT;
