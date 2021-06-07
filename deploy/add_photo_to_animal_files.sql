-- Deploy mbaw:add_photo_to_animal_files to pg

BEGIN;

	ALTER TABLE mbaw.animal_files
	ADD COLUMN "small_img" BYTEA,
 -- TODO: could not set BLOB as datatype for thi column
 -- should be investigated better why we cannot use it in the
 -- free plan.
	ADD COLUMN "original_image" BYTEA;

COMMIT;
