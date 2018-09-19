CREATE OR REPLACE VIEW out_vw_accounts AS
SELECT
	AccountCategory::VARCHAR(512) as "a__accountcategory",
	AccountCategoryTranslation::VARCHAR(512) as "a__accountcategorytranslation",
	AccountCodeDescription::VARCHAR(512) as "a__accountcodedescription",
	AccountDescription::VARCHAR(512) as "a__accountdescription",
	AccountNumber::VARCHAR(512) as "a__accountnumber",
	(concat(concat(asv1.AccountSegmentValue, ' - '), asv1.Description))::VARCHAR(512) as "a__accountsegment1",
	(concat(concat(asv10.AccountSegmentValue, ' - '), asv10.Description))::VARCHAR(512) as "a__accountsegment10",
	(concat(concat(asv2.AccountSegmentValue, ' - '), asv2.Description))::VARCHAR(512) as "a__accountsegment2",
	(concat(concat(asv3.AccountSegmentValue, ' - '), asv3.Description))::VARCHAR(512) as "a__accountsegment3",
	(concat(concat(asv4.AccountSegmentValue, ' - '), asv4.Description))::VARCHAR(512) as "a__accountsegment4",
	(concat(concat(asv5.AccountSegmentValue, ' - '), asv5.Description))::VARCHAR(512) as "a__accountsegment5",
	(concat(concat(asv6.AccountSegmentValue, ' - '), asv6.Description))::VARCHAR(512) as "a__accountsegment6",
	(concat(concat(asv7.AccountSegmentValue, ' - '), asv7.Description))::VARCHAR(512) as "a__accountsegment7",
	(concat(concat(asv8.AccountSegmentValue, ' - '), asv8.Description))::VARCHAR(512) as "a__accountsegment8",
	(concat(concat(asv9.AccountSegmentValue, ' - '), asv9.Description))::VARCHAR(512) as "a__accountsegment9",
	IsContra::VARCHAR(512) as "a__accountsiscontra",
	AccountDescription::VARCHAR(512) as "a__accountsuniquelabel",
	AddedByUserName::VARCHAR(512) as "a__addedbyusername",
	Class::VARCHAR(512) as "a__class",
	FundDescription::VARCHAR(512) as "a__funddescription",
	StatusTranslation::VARCHAR(512) as "a__statustranslation",
	a.AccountId::VARCHAR(512) as "cp__accountid",
	AccountDescription::VARCHAR(512) as "l__accountdescription__accountdescriptionlabel",
	AccountDescription::VARCHAR(512) as "l__accountnumber__accountnumberdescriptionlabel",
	GoodData_Attr('{"state":"ledger.account.detail","id":'||a.AccountId||'}')::VARCHAR(512) as "l__accountnumber__accountnumberhyperlink",
	AddedByUserNameLabel::VARCHAR(512) as "l__addedbyusername__addedbyuserlabel",
	a.TenantId::VARCHAR(128) as x__client_id
FROM out_Accounts a
  left join stg_csv_AccountSegmentValue_merge asv1 on (a.TenantId = asv1.TenantId and a.AccountId = asv1.AccountId and asv1.SegmentId = 1)
  left join stg_csv_AccountSegmentValue_merge asv10 on (a.TenantId = asv10.TenantId and a.AccountId = asv10.AccountId and asv10.SegmentId = 10)
  left join stg_csv_AccountSegmentValue_merge asv2 on (a.TenantId = asv2.TenantId and a.AccountId = asv2.AccountId and asv2.SegmentId = 2)
  left join stg_csv_AccountSegmentValue_merge asv3 on (a.TenantId = asv3.TenantId and a.AccountId = asv3.AccountId and asv3.SegmentId = 3)
  left join stg_csv_AccountSegmentValue_merge asv4 on (a.TenantId = asv4.TenantId and a.AccountId = asv4.AccountId and asv4.SegmentId = 4)
  left join stg_csv_AccountSegmentValue_merge asv5 on (a.TenantId = asv5.TenantId and a.AccountId = asv5.AccountId and asv5.SegmentId = 5)
  left join stg_csv_AccountSegmentValue_merge asv6 on (a.TenantId = asv6.TenantId and a.AccountId = asv6.AccountId and asv6.SegmentId = 6)
  left join stg_csv_AccountSegmentValue_merge asv7 on (a.TenantId = asv7.TenantId and a.AccountId = asv7.AccountId and asv7.SegmentId = 7)
  left join stg_csv_AccountSegmentValue_merge asv8 on (a.TenantId = asv8.TenantId and a.AccountId = asv8.AccountId and asv8.SegmentId = 8)
  left join stg_csv_AccountSegmentValue_merge asv9 on (a.TenantId = asv9.TenantId and a.AccountId = asv9.AccountId and asv9.SegmentId = 9)
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Accounts')
;