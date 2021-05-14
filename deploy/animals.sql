-- Deploy mbaw:animals to pg

BEGIN;

	CREATE TABLE mbaw.animals(
			id SERIAL PRIMARY KEY,
			popular_name TEXT NOT NULL,
			scientific_name TEXT NOT NULL UNIQUE,
			attributes JSONB
	);

COMMIT;
