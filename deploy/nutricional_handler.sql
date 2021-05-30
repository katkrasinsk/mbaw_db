-- Deploy mbaw:nutricional_handler to pg

BEGIN;

	CREATE EXTENSION IF NOT EXISTS hstore;
	CREATE TABLE mbaw.foods(
		id SERIAL PRIMARY KEY,
		name TEXT NOT NULL,
		created_at TIMESTAMP DEFAULT now(),
		is_medication BOOLEAN DEFAULT FALSE,
		is_supplementation BOOLEAN DEFAULT FALSE,
		is_normal BOOLEAN DEFAULT TRUE,
		provider TEXT,
		nutrients hstore
	);

	CREATE TYPE WELLNESS AS ENUM ('good', 'avarage', 'bad');

	CREATE TABLE mbaw.meals(
		id SERIAL PRIMARY KEY,
		observations TEXT,
		extra_attrs JSONB
	);

	CREATE TABLE mbaw.meal_details(
		meal_id INT NOT NULL REFERENCES mbaw.meals(id),
		food_id INT NOT NULL REFERENCES mbaw.foods(id),
		offered_qty NUMERIC CHECK( offered_qty > 0 ),
		assimilated_qty NUMERIC CHECK (offered_qty >= assimilated_qty),
		offer_mode TEXT
	);

	CREATE TABLE mbaw.animal_meals(
		animal_file_id INT REFERENCES mbaw.animal_files(id),
		offered_by INT REFERENCES mbaw.carers(id),
		meal_id INT references mbaw.meals(id),
		acceptance_avaliation WELLNESS,
		offered_at TIMESTAMP DEFAULT now()
	);

COMMIT;
