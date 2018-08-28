CREATE OR REPLACE VIEW out_vw_arclients AS
SELECT
	au.Name::VARCHAR(512) as "a__arclientaddedbyusername",
	ARClientCFDANumber::VARCHAR(512) as "a__arclientcfdanumber",
	ARClientDisplayName::VARCHAR(512) as "a__arclientdisplayname",
	ARClientType::VARCHAR(512) as "a__clienttype",
	ARClientId::VARCHAR(512) as "cp__arclientid",
	Gooddata_Date((CASE WHEN ((ar.dateadded)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((ar.dateadded)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (ar.dateadded)::date END)::date)::DATE as "d__dateadded",
	Gooddata_Date((CASE WHEN ((ar.datechanged)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((ar.datechanged)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (ar.datechanged)::date END)::date)::DATE as "d__datechanged",
	Amount::NUMERIC(12,2) as "f__arclientpaymentamount",
	ar.TenantId::VARCHAR(128) as x__client_id
FROM out_arclients ar
join stg_csv_user_merge au
	on ar.AddedByUserId = au.UserId and ar.TenantId = au.TenantId
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ARClients')
;
