-- Revert mbaw:carers from pg

BEGIN;

	DROP TABLE mbaw.carers;

COMMIT;
