-- Deploy mbaw:internees to pg

BEGIN;

	CREATE TABLE mbaw.hospitalizations(
		animal_file_id INT,
		enclosure_id INT,
		begin_at TIMESTAMP DEFAULT now(),
		end_at TIMESTAMP,
		PRIMARY KEY( animal_file_id, enclosure_id, begin_at ),
		CONSTRAINT fk_animal_file FOREIGN KEY(animal_file_id) REFERENCES mbaw.animal_files(id),
		CONSTRAINT fk_enclosure FOREIGN KEY(enclosure_id) REFERENCES mbaw.enclosures(id),
		CHECK ( begin_at < end_at )
	);

COMMIT;
