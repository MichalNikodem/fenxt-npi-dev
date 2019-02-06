
CREATE OR REPLACE VIEW out_vw_transactions_attr AS
SELECT
	AddedByUserNameId::VARCHAR(512) as "a__addedbyusername",
	Class::VARCHAR(512) as "a__class",
	EncumbranceStatusTranslation::VARCHAR(512) as "a__encumbrancestatustranslation",
	PostStatusTranslation::VARCHAR(512) as "a__poststatustranslation",
	TransactionCode1::VARCHAR(512) as "a__transactioncode1",
	TransactionCode2::VARCHAR(512) as "a__transactioncode2",
	TransactionCode3::VARCHAR(512) as "a__transactioncode3",
	TransactionCode4::VARCHAR(512) as "a__transactioncode4",
	TransactionCode5::VARCHAR(512) as "a__transactioncode5",
	TransactionId::VARCHAR(512) as "a__transactionid",
	TransactionCode1IsActive::VARCHAR(512) as "a__transactions1isactive",
	TransactionCode2IsActive::VARCHAR(512) as "a__transactions2isactive",
	TransactionCode3IsActive::VARCHAR(512) as "a__transactions3isactive",
	TransactionCode4IsActive::VARCHAR(512) as "a__transactions4isactive",
	TransactionCode5IsActive::VARCHAR(512) as "a__transactions5isactive",
	IsBeginningBalance::VARCHAR(512) as "a__transactionsisbeginningbalance",
	TransactionTypeTranslation::VARCHAR(512) as "a__transactiontypetranslation",
	TransactionAttrDistributionId::VARCHAR(512) as "cp__transactionattrdistributionid",
	(CASE WHEN (out_transactions_attr.PostDate < '1900-01-01'::date) THEN '1900-01-01'::date WHEN (out_transactions_attr.PostDate > '2050-01-01'::date) THEN '2050-01-01'::date ELSE out_transactions_attr.PostDate END )::DATE as "d__postdate",
	AddedByUserName::VARCHAR(512) as "l__addedbyusername__addedbyusernamelabel",
	TenantId::VARCHAR(128) as x__client_id
  -- , _sys_updated_at::TIMESTAMP as "x__timestamp",
  -- _sys_is_deleted::BOOLEAN as "x__deleted"
FROM out_transactions_attr
WHERE (out_transactions_attr._sys_is_deleted = false)
;