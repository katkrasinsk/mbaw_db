-- Verify mbaw:schema on pg

BEGIN;

				DO $$
				BEGIN
					 ASSERT (SELECT has_schema_privilege('mbaw', 'usage'));
				END $$;

ROLLBACK;
