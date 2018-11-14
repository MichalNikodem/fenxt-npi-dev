CREATE OR REPLACE VIEW out_vw_glbatches AS
SELECT
	AddedByUserName::VARCHAR(512) as "a__addedbyusername",
	BatchNumber::INTEGER as "a__batchnumber",
	StatusTranslation::VARCHAR(512) as "a__statustranslation",
	BatchId::VARCHAR(512) as "cp__batchid",
	AddedByUserNameLabel::VARCHAR(512) as "l__addedbyusername__addedbyuserlabel",
	GoodData_Attr('{"state":"ledger.journalentry.detail","id":'||BatchId||'}')::VARCHAR(512) as "l__batchnumber__batchnumberhyperlink",
	TenantId::VARCHAR(128) as x__client_id
FROM out_GLBatches
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_GLBatches')
;