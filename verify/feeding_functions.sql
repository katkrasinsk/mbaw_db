-- Verify mbaw:feeding_functions on pg

BEGIN;

    SELECT has_function_privilege('mbaw.feeding_history(int)', 'execute');
    SELECT * FROM mbaw.animal_feed_history WHERE FALSE;

ROLLBACK;
