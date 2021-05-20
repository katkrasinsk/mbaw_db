-- Verify mbaw:internees on pg

BEGIN;

	SELECT ( animal_file_id, enclosure_id, begin_at, end_at )
	FROM mbaw.hospitalizations
	WHERE false;

ROLLBACK;
