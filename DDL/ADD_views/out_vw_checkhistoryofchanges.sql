CREATE OR REPLACE VIEW out_vw_checkhistoryofchanges AS
SELECT
	ChangedByUserName::VARCHAR(512) as "a__changedbyusername",
	PostStatus::VARCHAR(512) as "a__checkhistorypoststatus",
	VendorName::VARCHAR(512) as "a__checkhistoryvendorname",
	CheckNumber::VARCHAR(512) as "a__checkid",
	FieldChanged::VARCHAR(512) as "a__fieldchanged",
	FieldChangedTranslation::VARCHAR(512) as "a__fieldchangedtranslation",
	NewValue::VARCHAR(512) as "a__newvalue",
	OldValue::VARCHAR(512) as "a__oldvalue",
	CheckHistoryId::VARCHAR(512) as "cp__checkhistoryid",
	DateChanged::DATE as "d__datechanged",
	GoodData_Attr('{"state":"treasury.transaction","id":'||DrillInId||'}')::VARCHAR(512) as "l__checkid__checkhistorydrillin",
	BankId::VARCHAR(512) as "r__banks",
	TenantId::VARCHAR(128) as x__client_id
FROM out_CheckHistory
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CheckHistory')
;