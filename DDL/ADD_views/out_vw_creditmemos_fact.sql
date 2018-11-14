CREATE OR REPLACE VIEW out_vw_creditmemos_fact AS
SELECT
	CreditMemoFactId::VARCHAR(512) as "cp__creditmemofactid",
	Date::DATE as "d__creditmemodate",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	PostDate::DATE as "d__postdate",
	CreditMemoAmount::NUMERIC(15,2) as "f__creditmemoamount",
	CreditMemoBalance::NUMERIC(15,2) as "f__creditmemobalance",
	CreditMemoAttrId::VARCHAR(512) as "r__creditmemos_attr",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	PostStatusId::VARCHAR(512) as "r__poststatus",
	VendorId::VARCHAR(512) as "r__vendors",
	TenantId::VARCHAR(128) as x__client_id
FROM out_CreditMemos_fact
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CreditMemos_fact')
;