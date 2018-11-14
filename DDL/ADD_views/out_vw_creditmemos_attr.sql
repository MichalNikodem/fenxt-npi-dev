CREATE OR REPLACE VIEW out_vw_creditmemos_attr AS
SELECT
	CreditMemoAttrId::VARCHAR(512) as "cp__creditmemoattrid",
	TenantId::VARCHAR(128) as x__client_id
FROM out_CreditMemos_attr
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CreditMemos_attr')
;