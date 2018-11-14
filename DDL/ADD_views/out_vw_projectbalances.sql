CREATE OR REPLACE VIEW out_vw_projectbalances AS
SELECT
	EncumberanceType::VARCHAR(512) as "a__encumberancetype",
	PostStatus::VARCHAR(512) as "a__poststatus",
	ProjectBalanceId::VARCHAR(512) as "cp__projectbalanceid",
	AddBalance::NUMERIC(12,2) as "f__addbalance",
	Balance::NUMERIC(12,2) as "f__balance",
	AccountId::VARCHAR(512) as "r__accounts",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	ProjectId::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
FROM out_ProjectBalance
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectBalance')
;