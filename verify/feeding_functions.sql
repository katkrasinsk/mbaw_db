-- Verify mbaw:feeding_functions on pg

BEGIN;

    SELECT has_function_privilege('mbaw.feeding_history(int)', 'execute');

ROLLBACK;
