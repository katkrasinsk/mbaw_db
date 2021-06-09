-- Deploy mbaw:load_data to pg

BEGIN;


	\COPY mbaw.animals FROM 'data/animals.csv' CSV;
	SELECT SETVAL('mbaw.animals_id_seq', max(id)) FROM mbaw.animals;
	\COPY mbaw.carers FROM 'data/carers.csv' CSV;
	SELECT SETVAL('mbaw.carers_id_seq', max(id)) FROM mbaw.carers;
	\COPY mbaw.enclosures FROM 'data/enclosures.csv' CSV;
	SELECT SETVAL('mbaw.enclosures_id_seq', max(id)) FROM mbaw.enclosures;
	\COPY mbaw.foods FROM 'data/foods.csv' CSV;
	SELECT SETVAL('mbaw.foods_id_seq', max(id)) FROM mbaw.foods;
	\COPY mbaw.animal_files FROM 'data/animal_files.csv' CSV;
	SELECT SETVAL('mbaw.animal_files_id_seq', max(id)) FROM mbaw.animal_files;
	\COPY mbaw.hospitalizations FROM 'data/hospitalizations.csv' CSV;
	\COPY mbaw.meals FROM 'data/meals.csv' CSV;
	SELECT SETVAL('mbaw.meals_id_seq', max(id)) FROM mbaw.meals;
	\COPY mbaw.meal_details FROM 'data/meal_details.csv' CSV;
	\COPY mbaw.animal_meals FROM 'data/animal_meals.csv' CSV;


COMMIT;
