-- Verify mbaw:carers on pg

BEGIN;

	SELECT id, name, birthday, social_id, extra_attrs
	FROM mbaw.carers
	WHERE FALSE;

ROLLBACK;
