CREATE OR REPLACE VIEW out_vw_accounthistoryofchanges AS
SELECT
	ChangedByUserName::VARCHAR(512) as "a__changedbyusername",
	FieldChanged::VARCHAR(512) as "a__fieldchanged",
	FieldChangedTranslation::VARCHAR(512) as "a__fieldchangedtranslation",
	NewValue::VARCHAR(512) as "a__newvalue",
	OldValue::VARCHAR(512) as "a__oldvalue",
	AccountHistoryId::VARCHAR(512) as "cp__accounthistoryid",
	DateChanged::DATE as "d__datechanged",
	AccountId::VARCHAR(512) as "r__accounts",
	TenantId::VARCHAR(128) as x__client_id
FROM out_AccountHistory
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_AccountHistory');
;