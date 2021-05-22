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

	CREATE TABLE mbaw.nutricional_events(
		id SERIAL PRIMARY KEY,
		food_id INT,
		carer_id INT,
		animal_file_id INT,
		offered_at TIMESTAMP NOT NULL,
		observations TEXT,
		assimilated_qty NUMERIC CHECK (assimilated_qty > 0),
		offered_qty NUMERIC CHECK(offered_qty > assimilated_qty),
		offer_type TEXT NOT NULL,
		acceptance_avaliation WELLNESS,
		extra_attrs JSONB,
		CONSTRAINT fk_food FOREIGN KEY(food_id) REFERENCES mbaw.foods(id),
		CONSTRAINT fk_carer FOREIGN KEY(carer_id) REFERENCES mbaw.carers(id),
		CONSTRAINT fk_animal_file FOREIGN KEY(animal_file_id) REFERENCES mbaw.animal_files(id)
	);

COMMIT;
