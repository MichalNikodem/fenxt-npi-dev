CREATE OR REPLACE VIEW out_vw_creditcardtransaction AS
SELECT
	CategoryName::VARCHAR(512) as "a__categoryname",
	Comment::VARCHAR(512) as "a__comment",
	MerchantName::VARCHAR(512) as "a__merchantname",
	Status::VARCHAR(512) as "a__status",
	TranType::VARCHAR(512) as "a__transactiontype",
	YodleeAccountId::VARCHAR(512) as "a__yodleeaccountid",
	CreditCardTransactionId::VARCHAR(512) as "cp__creditcardtransactionid",
	PostDate::DATE as "d__postdate",
	Amount::NUMERIC(12,2) as "f__amount",
	BankSubsidiaryCardsId::VARCHAR(512) as "r__banksubsidiarycards",
	InvoiceId::VARCHAR(512) as "r__invoices_attr",
	TenantId::VARCHAR(128) as x__client_id
FROM out_CCTransaction
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_CCTransaction')
;