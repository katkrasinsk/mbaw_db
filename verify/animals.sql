-- Verify mbaw:animals on pg

BEGIN;

	SELECT id, popular_name, scientific_name, attributes
	FROM mbaw.animals
	WHERE FALSE;

ROLLBACK;
