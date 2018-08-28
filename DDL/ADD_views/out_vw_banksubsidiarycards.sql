CREATE OR REPLACE VIEW out_vw_banksubsidiarycards AS
SELECT
	CardHolder::VARCHAR(512) as "a__cardholder",
	Number::VARCHAR(512) as "a__last4digits",
	BankSubsidiaryCardsId::VARCHAR(512) as "cp__banksubsidiarycardid",
	BanksId::VARCHAR(512) as "r__banks",
	TenantId::VARCHAR(128) as x__client_id
FROM out_BankSubsidiaryCards
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_BankSubsidiaryCards')
;