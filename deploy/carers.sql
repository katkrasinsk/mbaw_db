-- Deploy mbaw:carers to pg

BEGIN;

	CREATE TABLE mbaw.carers(
		id SERIAL PRIMARY KEY,
		name TEXT NOT NULL,
		email TEXT NOT NULL,
		birthday DATE,
		social_id TEXT,
		extra_attrs JSONB
	);

COMMIT;
