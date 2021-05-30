-- Revert mbaw:nutricional_handler from pg

BEGIN;

	DROP TABLE mbaw.animal_meals;
	DROP TABLE mbaw.meal_details;
	DROP TABLE mbaw.meals;
	DROP TABLE mbaw.foods;
	DROP TYPE WELLNESS CASCADE; 

COMMIT;
