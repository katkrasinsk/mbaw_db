-- Deploy mbaw:enclosure to pg

BEGIN;

	CREATE TABLE mbaw.enclosures(
		id SERIAL PRIMARY KEY,
		name TEXT NOT NULL,
		number SMALLINT,
		capacity SMALLINT,
		state TEXT,
		actived BOOLEAN
	);

COMMIT;
