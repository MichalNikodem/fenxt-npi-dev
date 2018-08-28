CREATE OR REPLACE VIEW out_vw_bankusersecurity AS
SELECT
	UserId::VARCHAR(512) as "a__bankusersecurityuserid",
	BankUserSecurityId::VARCHAR(512) as "cp__bankusersecurityid",
	BankId::VARCHAR(512) as "r__banks",
	TenantId::VARCHAR(128) as x__client_id
FROM out_BankUserSecurity
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_BankUserSecurity')
;