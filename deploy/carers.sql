-- Deploy mbaw:carers to pg

BEGIN;

	CREATE TABLE mbaw.carers(
		id INT PRIMARY KEY,
		name TEXT NOT NULL,
		birthday DATE,
		social_id TEXT,
		extra_attrs JSONB
	);

COMMIT;