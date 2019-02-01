CREATE OR REPLACE VIEW out_vw_account_date AS
SELECT
	AccountDateId::VARCHAR(512) as "cp__accountdateid",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	Dummy::NUMERIC(15,2) as "f__dummy",
	AccountId::VARCHAR(512) as "r__accounts",
	TenantId::VARCHAR(128) as x__client_id,
	_sys_updated_at::TIMESTAMP  as "x__timestamp"
FROM out_Accounts;