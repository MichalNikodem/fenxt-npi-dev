CREATE OR REPLACE VIEW out_vw_tenant AS
SELECT
	FundName::VARCHAR(512) as "a__fundname",
	GrantName::VARCHAR(512) as "a__grantname",
	ProjectName::VARCHAR(512) as "a__projectname",
	DataUpdated::VARCHAR(512) as "a__tenantlastupdatedtime",
	TransactionCode1Name::VARCHAR(512) as "a__transactioncode1",
	TransactionCode2Name::VARCHAR(512) as "a__transactioncode2",
	TransactionCode3Name::VARCHAR(512) as "a__transactioncode3",
	TransactionCode4Name::VARCHAR(512) as "a__transactioncode4",
	TransactionCode5Name::VARCHAR(512) as "a__transactioncode5",
	TenantId::VARCHAR(512) as "cp__tenant",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;