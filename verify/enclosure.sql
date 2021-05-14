-- Verify mbaw:enclosure on pg

BEGIN;

	SELECT id, name, number, capacity, state, actived
	FROM mbaw.enclosures
	WHERE FALSE;

ROLLBACK;
