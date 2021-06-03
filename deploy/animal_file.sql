-- Deploy mbaw:animal_file to pg

BEGIN;

	CREATE TABLE mbaw.animal_files(
		id BIGSERIAL PRIMARY KEY,
		animal_id INT,
		internal_code_for_animal INT NOT NULL UNIQUE,
		external_code_for_animal INT,
		created_at TIMESTAMP DEFAULT now(),
		modified_at TIMESTAMP,
		observations TEXT,
		archived BOOLEAN DEFAULT FALSE,
		archived_at TIMESTAMP,
		CONSTRAINT fk_animal FOREIGN KEY(animal_id) REFERENCES mbaw.animals(id)
);

COMMIT;
