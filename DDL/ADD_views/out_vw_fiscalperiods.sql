CREATE OR REPLACE VIEW out_vw_fiscalperiods AS
SELECT
	''::VARCHAR(512) as "a__fiscalperiodend",
	''::VARCHAR(512) as "a__fiscalperiodstart",
	FiscalYearEnd::VARCHAR(512) as "a__fiscalyearend",
	FiscalYearId::VARCHAR(512) as "a__fiscalyearid",
	FiscalYearName::VARCHAR(512) as "a__fiscalyearname",
	FiscalYearStart::VARCHAR(512) as "a__fiscalyearstart",
	FiscalYearStatus::VARCHAR(512) as "a__fiscalyearstatus",
	NumberOfPeriods::VARCHAR(512) as "a__numberofperiods",
	Sequence::VARCHAR(512) as "a__sequence",
	FiscalPeriodId::VARCHAR(512) as "cp__fiscalperiodid",
	(CASE WHEN ((out_FiscalPeriods.FiscalDate)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_FiscalPeriods.FiscalDate)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_FiscalPeriods.FiscalDate)::date END)::DATE as "d__fiscaldate",
	(CASE WHEN ((out_FiscalPeriods.FiscalPeriodStart)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_FiscalPeriods.FiscalPeriodStart)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_FiscalPeriods.FiscalPeriodStart)::date END)::DATE as "d__fiscaldate1",
	(CASE WHEN ((out_FiscalPeriods.FiscalPeriodEnd)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_FiscalPeriods.FiscalPeriodEnd)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_FiscalPeriods.FiscalPeriodEnd)::date END)::DATE as "d__fiscaldate11",
	(CASE WHEN ((out_FiscalPeriods.FiscalYearStart)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_FiscalPeriods.FiscalYearStart)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_FiscalPeriods.FiscalYearStart)::date END)::DATE as "d__fiscalyearstart",
	(CASE WHEN ((out_FiscalPeriods.FiscalYearEnd)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_FiscalPeriods.FiscalYearEnd)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_FiscalPeriods.FiscalYearEnd)::date END)::DATE as "d__fiscalyearstart1",
	FiscalPeriodStart_sort::VARCHAR(512) as "l__fiscalperiodstart__fiscalperiodstart_sort",
	FiscalYearStart_sort::VARCHAR(512) as "l__fiscalyearstart__fiscalyearstart_sort",
	TenantId::VARCHAR(128) as x__client_id
FROM out_FiscalPeriods
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_FiscalPeriods')

UNION ALL

SELECT
    GoodData_Attr('')  AS "a__fiscalperiodend",
    GoodData_Attr('')  AS "a__fiscalperiodstart",
    GoodData_Attr('')  AS "a__fiscalyearend",
    GoodData_Attr('')  AS "a__fiscalyearid",
    GoodData_Attr('')  AS "a__fiscalyearname",
    GoodData_Attr('')  AS "a__fiscalyearstart",
    GoodData_Attr('')  AS "a__fiscalyearstatus",
    GoodData_Attr('')  AS "a__numberofperiods",
    GoodData_Attr('')  AS "a__sequence",
    GoodData_Attr('0') AS "cp__fiscalperiodid",
    NULL::DATE  			 AS "d__fiscaldate",
    NULL::DATE  			 AS "d__fiscaldate1",
    NULL::DATE  			 AS "d__fiscaldate11",
    NULL::DATE  			 AS "d__fiscalyearstart",
		NULL::DATE  			 AS "d__fiscalyearstart1",
		GoodData_Attr('')  AS "l__fiscalperiodstart__fiscalperiodstart_sort",
		GoodData_Attr('')  AS "l__fiscalyearstart__fiscalyearstart_sort",
		TenantId::VARCHAR(128) AS x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;