-- Revert mbaw:load_data from pg

BEGIN;

	DELETE FROM mbaw.animal_meals;
	DELETE FROM mbaw.meal_details;
	DELETE FROM mbaw.meals;
	DELETE FROM mbaw.hospitalizations;
	DELETE FROM mbaw.animal_files;
	DELETE FROM mbaw.foods;
	DELETE FROM mbaw.enclosures;
	DELETE FROM mbaw.carers;
	DELETE FROM mbaw.animals;

COMMIT;
