CREATE OR REPLACE VIEW out_vw_accountusersecurity AS
SELECT
	(CASE WHEN (t.UsersId IS NULL) THEN ''::varchar ELSE (t.UsersId)::varchar END)::VARCHAR(512) as "a__userid",
	(CASE WHEN (concat(concat((t.UsersId)::varchar, '#'::varchar(1)), (t.AccountId)::varchar) IS NULL) THEN ''::varchar ELSE concat(concat((t.UsersId)::varchar, '#'::varchar(1)), (t.AccountId)::varchar) END)::VARCHAR(512) as "cp__accountusersecurityid",
	(CASE WHEN (t.AccountId IS NULL) THEN ''::varchar ELSE (t.AccountId)::varchar END)::VARCHAR(512) as "r__accounts",
	t.TenantId::VARCHAR(128) as x__client_id
FROM stg_csv_AccountUserSecurity_merge t
WHERE (t.Deleted = false)
UNION ALL
SELECT
	(CASE WHEN (u.UserId IS NULL) THEN ''::varchar ELSE (u.UserId)::varchar END)::VARCHAR(512) as "a__userid",
	(CASE WHEN (concat(concat((u.UserId)::varchar, '#'::varchar(1)), '-1'::varchar(20)) IS NULL) THEN ''::varchar ELSE concat(concat((u.UserId)::varchar, '#'::varchar(1)), '-1'::varchar(20)) END)::VARCHAR(512) as "cp__accountusersecurityid",
	'-1'::VARCHAR(512) as "r__accounts",
	u.TenantId::VARCHAR(128) as x__client_id
FROM stg_csv_User_merge u
WHERE (u._sys_is_deleted = false)
;