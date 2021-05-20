-- Revert mbaw:nutricional_handler from pg

BEGIN;

	DROP TABLE mbaw.nutricional_events;
	DROP TABLE mbaw.foods;
	DROP TYPE WELLNESS CASCADE; 

COMMIT;
