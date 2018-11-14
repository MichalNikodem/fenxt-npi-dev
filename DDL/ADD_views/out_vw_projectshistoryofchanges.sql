CREATE OR REPLACE VIEW out_vw_projectshistoryofchanges AS
SELECT
	ChangedByUserName::VARCHAR(512) as "a__changedbyusername",
	FieldChanged::VARCHAR(512) as "a__fieldchanged",
	FieldChangedTranslation::VARCHAR(512) as "a__fieldchangedtranslation",
	NewValue::VARCHAR(512) as "a__newvalue",
	OldValue::VARCHAR(512) as "a__oldvalue",
	ProjectHistoryId::VARCHAR(512) as "cp__projecthistoryid",
	DateChanged::DATE as "d__datechanged",
	ProjectId::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
FROM out_ProjectHistory
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectHistory')
;