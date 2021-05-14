-- Revert mbaw:enclosure from pg

BEGIN;

	DROP TABLE mbaw.enclosures;

COMMIT;
